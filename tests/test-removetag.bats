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

@test "Removing a tag should succeed. Duh !" {
    mkdir "$TAGS_HOME/.tags/tag1"
    assert_success

    assert_file_exist "$TAGS_HOME/.tags/tag1"
    run ../tags.sh removetag tag1

    assert_success
    assert_file_not_exist "$TAGS_HOME/.tags/tag1"
}

@test "Not passing tag name should return failure status" {
    run ../tags.sh removetag
    assert_failure
}
