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
    INSERT INTO "users" (name) 
    VALUES ('$1');
EOF
    echo "$1 added to users table."
}

add_todo() {
    echo "User: $2"
    echo "Todo: $1"
    psql <<EOF
    INSERT INTO todos (task, user_id)
    SELECT '$1', user_id
    FROM users
    WHERE users.name ILIKE '$2';
EOF
    echo "$1 todo added to the todos table with $2's id."
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
