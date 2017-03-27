#!./lib/bats/bin/bats

load './lib/bats-support/load'
load './lib/bats-assert/load'
load './lib/bats-file/load'
load 'helpers'

setup(){
    setUpEnv
    mkdir -p "$TAGS_HOME/.tags/tag1"
}

teardown(){
    tearDownEnv
}

@test "can search all files for a tag" {
    local file1=$(mktemp)
    local file2=$(mktemp)

    ln -s $file1 "$TAGS_HOME/.tags/tag1/link1"
    ln -s $file2 "$TAGS_HOME/.tags/tag1/link2"

    run $TAGS search tag1
    assert_success
    assert_line $file1
    assert_line $file2
}

@test "cannot search for files with a non-existent tag" {
    run $TAGS search non-existent-tag
    assert_failure
}

@test "Fail on not passing required arguments" {
    run $TAGS search
    assert_failure
    assert_output "Provide a valid tag name!"
}
