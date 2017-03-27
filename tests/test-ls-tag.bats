#!./lib/bats/bin/bats

load './lib/bats-support/load'
load './lib/bats-assert/load'
load './lib/bats-file/load'
load 'helpers'

setup(){
    setUpEnv
    mkdir -p "$TAGS_HOME/.tags/"
}

teardown(){
    tearDownEnv
}

@test "should be able to list down existing tags" {
    mkdir "$TAGS_HOME/.tags/tag1"
    mkdir "$TAGS_HOME/.tags/tag2"

    run $TAGS ls
    assert_success
    assert_line "tag1"
    assert_line "tag2"

    rm -rf "$TAGS_HOME/.tags/*"
}

@test "If there are no tags, listing should give empty result" {
    run $TAGS ls

    assert_output ""
}
