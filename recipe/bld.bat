@echo on

md %LIBRARY_PREFIX%\share\pnpm-licenses
pushd %LIBRARY_PREFIX%\share\pnpm-licenses
md node_modules
cmd /c "npm install --save @quantco/pnpm-licenses@%PKG_VERSION%"
if errorlevel 1 exit 1
popd

dir %PREFIX%\Library\share\pnpm-licenses\node_modules\.bin
dir %PREFIX%\Library\share\pnpm-licenses\node_modules\@quantco\pnpm-licenses
dir %PREFIX%\Library\share\pnpm-licenses\node_modules\@quantco\pnpm-licenses\dist
exit 1

pushd %LIBRARY_PREFIX%\bin
for %%c in (pnpm-licenses) do (
  echo @echo on >> %%c.bat
  echo node %LIBRARY_PREFIX%\share\pnpm-licenses\node_modules\@quantco\pnpm-licenses\bin\%%c "%%*" >> %%c.bat
)
popd

cmd /c pnpm install --prod
if errorlevel 1 exit 1

@rem generate license disclaimer for pnpm-licenses itself :)
pnpm-licenses generate-disclaimer --prod --output-file=third-party-licenses.txt
if errorlevel 1 exit 1
