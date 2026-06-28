$html = Get-Content -Path 'E:\miclaw\project\liubai-radio\index.html' -Raw -Encoding UTF8

# Find and replace the broken section
$oldSection = @"
            if (imported > 0) {
                renderBookmarks();
                showToast('�ɹ����� ' + imported + ' 个书�?);
            } else {
                showToast('未找到可导入的书�?);
            }
"@

$newSection = @"
            if (imported > 0) {
                renderBookmarks();
                showToast('成功导入 ' + imported + ' 个书签');
            } else {
                showToast('未找到可导入的书签');
            }
"@

$html = $html.Replace($oldSection, $newSection)
Set-Content -Path 'E:\miclaw\project\liubai-radio\index.html' -Value $html -Encoding UTF8
Write-Output 'SUCCESS'
