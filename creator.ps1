##
# 2021 Jimmy White. Please feel free to re-use, modify etc for non-commercial use
# Script to help create twityterbot images.js file
# thanks to https://www.benoitpatra.com/2014/09/14/resize-image-and-preserve-ratio-with-powershell/ for the script to resize images
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
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                return
            }
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
$myImageCodecInfo = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()|where {$_.MimeType -eq 'image/jpeg'}

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
    Get-ChildItem -path $newpath -Filter "*'*" -Recurse | Rename-Item -NewName {$_.Name.Replace("'","")}
    $list = Get-ChildItem -Path $newpath -Recurse | `
            Where-Object {$_.FullName -match '_resized.jpg' }
    }
    else {
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
write-host "Then you may need to run this command to remove extra chars from filenames if you have single quotes on them after upload"
write-host "cd images" -ForegroundColor cyan
$msg = 'for file in *.jpg; do dest="${file//[[:space:]]/.}" && mv -i "$file" "${dest//[^[:alnum:]._-]/}"; done'
write-host $msg -ForegroundColor cyan
