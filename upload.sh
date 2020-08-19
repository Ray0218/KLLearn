#!/bin/bash

read -p "请输入版本描述:" commitDesc

git add .
git commit -am ${commitDesc}
git push origin master
 
