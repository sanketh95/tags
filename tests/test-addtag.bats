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
    run ../tags.sh addtag
    assert_failure
}

@test "Should create a tag" {
    run ../tags.sh addtag tag1
    assert_success

    assert_file_exist "$TAGS_HOME/.tags/tag1"
}

@test "Should create a tag with shortform" {
    run ../tags.sh at tag2
    assert_success

    assert_file_exist "$TAGS_HOME/.tags/tag2"
}

@test "Creating the same tag should return success" {
    run ../tags.sh at tag3
    assert_success

    run ../tags.sh at tag3
    assert_success
}
