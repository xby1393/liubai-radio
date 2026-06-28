$html = Get-Content -Path 'E:\miclaw\project\liubai-radio\index.html' -Raw -Encoding UTF8
$js = @'

        // === 书签导入功能 ===
        function triggerBookmarkImport() {
            document.getElementById('bookmarkFileInput').click();
        }

        function handleBookmarkFile(event) {
            const file = event.target.files[0];
            if (!file) return;
            
            const reader = new FileReader();
            reader.onload = function(e) {
                const content = e.target.result;
                parseAndImportBookmarks(content);
            };
            reader.readAsText(file);
            
            // Reset input so same file can be imported again
            event.target.value = '';
        }

        function parseAndImportBookmarks(htmlContent) {
            const parser = new DOMParser();
            const doc = parser.parseFromString(htmlContent, 'text/html');
            
            // Try to find links in the document
            const links = doc.querySelectorAll('a[href]');
            let imported = 0;
            
            links.forEach(link => {
                const url = link.href;
                const name = link.textContent.trim() || link.getAttribute('title') || url;
                
                // Skip empty or invalid URLs
                if (!url || url === 'about:blank' || url.startsWith('javascript:')) return;
                
                // Skip duplicates
                if (bookmarks.some(b => b.url === url)) return;
                
                // Try to get icon from favicon or first emoji/text
                let icon = '🔗';
                const img = link.querySelector('img');
                if (img && img.src) {
                    icon = '<img src="' + img.src + '" style="width:24px;height:24px;object-fit:contain">';
                } else {
                    // Use first emoji or first character
                    const text = link.textContent.trim();
                    const emojiMatch = text.match(/\p{Emoji}/u);
                    if (emojiMatch) {
                        icon = emojiMatch[0];
                    } else if (text.length > 0) {
                        icon = text.charAt(0).toUpperCase();
                    }
                }
                
                const bookmark = {
                    id: 'bm_' + Date.now() + '_' + Math.random().toString(36).slice(2, 6),
                    name: name.substring(0, 50),
                    url: url,
                    icon: icon,
                    createdAt: new Date().toISOString()
                };
                
                bookmarks.push(bookmark);
                saveBookmarkToDB(bookmark);
                imported++;
            });
            
            if (imported > 0) {
                renderBookmarks();
                showToast('成功导入 ' + imported + ' 个书签');
            } else {
                showToast('未找到可导入的书签');
            }
        }
'@

$html = $html.Replace('    </script>', $js + "`n    </script>")
Set-Content -Path 'E:\miclaw\project\liubai-radio\index.html' -Value $html -Encoding UTF8
Write-Output 'SUCCESS'
