#!/bin/bash
echo "=== 开始重新构建和部署 ==="

# 清理旧构建
echo "清理旧构建..."
rm -rf public/ resources/ .hugo_build.lock

# 重新构建
echo "重新构建网站..."
hugo --buildFuture --cleanDestinationDir --minify

# 验证新文章
echo "验证新文章..."
if [ -f "public/p/置身事内/index.html" ]; then
    echo "✅ 新文章《置身事内》已成功构建"
else
    echo "❌ 构建失败：新文章未找到"
    exit 1
fi

# 提交和推送
echo "提交更改..."
git add .
git commit -m "重新构建网站：$(date '+%Y-%m-%d %H:%M:%S')"
git push -f origin main

echo "=== 完成！请等待GitHub Pages更新 ==="
