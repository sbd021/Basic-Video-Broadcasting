if exist Qt5.14.2.zip (curl -kLO https://github.com/sbd021/Basic-Video-Broadcasting/releases/download/5.14.2/Qt5.14.2.zip -f --retry 5 -z Qt5.14.2.zip) else (curl -kLO https://github.com/sbd021/Basic-Video-Broadcasting/releases/download/5.14.2/Qt5.14.2.zip -f --retry 5 -C -)
7z x Qt5.14.2.zip -oQt
mv Qt C:\Qt5.14.2
dir C:\Qt5.14.2
