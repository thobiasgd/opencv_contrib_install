# 📸 Instalação Completa do OpenCV + contrib no Windows (Visual Studio 2022)

Este guia ensina a compilar e instalar o **OpenCV com os módulos extras (`opencv_contrib`)** no Windows, criando uma instalação limpa e organizada, passo a passo.

---

## 📂 Estrutura de Pastas Recomendada

Organize as pastas desta forma:

C:\opencv\ ← código-fonte principal (clonado do GitHub)
C:\opencv_contrib\ ← código-fonte dos módulos extras (clonado do GitHub)
C:\opencv_build\ ← build temporário (criado pelo CMake)
C:\opencv_install\ ← destino da instalação final (include + lib + bin)

yaml
Copiar código

---

## 🔧 Pré-requisitos

Antes de começar, instale:

- **Visual Studio 2022** com o workload *Desktop development with C++*
- **CMake** (>= 3.20)
- **Git**

Sempre utilize o terminal correto:  
👉 **x64 Native Tools Command Prompt for VS 2022**

---

## 📥 1. Clonar os repositórios

Abra o terminal e rode:

```powershell
cd C:\
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
Isso criará as pastas C:\opencv e C:\opencv_contrib.

⚙️ 2. Configurar o build com CMake
Crie a pasta de build separada:

powershell
Copiar código
mkdir C:\opencv_build
cd C:\opencv_build
Agora configure o projeto:

powershell
Copiar código
cmake -G "Visual Studio 17 2022" -A x64 ..\opencv ^
  -DOPENCV_EXTRA_MODULES_PATH=..\opencv_contrib\modules ^
  -DCMAKE_INSTALL_PREFIX=..\opencv_install ^
  -DBUILD_TESTS=OFF ^
  -DBUILD_PERF_TESTS=OFF
Explicando:

..\opencv → fonte principal

..\opencv_contrib\modules → módulos extras (face.hpp e outros)

..\opencv_install → pasta final de instalação

flags OFF → desativa testes para acelerar a build

🛠️ 3. Compilar e instalar
Na mesma pasta C:\opencv_build, rode:

powershell
Copiar código
cmake --build . --config Release --target INSTALL
Esse processo pode levar alguns minutos.

No final, será criada a pasta C:\opencv_install contendo:

vbnet
Copiar código
C:\opencv_install\
   ├── include\opencv2\...
   ├── x64\vc16\lib\
   ├── x64\vc16\bin\
   └── x64\vc16\lib\cmake\opencv4\OpenCVConfig.cmake
🌍 4. Configurar Variáveis de Ambiente
Abra: Painel de Controle → Sistema → Configurações Avançadas → Variáveis de Ambiente.

Adicionar no PATH:

makefile
Copiar código
C:\opencv_install\x64\vc16\bin
Criar variável OPENCV_DIR:

vbnet
Copiar código
C:\opencv_install\x64\vc16\lib\cmake\opencv4
Essas variáveis permitem que o CMake e o Windows encontrem o OpenCV e suas DLLs.

💻 5. Exemplo de CMakeLists.txt
Use este modelo no seu projeto:

cmake
Copiar código
cmake_minimum_required(VERSION 3.20)
project(opencv_app CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# usa a variável de ambiente OPENCV_DIR
find_package(OpenCV REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(opencv_app src/main.cpp)
target_link_libraries(opencv_app PRIVATE ${OpenCV_LIBS})
✅ 6. Teste rápido
Crie o arquivo src/main.cpp:

cpp
Copiar código
#include <opencv2/opencv.hpp>
#include <opencv2/face.hpp>
#include <iostream>

int main() {
    std::cout << "OpenCV version: " << CV_VERSION << std::endl;
    return 0;
}
Agora, no seu projeto:

powershell
Copiar código
cd C:\Users\seu_usuario\Desktop\OpencvC++
mkdir build
cd build
cmake ..
cmake --build . --config Release
Se tudo deu certo, ao rodar o executável você verá algo como:

yaml
Copiar código
OpenCV version: 4.12.0
🎯 Resumo
Clonar opencv e opencv_contrib

Rodar cmake em C:\opencv_build apontando para opencv_contrib

Compilar e instalar → cria C:\opencv_install

Configurar variáveis PATH e OPENCV_DIR

Usar find_package(OpenCV REQUIRED) no seu CMakeLists.txt

Agora você tem o OpenCV + contrib (com face.hpp) funcionando no Windows!
