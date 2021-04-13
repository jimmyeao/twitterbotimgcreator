<#
This script creates a GUI form for managing tag and text for photos for upload to twitter (currently a seperate application)
thanks to https://www.benoitpatra.com/2014/09/14/resize-image-and-preserve-ratio-with-powershell/ for the script to resize images
Jimmy White 2021

#>
$global:photodetails = @()
$lb_Item_selected = {

    $selected = $tb_source.text+"\"+$lb_loadedimages.selecteditem
    
    $pb_main.image = [System.Drawing.Image]::Fromfile($selected)
    if($global:photodetails | Where-Object name -like $lb_loadedimages.selecteditem){
        $tb_hashtags.text=""
        $rt_text.Clear()
        $tb_hashtags.text = ($global:photodetails | Where-Object name -eq $lb_loadedimages.selecteditem).hashtags
        $rt_text.Text = ($global:photodetails | Where-Object name -eq $lb_loadedimages.selecteditem).text
    }
    $Form1.Refresh()
    write-host  $selected
}



Clear-Host
$btn_gen = {
   #lets check we have a valid path
   #first part of images.js
   
   if((test-path $tb_dest.text) -eq $true){
        #we have a valid path, we continue...
        #Lets move and rename the files...
       ################################################################### 
       $max = $global:photodetails.count
       $counter = 1
        $lb_status.text = "Resizing images..."
        $form1.refresh()
            $outpath = $tb_dest.text
            Get-ChildItem $tb_source.text -Recurse -Include *.jpg | Foreach-Object{
                $percent = $counter * 100 / $max
                $ToolStripProgressBar1.value = $percent
                $newName = $outpath+"\"+$_.Name.Substring(0, $_.Name.Length - 4) +".jpg"
                Resize-images -imagesource $_.FullName -imagetarget $newName -quality 75
                $counter++
                }
            #now rename them to remove spaces. Spaces are bad!    
            $newpath = $outpath
            Get-ChildItem -path $newpath | Rename-Item -NewName { $_.Name -replace ' ','_' }
            $list = Get-ChildItem -Path $newpath -Recurse | Where-Object {$_.FullName -like '.jpg' }

        ###################################################################
        $ToolStripProgressBar1.value = 0
        $lb_status.text = "Generating images.js..."
        $line=@()
        $line += "const images = ["
        $numimages = $photodetails.count
        $strt = 1
        #now we cycle through..
        foreach ($item in $global:photodetails) {
            $realname = $item.name -replace " ","_"
            $longtext = $item.text+" "+$item.hashtags
            $line += "  {"
            $line += "      file: '$realname',"
            $line += "      source: '$longtext'"
            if($strt -ne $numimages){
                $line += "  },"
            }else {
                $line += "  }"
            }
            $strt++
        }
        $line += "];"
        $line += "module.exports = images;"
        $ouputfile = $tb_dest.text+"\images.js"
        $line | Out-File $ouputfile -Encoding UTF8
        $lb_status.text = "All Done!..."
   }
   else {
       return
   }
}
$app_toall = {
    #$photodetails = @()
    $global:photodetails.clear()
    foreach($picture in $lb_loadedimages.items){
        $item = New-Object PSObject
        $item | Add-Member -type NoteProperty -name "Name" -value $picture
        $item | Add-Member -type NoteProperty -name "Hashtags" -value $tb_hashtags.Text
        $item | Add-Member -type NoteProperty -name "text" -value $rt_text.Text
        $global:photodetails += $item
        $lb_status.text = "Applied to all!..."
        $form1.refresh()
    }
    
}
$app_to1 = {
        if($global:photodetails | Where-Object name -like $lb_loadedimages.selecteditem){
            $global:photodetails | Where-Object name -like $lb_loadedimages.selecteditem | foreach-object {$_.hashtags = $tb_hashtags.Text}
            $global:photodetails | Where-Object name -like $lb_loadedimages.selecteditem | foreach-object {$_.text = $rt_text.text}
            $lb_status.text = "Applied to " + $lb_loadedimages.selecteditem + "!..."
            $form1.refresh()
            }
            else{

        }
}
$sel_dest = {
    if($tb_source.text -eq ""){
        [System.Windows.MessageBox]::Show('Please choose a source folder first','Output Folder Error','OK','Error')
        $tb_dest.text=""
        return
    }
    $result = Find-Folders
    $tb_dest.text = $result
    if($tb_dest.text -eq $tb_source.text){
        [System.Windows.MessageBox]::Show('Output folder cannot be the same as the input folder!','Output Folder Error','OK','Error')
        $tb_dest.text=""
    }
}
$sel_source = {
    $result = Find-Folders
    $tb_source.text = $result
    $photos = Get-childitem -path $tb_source.text -Include *.jpg -name
    foreach($photo in $photos){
        $lb_loadedimages.items.add($photo)
    }
    #lets create an array to hold details on a per photo basis..
    $global:photodetails.clear()
    foreach($picture in $lb_loadedimages.items){
        $item = New-Object PSObject
        $item | Add-Member -type NoteProperty -name "Name" -value $picture
        $item | Add-Member -type NoteProperty -name "Hashtags" -value $tb_hashtags.Text
        $item | Add-Member -type NoteProperty -name "text" -value $rt_text.Text
        $global:photodetails += $item
    }
    
}
$save_details = {
    $FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{ 
    InitialDirectory = [Environment]::GetFolderPath('Desktop') 
    Filter = 'Documents (*.xml)|*.xml'
    }
    $null = $FileBrowser.ShowDialog()
   
            $XmlWriter = New-Object System.Xml.XmlTextWriter($filebrowser.filename,$null)
            $XmlWriter.Formatting="Indented"
            $XmlWriter.Indentation = 1
            $XmlWriter.IndentChar ="`t"
            $XmlWriter.WriteStartElement("Settings")
            $XmlWriter.WriteAttributeString("Hashtags",$tb_hashtags.text)
            $XmlWriter.WriteAttributeString("text",$rt_text.text)
            $XmlWriter.WriteAttributeString("source",$tb_source.text)
            $XmlWriter.WriteAttributeString("dest",$tb_dest.text)
            
            foreach($pic in $global:photodetails){
            if($null -ne $pic)
            {
                $XmlWriter.WriteStartElement("Photos")
                $XmlWriter.WriteAttributeString("name",$pic.name)
                $XmlWriter.WriteAttributeString("hashtags",$pic.hashtags)
                $XmlWriter.WriteAttributeString("text",$pic.text)
                $XmlWriter.WriteEndElement()
              }
              
        }
            
            $XmlWriter.WriteEndElement()
            #$xmlWriter.WriteEndDocument()
            $XmlWriter.Flush()
            $XmlWriter.Close()
            write-host settings saved -ForegroundColor Cyan
            
}
        

 
$load_details = {
    $curpath = get-location
    $filebrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
        InitialDirectory = $curpath
        Filter = 'Documents (*.xml)|*.xml'
    }
    $null = $filebrowser.ShowDialog()
    [xml]$ConfigFile = Get-Content $filebrowser.filename
    $tb_hashtags.text=$ConfigFile.settings.Hashtags
    $rt_text.Clear()
    $rt_text.AppendText($ConfigFile.settings.text)
    $tb_source.text = $ConfigFile.settings.source
    $tb_dest.text = $ConfigFile.settings.dest
    #$tags = $ConfigFile.settings.photos
    $form1.Refresh()
    if($tb_source.text){
        $photos = Get-childitem -path $tb_source.text -Include *.jpg -name
        foreach($photo in $photos){
            $lb_loadedimages.items.add($photo)
            $global:photodetails.clear()
        }
    }

    
    
    $global:photodetails.clear()
    $piccy=@()
    $piccy = $configfile.settings.photos
    foreach($piccy in $configfile.settings.photos){
        write-host $piccy
        $item = New-Object PSObject
        $item | Add-Member -type NoteProperty -name "Name" -value $piccy.name
        $item | Add-Member -type NoteProperty -name "Hashtags" -value $piccy.hashtags
        $item | Add-Member -type NoteProperty -name "text" -value $piccy.text
        $global:photodetails += $item
        
    }

}
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

Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'twitterbotcommander.designer.ps1')
$Form1.ShowDialog()