FROM mcr.microsoft.com/windows/servercore:1809

ARG SV_HOSTNAME
ARG SV_LICENSEKEY
ARG STEAM_API_KEY
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DB
ARG MYSQL_PORT
ARG MYSQL_HOST

RUN dism.exe /online /enable-feature /featurename:MicrosoftWindowsPowerShellRoot

RUN powershell mkdir C:\srv

RUN powershell mkdir C:\temp

RUN powershell Invoke-WebRequest -Uri "https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/3539-86d8fe5891dbdc38d43976e6a8afec97215530e8/server.zip" -OutFile "C:\\temp\\fx.zip"

RUN powershell -Command Expand-Archive -LiteralPath C:/temp/fx.zip -DestinationPath C:/srv

RUN powershell Invoke-WebRequest -Uri "https://aka.ms/vs/16/release/VC_redist.x64.exe" -OutFile "C:\\vc_redist.exe"

RUN C:\vc_redist.exe /quiet /install;

RUN powershell Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.27.0.windows.1/Git-2.27.0-64-bit.exe" -OutFile "C:\\git.exe"

RUN git.exe /SILENT /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"

RUN powershell Invoke-WebRequest -Uri "https://nodejs.org/dist/v12.18.0/node-v12.18.0-x64.msi" -OutFile "C:\node12.msi"

RUN msiexec /i C:\node12.msi

RUN powershell Invoke-WebRequest -Uri "https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst.exe.exec" -OutFile "C:\\srv\\envsubst.exe"

RUN powershell mkdir C:\srv\resources

COPY ./resources/package.json "C:\\srv\\resources\\package.json"

RUN powershell cd C:\srv\resources; npm install --no-optional

WORKDIR "C:\\srv"

COPY template.server_dev.cfg "C:\\srv\\template.server_dev.cfg"

RUN .\envsubst.exe < template.server_dev.cfg > server.cfg

COPY entrypoint.ps1 .

COPY fix-hosts.ps1 C:\\fix-hosts.ps1


ENTRYPOINT ["powershell", "C:\\srv\\entrypoint.ps1"]
