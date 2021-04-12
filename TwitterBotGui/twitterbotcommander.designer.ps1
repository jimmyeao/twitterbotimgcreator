$Form1 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$btn_source = $null
[System.Windows.Forms.Button]$btn_dest = $null
[System.Windows.Forms.PictureBox]$pb_main = $null
[System.Windows.Forms.ListBox]$lb_loadedimages = $null
[System.Windows.Forms.TextBox]$tb_hashtags = $null
[System.Windows.Forms.RichTextBox]$rt_text = $null
[System.Windows.Forms.Label]$hashtags = $null
[System.Windows.Forms.Label]$Label2 = $null
[System.Windows.Forms.Button]$btn_applyto1 = $null
[System.Windows.Forms.Button]$btn_applytoall = $null
[System.Windows.Forms.Button]$btn_generate = $null
[System.Windows.Forms.StatusStrip]$StatusStrip1 = $null
[System.Windows.Forms.ToolStripProgressBar]$ToolStripProgressBar1 = $null
[System.Windows.Forms.CheckBox]$cb_resize = $null
[System.Windows.Forms.TextBox]$tb_source = $null
[System.Windows.Forms.TextBox]$tb_dest = $null
[System.Windows.Forms.Button]$btn_save = $null
[System.Windows.Forms.Button]$btn_load = $null
function InitializeComponent
{
$btn_source = (New-Object -TypeName System.Windows.Forms.Button)
$btn_dest = (New-Object -TypeName System.Windows.Forms.Button)
$pb_main = (New-Object -TypeName System.Windows.Forms.PictureBox)
$lb_loadedimages = (New-Object -TypeName System.Windows.Forms.ListBox)
$tb_hashtags = (New-Object -TypeName System.Windows.Forms.TextBox)
$rt_text = (New-Object -TypeName System.Windows.Forms.RichTextBox)
$hashtags = (New-Object -TypeName System.Windows.Forms.Label)
$Label2 = (New-Object -TypeName System.Windows.Forms.Label)
$btn_applyto1 = (New-Object -TypeName System.Windows.Forms.Button)
$btn_applytoall = (New-Object -TypeName System.Windows.Forms.Button)
$btn_generate = (New-Object -TypeName System.Windows.Forms.Button)
$StatusStrip1 = (New-Object -TypeName System.Windows.Forms.StatusStrip)
$ToolStripProgressBar1 = (New-Object -TypeName System.Windows.Forms.ToolStripProgressBar)
$cb_resize = (New-Object -TypeName System.Windows.Forms.CheckBox)
$tb_source = (New-Object -TypeName System.Windows.Forms.TextBox)
$tb_dest = (New-Object -TypeName System.Windows.Forms.TextBox)
$btn_save = (New-Object -TypeName System.Windows.Forms.Button)
$btn_load = (New-Object -TypeName System.Windows.Forms.Button)
([System.ComponentModel.ISupportInitialize]$pb_main).BeginInit()
$StatusStrip1.SuspendLayout()
$Form1.SuspendLayout()
#
#btn_source
#
$btn_source.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]26,[System.Int32]27))
$btn_source.Name = [System.String]'btn_source'
$btn_source.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]140,[System.Int32]23))
$btn_source.TabIndex = [System.Int32]0
$btn_source.Text = [System.String]'Select Source Folder'
$btn_source.UseCompatibleTextRendering = $true
$btn_source.UseVisualStyleBackColor = $true
$btn_source.add_Click($sel_source)
#
#btn_dest
#
$btn_dest.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]26,[System.Int32]69))
$btn_dest.Name = [System.String]'btn_dest'
$btn_dest.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]140,[System.Int32]23))
$btn_dest.TabIndex = [System.Int32]1
$btn_dest.Text = [System.String]'Select Dest. Folder'
$btn_dest.UseCompatibleTextRendering = $true
$btn_dest.UseVisualStyleBackColor = $true
$btn_dest.add_Click($sel_dest)
#
#pb_main
#
$pb_main.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]508,[System.Int32]27))
$pb_main.Name = [System.String]'pb_main'
$pb_main.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]397,[System.Int32]193))
$pb_main.TabIndex = [System.Int32]2
$pb_main.TabStop = $false
#
#lb_loadedimages
#
$lb_loadedimages.FormattingEnabled = $true
$lb_loadedimages.ItemHeight = [System.Int32]17
$lb_loadedimages.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]507,[System.Int32]248))
$lb_loadedimages.Name = [System.String]'lb_loadedimages'
$lb_loadedimages.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]398,[System.Int32]259))
$lb_loadedimages.TabIndex = [System.Int32]3
#
#tb_hashtags
#
$tb_hashtags.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]32,[System.Int32]163))
$tb_hashtags.Name = [System.String]'tb_hashtags'
$tb_hashtags.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]447,[System.Int32]24))
$tb_hashtags.TabIndex = [System.Int32]4
#
#rt_text
#
$rt_text.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]32,[System.Int32]222))
$rt_text.Name = [System.String]'rt_text'
$rt_text.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]446,[System.Int32]165))
$rt_text.TabIndex = [System.Int32]5
$rt_text.Text = [System.String]''
#
#hashtags
#
$hashtags.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]32,[System.Int32]137))
$hashtags.Name = [System.String]'hashtags'
$hashtags.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$hashtags.TabIndex = [System.Int32]6
$hashtags.Text = [System.String]'Hashtags:'
$hashtags.UseCompatibleTextRendering = $true
#
#Label2
#
$Label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]32,[System.Int32]197))
$Label2.Name = [System.String]'Label2'
$Label2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$Label2.TabIndex = [System.Int32]7
$Label2.Text = [System.String]'Text:'
$Label2.UseCompatibleTextRendering = $true
#
#btn_applyto1
#
$btn_applyto1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]32,[System.Int32]418))
$btn_applyto1.Name = [System.String]'btn_applyto1'
$btn_applyto1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]156,[System.Int32]23))
$btn_applyto1.TabIndex = [System.Int32]8
$btn_applyto1.Text = [System.String]'Apply to 1'
$btn_applyto1.UseCompatibleTextRendering = $true
$btn_applyto1.UseVisualStyleBackColor = $true
$btn_applyto1.add_Click($app_to1)
#
#btn_applytoall
#
$btn_applytoall.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]194,[System.Int32]418))
$btn_applytoall.Name = [System.String]'btn_applytoall'
$btn_applytoall.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]147,[System.Int32]23))
$btn_applytoall.TabIndex = [System.Int32]9
$btn_applytoall.Text = [System.String]'Apply to all'
$btn_applytoall.UseCompatibleTextRendering = $true
$btn_applytoall.UseVisualStyleBackColor = $true
$btn_applytoall.add_Click($app_toall)
#
#btn_generate
#
$btn_generate.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]32,[System.Int32]470))
$btn_generate.Name = [System.String]'btn_generate'
$btn_generate.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]156,[System.Int32]23))
$btn_generate.TabIndex = [System.Int32]10
$btn_generate.Text = [System.String]'Generate'
$btn_generate.UseCompatibleTextRendering = $true
$btn_generate.UseVisualStyleBackColor = $true
$btn_generate.add_Click($btn_gen)
#
#StatusStrip1
#
$StatusStrip1.Items.AddRange([System.Windows.Forms.ToolStripItem[]]@($ToolStripProgressBar1))
$StatusStrip1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]518))
$StatusStrip1.Name = [System.String]'StatusStrip1'
$StatusStrip1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]917,[System.Int32]22))
$StatusStrip1.TabIndex = [System.Int32]11
$StatusStrip1.Text = [System.String]'StatusStrip1'
#
#ToolStripProgressBar1
#
$ToolStripProgressBar1.Name = [System.String]'ToolStripProgressBar1'
$ToolStripProgressBar1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]16))
#
#cb_resize
#
$cb_resize.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]209,[System.Int32]470))
$cb_resize.Name = [System.String]'cb_resize'
$cb_resize.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$cb_resize.TabIndex = [System.Int32]12
$cb_resize.Text = [System.String]'Resize?'
$cb_resize.UseCompatibleTextRendering = $true
$cb_resize.UseVisualStyleBackColor = $true
#
#tb_source
#
$tb_source.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]172,[System.Int32]27))
$tb_source.Name = [System.String]'tb_source'
$tb_source.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]307,[System.Int32]24))
$tb_source.TabIndex = [System.Int32]13
#
#tb_dest
#
$tb_dest.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]172,[System.Int32]68))
$tb_dest.Name = [System.String]'tb_dest'
$tb_dest.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]307,[System.Int32]24))
$tb_dest.TabIndex = [System.Int32]14
#
#btn_save
#
$btn_save.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]294,[System.Int32]470))
$btn_save.Name = [System.String]'btn_save'
$btn_save.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]145,[System.Int32]23))
$btn_save.TabIndex = [System.Int32]15
$btn_save.Text = [System.String]'Save Current Details'
$btn_save.UseCompatibleTextRendering = $true
$btn_save.UseVisualStyleBackColor = $true
$btn_save.add_Click($save_details)
#
#btn_load
#
$btn_load.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]294,[System.Int32]492))
$btn_load.Name = [System.String]'btn_load'
$btn_load.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]145,[System.Int32]23))
$btn_load.TabIndex = [System.Int32]16
$btn_load.Text = [System.String]'Load Current Details'
$btn_load.UseCompatibleTextRendering = $true
$btn_load.UseVisualStyleBackColor = $true
$btn_load.add_Click($load_details)
#
#Form1
#
$Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]917,[System.Int32]540))
$Form1.Controls.Add($btn_load)
$Form1.Controls.Add($btn_save)
$Form1.Controls.Add($tb_dest)
$Form1.Controls.Add($tb_source)
$Form1.Controls.Add($cb_resize)
$Form1.Controls.Add($StatusStrip1)
$Form1.Controls.Add($btn_generate)
$Form1.Controls.Add($btn_applytoall)
$Form1.Controls.Add($btn_applyto1)
$Form1.Controls.Add($Label2)
$Form1.Controls.Add($hashtags)
$Form1.Controls.Add($rt_text)
$Form1.Controls.Add($tb_hashtags)
$Form1.Controls.Add($lb_loadedimages)
$Form1.Controls.Add($pb_main)
$Form1.Controls.Add($btn_dest)
$Form1.Controls.Add($btn_source)
$Form1.Text = [System.String]'Twitter Bot Commander'
([System.ComponentModel.ISupportInitialize]$pb_main).EndInit()
$StatusStrip1.ResumeLayout($false)
$StatusStrip1.PerformLayout()
$Form1.ResumeLayout($false)
$Form1.PerformLayout()
Add-Member -InputObject $Form1 -Name base -Value $base -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name btn_source -Value $btn_source -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name btn_dest -Value $btn_dest -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name pb_main -Value $pb_main -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lb_loadedimages -Value $lb_loadedimages -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name tb_hashtags -Value $tb_hashtags -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name rt_text -Value $rt_text -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name hashtags -Value $hashtags -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name Label2 -Value $Label2 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name btn_applyto1 -Value $btn_applyto1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name btn_applytoall -Value $btn_applytoall -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name btn_generate -Value $btn_generate -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name StatusStrip1 -Value $StatusStrip1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name ToolStripProgressBar1 -Value $ToolStripProgressBar1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name cb_resize -Value $cb_resize -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name tb_source -Value $tb_source -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name tb_dest -Value $tb_dest -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name btn_save -Value $btn_save -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name btn_load -Value $btn_load -MemberType NoteProperty
}
. InitializeComponent
