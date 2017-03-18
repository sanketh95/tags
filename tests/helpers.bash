setUpEnv(){
    export TAGS_HOME=$(mktemp -d)
}

tearDownEnv(){
   rm -rf $TAGS_HOME
}
