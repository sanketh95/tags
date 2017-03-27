tags
====

Tag files to create more complex file relations.

Usage
=====
```
tags is a command-line tool to tag files to create complex structures

Usage:
    tags <option> <arguments>

Options:
    add|a <filepath> <tagname>          - Add a new tag to file
    remove|rm <filepath> <tagname>      - Remove a tag from file
    addtag|at <tagname>                 - Create a new tag
    removetag|rmt <tagname>             - Delete a tag
    list|ls                             - List all tags or list for a file
    search|s <tagname>                  - Search all files with a tag name
```

Running tests
==============

```sh
cd tests
./test-*
```

Todo
====

* Add functionality to search for all tags for a file
* Add continuous integration
