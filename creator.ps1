##
# 2021 Jimmy White. Please feel free to re-use, modify etc for non-commercial use
# Script to help create twitterbot images.js file
# thanks to https://www.benoitpatra.com/2014/09/14/resize-image-and-preserve-ratio-with-powershell/ for the script to resize images
# Things this does:
# Optionally Resizes images to 1920 horizontally or 1080 vertically, depending on image orientation. Retains aspect ratio, original files unchanged
# Renames files to remove spaces (spaces are BAD in filenames ;) ) Original files (and resizes) are renamed
#asks for hash tags (applied to all images)
#asks for source info (applied to all images)
# parses the folder to generate an image.js file which is saved in a UNIX friendly format.


##
using namespace System.Drawing
function Find-Folders {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = "C:\"
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a directory"

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
        } else
        {
           
                #Ends script
                Exit
           
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
} 

function Resize-images{
Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] $imageSource,[Parameter(Mandatory=$True)] [ValidateNotNull()] $imageTarget,[Parameter(Mandatory=$true)][ValidateNotNull()] $quality )

if ($quality -lt 0 -or $quality -gt 100){throw( "quality must be between 0 and 100.")}

[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$bmp = [System.Drawing.Image]::FromFile($imageSource)

#hardcoded canvas size...
$canvasWidth = 1920.0
$canvasHeight = 1080.0

#Encoder parameter for image quality
$myEncoder = [System.Drawing.Imaging.Encoder]::Quality
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($myEncoder, $quality)
# get codec
$myImageCodecInfo = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|Where-Object {$_.MimeType -eq 'image/jpeg'}

#compute the final ratio to use
$ratioX = $canvasWidth / $bmp.Width;
$ratioY = $canvasHeight / $bmp.Height;
$ratio = $ratioY
if($ratioX -le $ratioY){
  $ratio = $ratioX
}

#create resized bitmap
$newWidth = [int] ($bmp.Width*$ratio)
$newHeight = [int] ($bmp.Height*$ratio)
$bmpResized = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
$graph = [System.Drawing.Graphics]::FromImage($bmpResized)

$graph.Clear([System.Drawing.Color]::White)
$graph.DrawImage($bmp,0,0 , $newWidth, $newHeight)

#save to file
$bmpResized.Save($imageTarget,$myImageCodecInfo, $($encoderParams))
$graph.Dispose()
$bmpResized.Dispose()
$bmp.Dispose()
}
$result = Find-Folders
Write-Host "You chose " $result -ForegroundColor Green
write-host "Enumerating images.." -ForegroundColor Yellow

$htags = read-host "Enter hash tags seperated by a space e,g, #now #photos"
$sourcecredit = read-host "Enter text for source credit and other text, can include links"
$resizethem = read-host "Resize images? (Y/N)"
if($resizethem -eq "y"){
    $outpath = New-Item -Path $result -Name "twitterbot images" -ItemType "directory"
    Get-ChildItem $result -Recurse -Include *.jpg | Foreach-Object{
        $newName = $result+"\"+$outpath.name+"\"+$_.Name.Substring(0, $_.Name.Length - 4) + "_resized.jpg"
        Resize-images -imagesource $_.FullName -imagetarget $newName -quality 75
        
    }

    $newpath = $result+"\"+$outpath.name+"\"
    Get-ChildItem -path $newpath | Rename-Item -NewName { $_.Name -replace ' ','_' }
    $list = Get-ChildItem -Path $newpath -Recurse | `
            Where-Object {$_.FullName -match '_resized.jpg' }
    }
    else {
        Get-ChildItem -path $result | Rename-Item -NewName { $_.Name -replace ' ','_' }
        $list = Get-ChildItem -Path $result -Recurse | `
            Where-Object {$_.Extension -eq '.jpg'}
    }
write-host "creating images.js file" -ForegroundColor Cyan
#check and see if file exists, if it does, replace it
$path = $result+"\images.js"
if(Test-Path -Path $path -PathType Leaf){
   
        Remove-Item $path -Force

}
$line=@()
$line += "const images = ["
$numimages = $list.count
$strt = 1

foreach($image in $list)
{

    $line += "  {"
    $line += "      file: '$image',"
    $line += "      source: '$htags $sourcecredit'"
    if($strt -ne $numimages){
        $line += "  },"
    }else {
        $line += "  }"
    }
    $strt++
}
$line += "];"
$line += "module.exports = images;"

$line | Out-File $path -Encoding UTF8

write-host "all done - copy file to your images folder"
write-host "and copy your images.js file" -ForegroundColor green
