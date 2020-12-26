FROM mcr.microsoft.com/windows/servercore:1809

ARG SV_HOSTNAME
ARG SV_LICENSEKEY
ARG STEAM_API_KEY

RUN dism.exe /online /enable-feature /featurename:MicrosoftWindowsPowerShellRoot

RUN powershell mkdir C:\srv

RUN powershell mkdir C:\temp

RUN powershell Invoke-WebRequest -Uri "https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/3184-6123f9196eb8cd2a987a1dd7ff7b36907a787962/server.zip" -OutFile "C:\\temp\\fx.zip"

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


ENTRYPOINT ["C:\\srv\\FXServer.exe"]

CMD ["+exec", "C:\\srv\\server.cfg", "+set", "onesync_legacy"]
