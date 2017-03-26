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

@test "Not passing required arguments should fail" {
    run ../test.sh add
    assert_failure

    run ../test.sh add tempfile
    assert_failure
}

@test "Trying to tag a non-existent file should fail" {
    run ../test.sh add non-existent-file tag1
    assert_failure

    run ls "$TAGS_HOME/.tags/tag1"
    assert_output ""
}

@test "Trying to tag a directory should fail" {
    local tmp_dir=$(mktemp -d)
    run ../test.sh add tmp_dir tag1
    assert_failure

    run ls "$TAGS_HOME/.tags/tag1"
    assert_output ""
}

@test "Trying to tag a file with non-existent tag should create the tag" {
    local tf=$(mktemp)

    run ../tags.sh add $tf tag2
    assert_success

    assert_file_exist "$TAGS_HOME/.tags/tag2"
}

@test "Trying to tag a file with non-existent tag should tag file after tag creation" {
    local tf=$(mktemp)

    run ../tags.sh add $tf tag2
    assert_success

    run ls -l "$TAGS_HOME/.tags/tag2/"
    assert_output --partial $tf
}

@test "Tagging a file should work" {
    local tf=$(mktemp)

    run ../tags.sh add $tf tag1
    assert_success

    run ls -l "$TAGS_HOME/.tags/tag1/"
    assert_output --partial $tf
}

@test "Cannot duplicate tag a file" {
    local tf=$(mktemp)
    ln -s $tf "$TAGS_HOME/.tags/tag1/something"

    run ../tags.sh add $tf tag1
    assert_success

    nl=$(ls "$TAGS_HOME/.tags/tag1" | wc -l)
    assert_equal $nl 1

    run ls "$TAGS_HOME/.tags/tag1"
    assert_line "something"
}
