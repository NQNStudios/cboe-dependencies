
setlocal enabledelayedexpansion

for /f "usebackq tokens=*" %%i in (`vswhere -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`) do (
	"%%i" -clp:ForceConsoleColor -target:Build -property:Configuration=%2 -property:Platform=%1 "zlib/build/zlib.sln"
	exit /b !errorlevel!
)
