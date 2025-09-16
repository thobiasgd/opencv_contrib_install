@echo off
REM =====================================================
REM Script de instalação automática do OpenCV + contrib (VS2022, vc17)
REM =====================================================

REM Definir pastas
set OPENCV_SRC=C:\opencv
set OPENCV_CONTRIB=C:\opencv_contrib
set OPENCV_BUILD=C:\opencv_build
set OPENCV_INSTALL=C:\opencv_install

echo.
echo ==========================================
echo  CLONANDO REPOSITORIOS
echo ==========================================
echo.

if not exist %OPENCV_SRC% (
    git clone https://github.com/opencv/opencv.git %OPENCV_SRC%
) else (
    echo OpenCV ja existe em %OPENCV_SRC%
)

if not exist %OPENCV_CONTRIB% (
    git clone https://github.com/opencv/opencv_contrib.git %OPENCV_CONTRIB%
) else (
    echo OpenCV contrib ja existe em %OPENCV_CONTRIB%
)

echo.
echo ==========================================
echo  CRIANDO BUILD E CONFIGURANDO CMAKE
echo ==========================================
echo.

if exist %OPENCV_BUILD% rmdir /s /q %OPENCV_BUILD%
mkdir %OPENCV_BUILD%
cd %OPENCV_BUILD%

cmake -G "Visual Studio 17 2022" -A x64 %OPENCV_SRC% ^
  -DOPENCV_EXTRA_MODULES_PATH=%OPENCV_CONTRIB%\modules ^
  -DCMAKE_INSTALL_PREFIX=%OPENCV_INSTALL% ^
  -DBUILD_TESTS=OFF ^
  -DBUILD_PERF_TESTS=OFF ^
  -DBUILD_SHARED_LIBS=ON

echo.
echo ==========================================
echo  COMPILANDO E INSTALANDO OPENCV
echo ==========================================
echo.

cmake --build . --config Release --target INSTALL

echo.
echo ==========================================
echo  CONFIGURANDO VARIAVEIS DE AMBIENTE
echo ==========================================
echo.

setx OPENCV_DIR "%OPENCV_INSTALL%\x64\vc17\lib\cmake\opencv4" /M
setx PATH "%PATH%;%OPENCV_INSTALL%\x64\vc17\bin" /M

echo.
echo ==========================================
echo  INSTALACAO FINALIZADA
echo ==========================================
echo OpenCV foi instalado em %OPENCV_INSTALL%
echo.
pause
