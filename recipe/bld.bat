@echo on

md %LIBRARY_PREFIX%\share\pnpm-licenses
pushd %LIBRARY_PREFIX%\share\pnpm-licenses
md node_modules
cmd /c "npm install --save @quantco/pnpm-licenses@%PKG_VERSION%"
if errorlevel 1 exit 1
popd

pushd %LIBRARY_PREFIX%\bin
for %%c in (pnpm) do (
  echo @echo on >> %%c.bat
  echo node %LIBRARY_PREFIX%\share\pnpm\node_modules\pnpm\bin\%%c "%%*" >> %%c.bat
popd

cmd /c pnpm install --prod
if errorlevel 1 exit 1

@rem generate license disclaimer for pnpm-licenses itself :)
pnpm-licenses generate-disclaimer --prod --output-file=third-party-licenses.txt
if errorlevel 1 exit 1
