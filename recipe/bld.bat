@echo on

@rem source.url in meta.yaml references a tgz file which contains a fully-built pnpm-licenses
@rem version, we now want to turn this back into a tgz file using pnpm pack and install it
@rem globally from that.
cmd /c pnpm install
if errorlevel 1 exit 1

cmd /c pnpm pack
if errorlevel 1 exit 1


@rem install pnpm-licenses globally from file (as opposed to from a registry as you'd do normally)
call npm config set prefix %BUILD_PREFIX%
if errorlevel 1 exit 1

call npm install --userconfig nonexistentrc --global %PKG_NAME%-v%PKG_VERSION%.tgz
if errorlevel 1 exit 1


@rem generate license disclaimer for pnpm-licenses itself :)
call pnpm-licenses generate-disclaimer --prod --output-file=third-party-licenses.txt
if errorlevel 1 exit 1
