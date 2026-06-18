@echo off
rem ------------------------------------------------------------
rem   Build the MiMo‑Code CLI binary (mimo.exe)
rem ------------------------------------------------------------

rem 1️⃣  Disable strict SSL for the one problematic git dependency.
rem     (Only needed the first time; safe on a trusted network.)
git config --global http.sslVerify false

rem 2️⃣  Install all project dependencies (runs once, then is cached).
bun install

rem 3️⃣  Build **only** the Windows‑x64 binary.
rem     --skip-install   : skip re‑installing @opentui/core & @parcel/watcher
rem     --single          : restrict the build to the current OS/arch
pushd packages\opencode
bun run build --skip-install --single
popd

rem 4️⃣  Where the binary ends up:
set EXE_PATH=packages\opencode\dist\mimocode-windows-x64\bin\mimo.exe
if exist "%EXE_PATH%" (
    echo.
    echo ✅  Build succeeded – binary is:
    echo    %CD%\%EXE_PATH%
) else (
    echo.
    echo ❌  Build failed – %EXE_PATH% not found.
)

rem ------------------------------------------------------------
rem   Optional: copy the exe to a location that is on your PATH
rem   copy "%EXE_PATH%" "C:\Tools\mimo.exe"
rem ------------------------------------------------------------