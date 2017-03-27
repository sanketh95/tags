#!./lib/bats/bin/bats

load './lib/bats-support/load'
load './lib/bats-assert/load'
load './lib/bats-file/load'
load 'helpers'

setup(){
    setUpEnv
}

teardown(){
    tearDownEnv
}

@test "Creating tag without any tagname should fail" {
    run $TAGS addtag
    assert_failure
}

@test "Should create a tag" {
    run $TAGS addtag tag1
    assert_success

    assert_file_exist "$TAGS_HOME/.tags/tag1"
}

@test "Should create a tag with shortform" {
    run $TAGS at tag2
    assert_success

    assert_file_exist "$TAGS_HOME/.tags/tag2"
}

@test "Creating the same tag should return success" {
    run $TAGS at tag3
    assert_success

    run $TAGS at tag3
    assert_success
}
