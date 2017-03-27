#!/usr/bin/env bash

DEFAULT_TAGS_HOME=${TAGS_HOME:-$HOME}
DEFAULT_TAGS_DIR=".tags"

usage() {
cat <<EOF
tags is a command-line tool to tag files to create complex structures

Usage:
    tags.sh <option> <arguments>

Options:
    add|a <filepath> <tagname>          - Add a new tag to file
    remove|rm <filepath> <tagname>      - Remove a tag from file
    addtag|at <tagname>                 - Create a new tag
    removetag|rmt <tagname>             - Delete a tag
    list|ls                             - List all tags or list for a file
    search|s <tagname>                  - Search all files with a tag name
EOF
}

get_tags_dir() {
    echo "$DEFAULT_TAGS_HOME/$DEFAULT_TAGS_DIR"
}

get_tag_dir() {
    local tags_dir=$(get_tags_dir)
    echo "$tags_dir/$1"
}

check_and_create_base_folder() {
    local tags_dir=$(get_tags_dir)
    if [ ! -d $tags_dir ]; then
        mkdir $tags_dir &>/dev/null
        local ret=$?

        if [ $ret -ne 0 ]; then
            printf "Failed to create tags folder : $tags_dir!\n"
            return 1
        fi

        return 0
    fi
}

get_linked_file_name() {
    if [ $# -lt 2 ]; then
        return 1
    fi

    local filepath=$1
    local tag=$2
    local tag_dir=$(get_tag_dir $tag)

    find -L $tag_dir -samefile $filepath
}

create_tag() {
    if [ $# -lt 1 ]; then
        printf "Provide a valid tag name!\n"
        return 1
    fi

    local tag_name=$1
    local tag_dir=$(get_tag_dir $tag_name)

    if [ -d $tag_dir ]; then
        return 0;
    fi

    mkdir $tag_dir &>/dev/null
    ret=$?

    if [ $ret -ne 0 ]; then
        printf "Failed to create tag $tag_name"
        return 1
    else
        printf "Created tag $tag_name"
        return 0
    fi
}

delete_tag() {
    if [ $# -lt 1 ]; then
        printf "Provide a valid tag name to remove!\n"
        return 1
    fi

    local tag_name=$1
    local tag_dir=$(get_tag_dir $tag_name)

    rm -rf $tag_dir

    if [ $? -ne 0 ]; then
        printf "Failed to delete tag $tag_name\n"
        return 1
    else
        printf "Deleted tag $tag_name\n"
        return 0
    fi
}

tag_file(){
    if [ $# -lt 2 ]; then
        printf "Expected filename and tagname !\n"
        return 1
    fi

    local file_path=$1
    local tag_name=$2
    local tag_dir=$(get_tag_dir $tag_name)
    local filename=$(create_random_string)
    local link_path="$tag_dir/$filename"

    if [ ! -f $file_path ]; then
        printf "$1 does not exist or is not a file"
        return 1;
    fi

    local ln_file_if_exists=$(get_linked_file_name $file_path $tag_name)

    if [ ! -z $ln_file_if_exists ]; then
        return 0
    fi

    create_tag $tag_name

    ln -s $file_path $link_path
}

tag_exists() {
    if [ $# -lt 1 ]; then
        printf "Provide a valid tag name !\n"
        return 1
    fi

    local tag_name=$1
    local tag_dir=$(get_tag_dir $tag_name)

    if [ -d $tag_dir ]; then
        return 1;
    else
        return 0;
    fi
}

create_random_string(){
   cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32
}

search_tag(){
    if [ $# -lt 1 ]; then
        printf "Provide a valid tag name!\n"
        return 1
    fi

    local tag_name=$1
    local tag_dir=$(get_tag_dir $tag_name)

    readlink $tag_dir/*
}

list_tags(){

    tags_dir=$(get_tag_dir);

    ls $tags_dir;
}

remove_tag(){
    if [ $# -lt 2 ]; then
        printf "Expected filename and tag name!\n"
        return 1
    fi

    local filepath=$1
    local tag_name=$2
    local tag_dir=$(get_tag_dir $tag_name)

    linked_file_name=$(get_linked_file_name $filepath $tag_name)

    rm $linked_file_name
    ret=$?

    if [ $ret -ne 0 ]; then
        printf "Failed to remove tag $tag_name from file $filepath"
        return 1
    else
        printf "Removed tag $tag_name from file $filepath"
        return 0
    fi
}

main() {
    local ret=0
    local cmd=""

    check_and_create_base_folder

    if [ -z "$1" ]; then
        printf "Command not specified !\n"
        usage
        return 1
    fi

    case $1 in
        "add"|"a")
            cmd="tag_file"
        ;;

        "remove"|"rm")
            cmd="remove_tag"
        ;;

        "addtag"|"at")
             cmd="create_tag"
        ;;
        "removetag"|"rmt")
            cmd="delete_tag"
        ;;
        "search"|"s")
            cmd="search_tag"
        ;;
        "list"|"ls")
            cmd="list_tags"
        ;;
        "--help"|"-h")
            cmd="usage"
        ;;
        *)
            cmd="usage"
        ;;
    esac
    shift;

    if [ $? -ne 0 ]; then
        return 1
    fi

    $cmd $@
}

main $@
