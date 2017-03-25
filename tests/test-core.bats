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

@test "Tags directory should get created not matter what" {
    run ../tags.sh
    assert_file_exist "$TAGS_HOME/.tags"
}

@test "Not passing any arguments should fail" {
    run ../tags.sh
    assert_failure
}
