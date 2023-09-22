#!/bin/bash
#
# add.sh add-user <user>
# add.sh add-todo <user> <todo>
#
# Usage:
#    add.sh add-user John
#    add.sh add-user Paul
#    add.sh add-todo John Meeting
#    add.sh add-todo Paul "Make breakfast"
#

add_user() {
    psql <<EOF
    INSERT INTO basic_schema.user (name)
    VALUES ('$1');
EOF
    echo "$1 added to user-table."
}

add_todo() {
    psql <<EOF
INSERT INTO basic_schema.todo (user_id, task) 
VALUES ((SELECT id FROM basic_schema.user WHERE name ILIKE ('$1')), ('$2'))
EOF
}

main() {
    if [[ "$1" == "add-user" ]]
    then
        add_user "$2"
    elif [[ "$1" == "add-todo" ]]
    then
        add_todo "$2" "$3"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
