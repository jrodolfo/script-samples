#!/bin/bash

########################################################################################################################
#
#  Script Name:    create-react-redux-project.sh
#
#  Description:    create a react/redux project
#
#  Assumption:     npm is installed
#
#  Args:           -n [name] (mandatory argument, name of the project, e.g.: react-redux-project)
#
#  Author:         Rod Oliveira
#
########################################################################################################################

if [ "$1" = "-n" ]
then
    startedAt=$(date +"%Y-%m-%d %T");
    echo "script started at $startedAt";
    echo "calling npx create-react-app $2...";
    npx create-react-app $2;

    echo "deleting content of src...";
    cd $2/src || exit;
    rm -rf *;

    echo "creating index.js...";   
    importReact="import React from 'react';";
    importReactDOM="import ReactDOM from 'react-dom';";
    importApp="import App from './components/App';";
    render="ReactDOM.render(<App />, document.querySelector('#root'));";
    indexContent="$importReact\n$importReactDOM\n$importApp\n$render";
    echo -e $indexContent > index.js;

    echo "creating folder components and the file App.js...";
    mkdir components;
    cd components || exit;
    appDef="const App = () => {return <div>App</div>;}";
    exportApp="export default App;";
    appContent="$importReact\n$appDef\n$exportApp";
    echo -e $appContent > App.js;

    echo "adding semantic-ui to index.html...";
    cd ../../public || exit;
    match="<meta name=\"theme-color\" content=\"#000000\" \/>";
    insert="<link rel=\"stylesheet\" href=\"https:\/\/cdnjs.cloudflare.com\/ajax\/libs\/semantic-ui\/2.4.1\/semantic.min.css\" \/>";
    file=index.html;
    sed -i "s/$match/$match\n    $insert/" $file;

    echo "installing redux and react-redux...";
    cd ..;
    npm install --save redux react-redux;

    echo "starting the app...";
    npm start;
else
    echo "Please call this script with a name argument, e.g.: ./create-react-redux-project.sh -n react-redux-project";
fi;
