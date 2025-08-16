@echo off
REM ====================================================================
REM Script para ejecutar pruebas BDD con Cucumber
REM ====================================================================

echo.
echo ====================================================================
echo   PROYECTO FINAL BDD - AUTOMATIZACION CON CUCUMBER
echo ====================================================================
echo.

REM Verificar si Maven está instalado
mvn --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Maven no está instalado o no está en el PATH
    echo Por favor instala Maven y asegúrate de que esté en el PATH
    pause
    exit /b 1
)

REM Verificar si Java está instalado
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java no está instalado o no está en el PATH
    echo Por favor instala Java 11 o superior
    pause
    exit /b 1
)

echo Verificando entorno...
echo ✓ Maven instalado
echo ✓ Java instalado
echo.

REM Menú de opciones
:menu
echo ====================================================================
echo   MENU DE EJECUCION
echo ====================================================================
echo.
echo 1. Ejecutar todas las pruebas (TestRunner)
echo 2. Ejecutar solo Smoke Tests (SmokeTestRunner)
echo 3. Ejecutar pruebas de Regresión (RegressionTestRunner)
echo 4. Ejecutar pruebas de Seguridad (SecurityTestRunner)
echo 5. Ejecutar solo pruebas de Login (filtro por tag)
echo 6. Ejecutar pruebas en modo headless
echo 7. Limpiar y compilar proyecto
echo 8. Ver reportes
echo 9. Salir
echo.
set /p choice="Selecciona una opción (1-9): "

if "%choice%"=="1" goto run_all
if "%choice%"=="2" goto run_smoke
if "%choice%"=="3" goto run_regression
if "%choice%"=="4" goto run_security
if "%choice%"=="5" goto run_login
if "%choice%"=="6" goto run_headless
if "%choice%"=="7" goto clean_compile
if "%choice%"=="8" goto view_reports
if "%choice%"=="9" goto exit
echo Opción inválida. Por favor selecciona una opción del 1 al 9.
goto menu

:run_all
echo.
echo Ejecutando todas las pruebas...
mvn clean test
goto end

:run_smoke
echo.
echo Ejecutando Smoke Tests con SmokeTestRunner...
mvn clean test -Dtest=SmokeTestRunner
goto end

:run_regression
echo.
echo Ejecutando pruebas de Regresión con RegressionTestRunner...
mvn clean test -Dtest=RegressionTestRunner
goto end

:run_security
echo.
echo Ejecutando pruebas de Seguridad con SecurityTestRunner...
mvn clean test -Dtest=SecurityTestRunner
goto end

:run_login
echo.
echo Ejecutando pruebas de Login (filtro por tag)...
mvn clean test -Dcucumber.filter.tags="@Login"
goto end

:run_headless
echo.
echo Ejecutando pruebas en modo headless...
mvn clean test -Dheadless=true
goto end

:clean_compile
echo.
echo Limpiando y compilando proyecto...
mvn clean compile test-compile
echo ✓ Proyecto compilado exitosamente
goto menu

:view_reports
echo.
echo Abriendo reportes...
if exist "reports\cucumber-reports\index.html" (
    start reports\cucumber-reports\index.html
    echo ✓ Reporte HTML abierto en el navegador
) else (
    echo ❌ No se encontraron reportes. Ejecuta las pruebas primero.
)
goto menu

:end
echo.
echo ====================================================================
echo   EJECUCION COMPLETADA
echo ====================================================================
echo.
echo Los reportes están disponibles en:
echo - HTML: reports\cucumber-reports\index.html
echo - JSON: reports\cucumber-reports\Cucumber.json
echo - XML:  reports\cucumber-reports\Cucumber.xml
echo.
if exist "screenshots" (
    echo Screenshots de fallos disponibles en: screenshots\
    echo.
)

set /p open_report="¿Deseas abrir el reporte HTML? (s/n): "
if /i "%open_report%"=="s" (
    if exist "reports\cucumber-reports\index.html" (
        start reports\cucumber-reports\index.html
    )
)

:exit
echo.
echo ¡Gracias por usar el sistema de pruebas BDD!
echo.
pause
