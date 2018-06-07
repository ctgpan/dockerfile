#!/bin/sh

# set -e
cd `dirname $0`

# 重写饿了么webapp export gitUrl="https://github.com/bailicangdu/vue2-elm.git"
# export gitUrl="https://github.com/useryangtao/vue-wechat.git"

log_file=/var/lib/nginx/logs/app.log

demo_folder=/home/demo
error_folder=/home/error
html_folder=/home/www

vue_modules=${demo_folder}/vue/
angular_modules=${demo_folder}/angular/

# 判断代码库使用的框架：vue, angular, react
# 前端：工程中包含 package.json 文件
function getFramework() {
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

# 启动应用，工程目录下
# $1: 是否缓存的示例标识
function runApp() {
    isDemo=$1
    if [ -f "./package.json" ]; then
        type=`getFramework`
        echo "javascript framework: $type"
        if [ $type = "vue" ]; then
            if [ $isDemo = false ]; then
                # copy dependency
                yarn
            fi
            # 如果运行正常，此处会阻塞，即不会再往后执行
            npm run dev
            if [ $? -eq 0 ]; then
                echo "    Successful." > $log_file
            else
                # error page
                echo "ERROR: vue 执行失败"
                rm -rf ${html_folder}/* && cp ${error_folder}/vue.html ${html_folder}/index.html
            fi
        elif [ $type = "angular" ]; then
            if [ $isDemo = false ]; then
                # copy dependency
                npm install
                npm run build
            fi
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
        echo "no package.json"
        cp -r * ${html_folder}/
    fi
    echo "start nginx ... "
    cp ${error_folder}/favicon.ico ${html_folder}/favicon.ico
    nginx -g "daemon off;"
}

if [ ! -n "$gitUrl" ]; then
    echo ""
    echo "Error: The git url does not exist."
    echo ""
    exit 2
fi

if [ ! -d ${demo_folder} ]; then mkdir -p ${demo_folder}; fi
if [ ! -d ${html_folder} ]; then mkdir -p ${html_folder}; fi
if [ -d "./code" ]; then  rm -rf ./code; fi

# 是已缓存的示例库，则直接进入缓存目录运行
project_name=${gitUrl##*/}
project_name=${project_name%.*}
if [ `ls $demo_folder | grep -w $project_name | wc -l` -eq '1' ]; then
    echo "project[$project_name] exists: true"
    cd $demo_folder/$project_name
    runApp true
else
    echo "$project_name exists: false"
    # 若不是，则克隆代码并复制对应的框架依赖到code目录下
    git clone $gitUrl code # && copy -r *** ./code/
    cd code
    runApp false
fi
