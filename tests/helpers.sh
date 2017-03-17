setUp(){
    export TAGS_DIR=$(mktemp -d)
}

tearDown(){
    if [ $BATS_TEST_COMPLETED ]; then
        rm -rf $TAGS_DIR
    fi
}
