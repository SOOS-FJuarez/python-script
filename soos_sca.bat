echo off
:: run with the -h flag for help

:: Required Arguments
:: Note, SOOS_CLIENT_ID and SOOS_API_KEY can be set below or be defined as Environment variables.
:: You can get the values for SOOS_CLIENT_ID and SOOS_API_KEY from the SOOS Application
set "SOOS_CLIENT_ID=nohtkeibt"
set "SOOS_API_KEY=MGI3ZGUwNmYtNTk1NS00YTdlLWEzZTktZjZjZGZiY2I4NDE0"
set "SOURCE_CODE_PATH=C:\soos-python-script"
set "SOOS_PROJECT_NAME=My first phyton script test"

:: Optional Arguments
set "SOOS_MODE=run_and_wait"
set "SOOS_ON_FAILURE=continue_on_failure"
set "SOOS_DIRS_TO_EXCLUDE=soos"
set "SOOS_FILES_TO_EXCLUDE="
set "SOOS_ANALYSIS_RESULT_MAX_WAIT=300"
set "SOOS_ANALYSIS_RESULT_POLLING_INTERVAL=10"
set "SOOS_API_BASE_URL=https://qa-api.soos.io/api/"
set "SOOS_LOGGING_VERBOSITY=INFO"            :: SET TO DEBUG TO ENABLE

:: Build Specific Arguments
set "SOOS_COMMIT_HASH="                :: ENTER COMMIT HASH HERE IF KNOWN
set "SOOS_BRANCH_NAME="                :: ENTER BRANCH NAME HERE IF KNOWN
set "SOOS_BRANCH_URI="                 :: ENTER BRANCH URI HERE IF KNOWN
set "SOOS_BUILD_VERSION="              :: ENTER BUILD VERSION HERE IF KNOWN
set "SOOS_BUILD_URI="                  :: ENTER BUILD URI HERE IF KNOWN

:: **************************** Modify Above Only *************** ::
set "WORKING_DIR=%SOURCE_CODE_PATH%\soos"
set "WORKSPACE=%WORKING_DIR%\workspace"

cd "%SOURCE_CODE_PATH%"

echo.
echo Setting Up Workspace...
mkdir "%WORKSPACE%"

echo.
echo Setting Up Environment...
python -m venv .
call Scripts/activate.bat

echo.
echo Installing...
python -m pip install soos-sca --trusted-host pypi.python.org

echo.
echo Running Scan...
soos-sca ^
  -m="%SOOS_MODE%" ^
  -of="%SOOS_ON_FAILURE%" ^
  -dte="%SOOS_DIRS_TO_EXCLUDE%" ^
  -fte="%SOOS_FILES_TO_EXCLUDE%" ^
  -wd="%WORKING_DIR%" ^
  -armw="%SOOS_ANALYSIS_RESULT_MAX_WAIT%" ^
  -arpi="%SOOS_ANALYSIS_RESULT_POLLING_INTERVAL%" ^
  -buri="%SOOS_API_BASE_URL%" ^
  -scp="%SOURCE_CODE_PATH%" ^
  -pn="%SOOS_PROJECT_NAME%" ^
  -ch="%SOOS_COMMIT_HASH%" ^
  -bn="%SOOS_BRANCH_NAME%" ^
  -bruri="%SOOS_BRANCH_URI%" ^
  -bldver="%SOOS_BUILD_VERSION%" ^
  -blduri="%SOOS_BUILD_URI%" ^
  -v="%SOOS_LOGGING_VERBOSITY%" ^
  -pm="npm, go"