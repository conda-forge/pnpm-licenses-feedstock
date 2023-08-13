@echo on

md %LIBRARY_PREFIX%\share\pnpm-licenses
pushd %LIBRARY_PREFIX%\share\pnpm-licenses
md node_modules
cmd /c "npm install @quantco/pnpm-licenses@%PKG_VERSION%"
if errorlevel 1 exit 1
popd

pushd %LIBRARY_PREFIX%\bin
for %%c in (pnpm-licenses) do (
  echo @echo off >> %%c.bat
  echo "%LIBRARY_PREFIX%\share\pnpm-licenses\node_modules\.bin\%%c.cmd" %%* >> %%c.bat
)
popd

cmd /c pnpm install --prod
if errorlevel 1 exit 1

@rem test if pnpm-licenses has been installed and is executable
cmd /c pnpm-licenses help
if errorlevel 1 exit 1

@rem generate license disclaimer for pnpm-licenses itself :)
cmd /c pnpm-licenses generate-disclaimer --prod --output-file=third-party-licenses.txt
if errorlevel 1 exit 1

dir
