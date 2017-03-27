setUpEnv(){
    export TAGS_HOME=$(mktemp -d)
    export TMPDIR=$(mktemp -d)
    export TAGS="../tags"
}

tearDownEnv(){
    if [[ $BATS_TEST_COMPLETED ]]; then
        rm -rf $TAGS_HOME
        rm -rf $TMPDIR
    fi
}
