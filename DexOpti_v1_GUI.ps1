
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# إعداد النموذج الرئيسي
$form = New-Object System.Windows.Forms.Form
$form.Text = "Dex Opti v1"
$form.Size = New-Object System.Drawing.Size(600, 500)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# إضافة صورة الشعار
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.ImageLocation = "logo.jpg"
$pictureBox.SizeMode = "Zoom"
$pictureBox.Size = New-Object System.Drawing.Size(120,120)
$pictureBox.Location = New-Object System.Drawing.Point(235, 10)
$form.Controls.Add($pictureBox)

# عنوان
$label = New-Object System.Windows.Forms.Label
$label.Text = "Dex Opti - Windows Performance Tweaks"
$label.AutoSize = $true
$label.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$label.Location = New-Object System.Drawing.Point(130, 140)
$form.Controls.Add($label)

# منطقة التبديل للأزرار
$y = 180
function Add-ActionButton($text, $action) {
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $text
    $button.Size = New-Object System.Drawing.Size(400, 30)
    $button.Location = New-Object System.Drawing.Point(100, $y)
    $button.Add_Click({
        try {
            & $action.Invoke()
            [System.Windows.Forms.MessageBox]::Show(("تم تنفيذ '{0}' بنجاح" -f $text))
        } catch {
            [System.Windows.Forms.MessageBox]::Show(("حدث خطأ أثناء تنفيذ '{0}'" -f $text))
        }
    })
    $form.Controls.Add($button)
    $script:y += 40
}

# الإجراءات الأصلية
$actions = @(
    @{ Name = "تعطيل الشفافية"; Action = { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 } }
    @{ Name = "تعطيل مؤثرات الرسوم"; Action = { Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "0" } }
    @{ Name = "ضبط الأداء لأفضل أداء"; Action = { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 } }
    @{ Name = "تعطيل Windows Search"; Action = { Stop-Service WSearch -Force -ErrorAction SilentlyContinue; Set-Service WSearch -StartupType Disabled } }
    @{ Name = "تعطيل Superfetch (SysMain)"; Action = { Stop-Service SysMain -Force -ErrorAction SilentlyContinue; Set-Service SysMain -StartupType Disabled } }
)

foreach ($a in $actions) {
    Add-ActionButton $a.Name $a.Action
}

# عرض النموذج
[void]$form.ShowDialog()
