#!/bin/bash
#
# list.sh list-users
# list.sh list-todos
# list.sh list-user-todos
#
# Usage:
#    list.sh list-users
#    list.sh list-todos Paul
#    list.sh list-user-todos John
#    list.sh list-user-todos "John Doe"
#

list_users() {
    psql <<EOF
SELECT * FROM basic_schema.user
EOF
}

list_todos() {
    psql <<EOF
SELECT * FROM basic_schema.todo
EOF
}

list_user_todos() {
    psql <<EOF
SELECT name, user_id, task, "done" FROM basic_schema.user
INNER JOIN basic_schema.todo
on basic_schema.user.id = basic_schema.todo.user_id
ORDER BY basic_schema.user.name
EOF
}

main() {
    if [[ "$1" == "list-users" ]]
    then
        list_users
    elif [[ "$1" == "list-todos" ]]
    then
        list_todos
    elif [[ "$1" == "list-user-todos" ]]
    then
        list_user_todos "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
