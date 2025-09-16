# 📸 Instalação Completa do OpenCV + contrib no Windows (Visual Studio 2022)

Este guia ensina a compilar e instalar o **OpenCV com os módulos extras (`opencv_contrib`)** no Windows, criando uma instalação limpa e organizada, passo a passo.

---

## 📂 Estrutura de Pastas Recomendada

```
C:\opencv\          ← código-fonte principal (clonado do GitHub)
C:\opencv_contrib\  ← código-fonte dos módulos extras (clonado do GitHub)
C:\opencv_build\    ← build temporário (criado pelo CMake)
C:\opencv_install\  ← destino da instalação final (include + lib + bin)
```

---

## 🔧 Pré-requisitos

- **Visual Studio 2022** com workload *Desktop development with C++*
- **CMake** (>= 3.20)
- **Git**
- Terminal: **x64 Native Tools Command Prompt for VS 2022**

---

## 📥 1. Clonar os repositórios

```powershell
cd C:\
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
```

---

## ⚙️ 2. Configurar o build com CMake

```powershell
mkdir C:\opencv_build
cd C:\opencv_build

cmake -G "Visual Studio 17 2022" -A x64 ..\opencv ^
  -DOPENCV_EXTRA_MODULES_PATH=..\opencv_contrib\modules ^
  -DCMAKE_INSTALL_PREFIX=C:\opencv_install ^
  -DBUILD_TESTS=OFF ^
  -DBUILD_PERF_TESTS=OFF ^
  -DBUILD_SHARED_LIBS=ON
```

---

## 🛠️ 3. Compilar e instalar

```powershell
cd C:\opencv_build
cmake --build . --config Release --target INSTALL
```

Estrutura final em `C:\opencv_install`:

```
include\opencv2\...
x64\vc17\lib\
x64\vc17\bin\
x64\vc17\lib\cmake\opencv4\OpenCVConfig.cmake
```

---

## 🌍 4. Configurar Variáveis de Ambiente

**Path**:
```
C:\opencv_install\x64\vc17\bin
```

**OPENCV_DIR**:
```
C:\opencv_install\x64\vc17\lib\cmake\opencv4
```

---

## 💻 5. Exemplo de CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.20)
project(opencv_app CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(OpenCV REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(opencv_app src/main.cpp)
target_link_libraries(opencv_app PRIVATE ${OpenCV_LIBS})
```

---

## ✅ 6. Teste rápido

`src/main.cpp`:

```cpp
#include <opencv2/opencv.hpp>
#include <opencv2/face.hpp>
#include <iostream>

int main() {
    std::cout << "OpenCV version: " << CV_VERSION << std::endl;
    return 0;
}
```

Build:

```powershell
cd C:\Users\seu_usuario\Desktop\OpencvC++
mkdir build
cd build
cmake ..
cmake --build . --config Release
```

Saída esperada:

```
OpenCV version: 4.12.0
```

---

## 🎯 Resumo

1. Clonar `opencv` e `opencv_contrib`  
2. Configurar o build em `C:\opencv_build`  
3. Compilar e instalar → `C:\opencv_install`  
4. Configurar `PATH` e `OPENCV_DIR`  
5. Usar `find_package(OpenCV REQUIRED)`  

Agora o **OpenCV + contrib (com `face.hpp`)** está funcionando no Windows.
