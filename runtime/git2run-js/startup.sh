#!/bin/sh

# set -e
cd `dirname $0`

# 重写饿了么webapp export gitUrl="https://github.com/bailicangdu/vue2-elm.git"
# export gitUrl="https://github.com/useryangtao/vue-wechat.git"

log_file=/var/lib/nginx/logs/app.log

demo_folder=/home/demo
error_folder=/home/error
html_folder=/home/www

vue_modules=${demo_folder}/vue/****
angular_modules=${demo_folder}/angular/****

# 判断代码库使用的框架：vue, angular, react
# 前端：工程中包含 package.json 文件
function getStructure() {
    # 已到代码库目录下
    # -eq: 等于   -gt: 大于   -ge: 大于等于
    if [ `grep -c "@angular/core" package.json` -gt '0' ]; then
        echo "angular"
    elif [ `grep -c "\"vue\"" package.json` -gt '0' ]; then
        echo "vue"
    elif [ `grep -c "\"react\"" package.json` -gt '0' ]; then
        echo "react"
    else
        echo "default"
    fi
}

# 已存在项目处理
function getDemo(){
    if [ $1 = "https://github.com/bailicangdu/vue2-elm.git" ]; then echo "vue2-elm";
    elif [ $1 = "" ]; then echo "";
    else echo 0;
    fi
}

if [ ! -n "$gitUrl" ]; then
    echo ""
    echo "Error: The git url does not exist."
    echo ""
    exit 2
fi

if [ ! -d ${demo_folder} ]; then mkdir -p ${demo_folder}; fi
if [ -d "./code" ]; then  rm -rf ./code; fi

# 是已缓存的示例库，则直接复制制品到 ${html_folder} 下
# /home/demo 各示例路径
# /home/error 异常页面
# project=`getDemo`

# 若不是，则克隆代码并复制对应的框架依赖到code目录下
git clone $gitUrl code # && copy -r *** ./code/
cd code

if [ -f "./package.json" ]; then
    # Dockerfile中增加port环境变量：PORT=80
    type=`getStructure`
    echo "javascript framework: $type"
    if [ $type = "vue" ]; then
        # copy dependency
        npm install
        # 如果运行正常，此处会阻塞，即不会再往后执行
        npm run dev > $log_file
        if [ $? -eq 0 ]; then
            echo "    Successful." > $log_file
        else
            # error page
            echo "ERROR: vue 执行失败"
            rm -rf ${html_folder}/* && cp ${error_folder}/vue.html ${html_folder}/index.html
        fi
    elif [ $type = "angular" ]; then
        # copy dependency
        npm install
        npm run build
        if [ -d "./dist" ]; then 
            if [ -f "./dist/index.html" ]; then
                rm -rf ${html_folder}/* && cp -r dist/* ${html_folder}/
            else
                # 所有子目录下包含index.html页面的文件夹
                flag=false
                for element in `ls ./dist/`
                do
                    if [ -d ./dist/$element ]; then
                        if [ -f ./dist/$element"/index.html" ]; then
                            flag=true
                            rm -rf ${html_folder}/* && cp -r dist/$element/* ${html_folder}/
                        fi
                    fi
                done
                # error page
                if [ $flag = false ]; then
                    echo "ERROR: angular 执行失败"
                    rm -rf ${html_folder}/* && cp ${error_folder}/angular.html ${html_folder}/index.html
                fi
            fi
        else 
            # error page
            echo "ERROR: angular 执行失败"
            rm -rf ${html_folder}/* && cp ${error_folder}/angular.html ${html_folder}/index.html
        fi
    elif [ $type = "react" ]; then
        # error page
        echo "ERROR: react 暂不支持"
        rm -rf ${html_folder}/* && cp ${error_folder}/react.html ${html_folder}/index.html
    else
        # error page
        echo "ERROR: 不支持的技术架构"
        rm -rf ${html_folder}/* && cp ${error_folder}/default.html ${html_folder}/index.html
    fi
else
    # no package.json
    echo "no package.json"
    cp -r * ${html_folder}/
fi

# nginx -g "daemon off;"
nginx
