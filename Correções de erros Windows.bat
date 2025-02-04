@echo off

:menu
cls
chcp 65001
echo ﾠ
:: Parte que valida se o arquivo foi aberto como administrador
echo [É preciso abrir o arquivo como administrador para que algumas correções funcionem]
echo Precione [0] caso queira abrir o arquivo coo administrador
choice /c 0 /n /m  "Digite Zero [0]: "

if %errorlevel% == 0 goto opcao0

:opcao0
@echo off
:: Verifica se o script está rodando como Administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando privilégios de administrador...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit
)

echo Script rodando como Administrador!
pause
:: limpando a tela para que o menu apareça
cls 

:: Criação do menu de escolha do usuário
echo ﾠ
echo ======================================
echo Escolha qual correção deseja realizar:
echo ======================================
echo ﾠ
echo 1 - Corrigir problemas de rede internet
echo 2 - Corrigir problemas de arquvios do Sistema
echo 3 - Corrigir Problemas com Windows-Defender
echo 4 - Encerrar Programa

choice /c 1234 /n /m "Digite uma opção: "


if %errorlevel% == 4 goto opcao4
if %errorlevel% == 1 goto opcao1
if %errorlevel% == 2 goto opcao2
if %errorlevel% == 3 goto opcao3

:opcao4
cls
echo programa encerrado
exit

:opcao1
cls
echo Correcao de problemas de rede internet
echo ﾠ
ipconfig /release
ipconfig /renew
ipconfig /flushdns 
Netsh winsock reset
net localgroup administradores localservice /add
fsutil resource setautoreset true C:\
netsh int ip reset resetlog.txt
netsh winsock reset all
netsh int 6to4 reset all
Netsh int ip reset all
netsh int ipv4 reset all 
netsh int ipv6 reset all
netsh int httpstunnel reset all
netsh int isatap reset all
netsh int portproxy reset all
netsh int tcp reset all
netsh int teredo reset all
Netsh int ip reset
Netsh winsock reset
echo ﾠ
echo Correções de erros da Rede concluida
pause
goto menu


:opcao2
cls
echo Correção de problemas do Windows 10-11
echo ﾠ
echo Verificando e restaurando a integridade do Windows...
echo ﾠ
echo Executando DISM /CheckHealth...
Dism /Online /Cleanup-Image /CheckHealth
echo ﾠ
echo Executando DISM /ScanHealth...
Dism /Online /Cleanup-Image /ScanHealth
echo ﾠ
echo Executando DISM /RestoreHealth...
Dism /Online /Cleanup-Image /RestoreHealth
echo ﾠ
echo Executando SFC /Scannow...
sfc /scannow
echo ﾠ
echo Correções de erros do Sistema concluido
pause
goto menu

:opcao3
cls
echo Correções do Problemas com Windows-Defender
echo ﾠ
echo Reiniciando O Windows-Defender
winmgmt /verifyrepository
net stop winmgmt
echo Precione [S] para confirmar que deseja reinicar o Windows-Defender
winmgmt /resetrepository
echo ﾠ
echo Pronto, agora basta reiniciar o computador que o Windows Defender já estará funcionando.
pause
goto menu
