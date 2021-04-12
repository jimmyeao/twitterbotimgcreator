$lb_Item_selected = {

    $selected = $tb_source.text+"\"+$lb_loadedimages.selecteditem
    
    $pb_main.image = [System.Drawing.Image]::Fromfile($selected)
    $Form1.Refresh()
    write-host  $selected
}
# This does NOTHING yet accept load the form
cls
$btn_gen = {
   
}
$app_toall = {
}
$app_to1 = {
}
$sel_dest = {
    $result = Find-Folders
    $tb_dest.text = $result
}
$sel_source = {
    $result = Find-Folders
    $tb_source.text = $result
    $photos = Get-childitem -path $tb_source.text -Include *.jpg -name
    foreach($photo in $photos){
        $lb_loadedimages.items.add($photo)
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
            $XmlWriter.WriteElementString("Hashtags",$tb_hashtags.text)
            $XmlWriter.WriteElementString("text",$rt_text.text)
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
    $form1.Refresh()
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

Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'twitterbotcommander.designer.ps1')
$Form1.ShowDialog()