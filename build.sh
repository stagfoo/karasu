nim c -o:bin/karasu src/karasu.nim;
nim js -o:public/test.js  -d:local  src/public/main.nim;
nim c -o:bin/viewer src/viewer.nim;