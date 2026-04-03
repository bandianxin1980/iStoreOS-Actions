@echo off
chcp 65001 >nul
cd /d D:\iStoreOS-Actions

echo ============================================
echo  BD-ONE iStoreOS 精简包清理
echo ============================================
echo.

echo [1/3] 删除多余插件目录...
echo.

if exist "files\packages\luci-app-adguardhome" (
    rd /s /q "files\packages\luci-app-adguardhome"
    echo   [OK] luci-app-adguardhome 已删除
) else (
    echo   [--] luci-app-adguardhome 不存在，跳过
)

if exist "files\packages\luci-app-lucky" (
    rd /s /q "files\packages\luci-app-lucky"
    echo   [OK] luci-app-lucky 已删除
) else (
    echo   [--] luci-app-lucky 不存在，跳过
)

if exist "files\packages\luci-app-openlist2" (
    rd /s /q "files\packages\luci-app-openlist2"
    echo   [OK] luci-app-openlist2 已删除
) else (
    echo   [--] luci-app-openlist2 不存在，跳过
)

if exist "files\packages\luci-app-filebrowser" (
    rd /s /q "files\packages\luci-app-filebrowser"
    echo   [OK] luci-app-filebrowser 已删除
) else (
    echo   [--] luci-app-filebrowser 不存在，跳过
)

if exist "files\packages\luci-app-ramfree" (
    rd /s /q "files\packages\luci-app-ramfree"
    echo   [OK] luci-app-ramfree 已删除
) else (
    echo   [--] luci-app-ramfree 不存在，跳过
)

if exist "files\packages\other-rely" (
    rd /s /q "files\packages\other-rely"
    echo   [OK] other-rely 已删除
) else (
    echo   [--] other-rely 不存在，跳过
)

echo.
echo [2/3] 修改 arm64\build24.sh（注释多余包）...
echo.

rem 备份原文件
copy "arm64\build24.sh" "arm64\build24.sh.bak" >nul 2>&1

rem 使用 findstr 来注释行（兼容性好）
powershell -NoProfile -Command "(Get-Content 'arm64\build24.sh' -Raw) -replace 'PACKAGES=\"\"\$PACKAGES luci-app-amlogic', '#PACKAGES=\"\"\$PACKAGES luci-app-amlogic' -replace 'PACKAGES=\"\"\$PACKAGES luci-app-ramfree', '#PACKAGES=\"\"\$PACKAGES luci-app-ramfree' | Set-Content -NoNewline 'arm64\build24.sh'"

echo   [OK] build24.sh 已修改

echo.
echo [3/3] 删除备份文件（可选）...
if exist "arm64\build24.sh.bak" (
    del "arm64\build24.sh.bak"
    echo   [OK] 备份已删除
)

echo.
echo ============================================
echo  完成！
echo ============================================
echo.
echo 下一步请运行:
echo   cd /d D:\iStoreOS-Actions
echo   git add .
echo   git commit -m "BD-ONE slim"
echo   git push
echo.
pause
