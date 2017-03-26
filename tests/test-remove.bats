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

@test "Should fail if required arguments are not provided" {
    run ../tags.sh remove
    assert_failure

    run ../tags.sh remove anyfile
    assert_failure
}

@test "Should file if the file does not exist" {
    run ../tags.sh remove non-existent-file tag1
    assert_failure
}

@test "Should fail if tag does not exist" {
    local file=$(mktemp)
    ln -s $file "$TAGS_HOME/.tags/tag1/link"

    run ../tags.sh remove $file non-existent-tag
    assert_failure
}

@test "Should fail if file is not tagged with the given tag" {
    local file=$(mktemp)
    run ../tags.sh remove $file tag1
    assert_failure
}

@test "Should remove tag from the given file" {
    local file=$(mktemp)
    ln -s $file "$TAGS_HOME/.tags/tag1/link"

    run ../tags.sh remove $file tag1
    assert_success

    run ls "$TAGS_HOME/.tags/tag1"
    assert_output ""
}

@test "Should remove only the given file and not disturb the other files" {
    local file1=$(mktemp)
    local file2=$(mktemp)

    ln -s $file1 "$TAGS_HOME/.tags/tag1/link1"
    ln -s $file2 "$TAGS_HOME/.tags/tag1/link2"

    run ../tags.sh remove $file1 tag1
    assert_success

    run ls "$TAGS_HOME/.tags/tag1"
    assert_output "link2"
}
