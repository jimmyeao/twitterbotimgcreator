##

# Script to help create twityterbot images.js file

##

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
$result = Find-Folders
Write-Host "You chose " $result -ForegroundColor Green
write-host "Enumerating images.." -ForegroundColor Yellow
$list = Get-ChildItem -Path $result -Recurse | `
        Where-Object {$_.Extension -eq '.jpg' }
$htags = read-host "Enter hash tags seperated by a space e,g, #now #photos"
$sourcecredit = read-host "Enter text for source credit and other text, can include links"
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
$line | Out-File $path
