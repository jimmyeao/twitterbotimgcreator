@{
'ContextMenuStrip1.TrayLocation' = New-Object -TypeName System.Drawing.Point -ArgumentList @(145, 17)
'StatusStrip1.TrayLocation' = New-Object -TypeName System.Drawing.Point -ArgumentList @(17, 17)
'PictureBox1.InitialImage' = New-Object -TypeName System.Drawing.Bitmap -ArgumentList @(New-Object -TypeName  System.IO.MemoryStream -ArgumentList @(,[System.Convert]::FromBase64String('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')))
'PictureBox1.BackgroundImage' = New-Object -TypeName System.Drawing.Bitmap -ArgumentList @(New-Object -TypeName  System.IO.MemoryStream -ArgumentList @(,[System.Convert]::FromBase64String('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')))
'ContextMenuStrip2.TrayLocation' = New-Object -TypeName System.Drawing.Point -ArgumentList @(316, 17)
}
