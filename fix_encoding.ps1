$html = Get-Content -Path 'E:\miclaw\project\liubai-radio\index.html' -Raw -Encoding UTF8
$html = $html.Replace('鎴愬姛瀵煎叆 ', '成功导入 ')
$html = $html.Replace('涓功绛?', '个书签')
$html = $html.Replace('鏈壘鍒板彲瀵煎叆鐨勪功绛?', '未找到可导入的书签')
Set-Content -Path 'E:\miclaw\project\liubai-radio\index.html' -Value $html -Encoding UTF8
Write-Output 'SUCCESS'
