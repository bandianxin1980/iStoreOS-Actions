@echo off
REM ============================================
REM BD-ONE iStoreOS 精简包清理脚本
REM 运行位置：iStoreOS-Actions 仓库根目录
REM ============================================

echo.
echo ============================================
echo  BD-ONE iStoreOS 精简包清理
echo ============================================
echo.
echo 此脚本将删除以下多余插件：
echo   - luci-app-adguardhome  (广告拦截，臃肿)
echo   - luci-app-lucky        (不需要)
echo   - luci-app-openlist2    (不需要)
echo   - luci-app-filebrowser   (不需要)
echo   - luci-app-ramfree       (不需要)
echo   - other-rely             (其他依赖)
echo.
echo 同时将修改 arm64/build24.sh：
echo   - 注释掉 luci-app-amlogic
echo   - 注释掉 luci-app-ramfree
echo.
set /p CONFIRM=确认删除？(Y/N):
if /i not "%CONFIRM%"=="Y" goto :EOF

echo.
echo [1/2] 删除多余插件目录...
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
echo [2/2] 修改 arm64\build24.sh（注释掉多余包）...
echo.

REM 备份原文件
copy "arm64\build24.sh" "arm64\build24.sh.bak" >nul

REM 注释掉 amlogic 插件（第 1048 行附近）
powershell -Command "(Get-Content 'arm64\build24.sh') -replace 'PACKAGES=\"\"\$PACKAGES luci-app-amlogic', '#PACKAGES=\"\"\$PACKAGES luci-app-amlogic' | Set-Content 'arm64\build24.sh'"

REM 注释掉 ramfree 插件（第 1049 行附近）
powershell -Command "(Get-Content 'arm64\build24.sh') -replace 'PACKAGES=\"\"\$PACKAGES luci-app-ramfree', '#PACKAGES=\"\"\$PACKAGES luci-app-ramfree' | Set-Content 'arm64\build24.sh'"

echo   [OK] build24.sh 已修改

echo.
echo ============================================
echo  完成！
echo ============================================
echo.
echo 下一步：
echo   1. 提交修改：git add . ^&^& git commit -m ^"BD-ONE slim^" ^&^& git push
echo   2. 运行 St1 workflow
echo   3. 运行 St2 workflow（选择 bdkj-bd-one）
echo.
pause
