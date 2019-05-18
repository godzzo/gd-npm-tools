#!/bin/bash

pkgName="$1";
dirName=`dirname "$0"`;
userName=`whoami`;

echo "$dirName";
echo ">>> Hello :)";

echo ">>> mkdir $pkgName";
mkdir "$pkgName"; 
pwd;

echo ">>> cd $pkgName";
cd "$pkgName";
pwd;

echo ">>> npm init -y";
npm init -y;

echo "tsc  --init";
tsc  --init;

mkdir src;

tee src/index.ts <<EOF
console.log("Loaded!");
export const $pkgName = (name: string) => 'Hello '+name;
EOF

echo ">>> set .gitignore";
echo node_modules >> .gitignore;
echo dist >> .gitignore;

echo ">>> bash $dirName/edit_package_json.js";
node "$dirName/edit_package_json.js";

echo ">>> create tsconfig.json";
tee tsconfig.json <<EOF
{
  "compilerOptions": {
    "target": "es5",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "lib": ["es2017", "es7", "es6", "dom"],
    "declaration": true,
    "outDir": "dist",
  },
  "exclude": [
    "node_modules",
    "dist"
  ]
}
EOF

tsc;

git init;
git add *;
git commit -m "Initial";

echo "git remote add origin git@github.com:$userName/$pkgName.git";
echo "git push --set-upstream origin master";

echo ">>> Bye :)";
