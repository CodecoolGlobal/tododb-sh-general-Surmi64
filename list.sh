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
    SELECT * FROM "users"
EOF
}

list_todos() {
    psql <<EOF
    SELECT * FROM "todos"
EOF
}

list_user_todos() {
    psql <<EOF
    SELECT * FROM "users"
    INNER JOIN todos
    ON users.user_id = todos.user_id
    ORDER BY users.name;
EOF
}

list_user_todos_by_user() {
    psql <<EOF
    SELECT * FROM users
    INNER JOIN todos
    ON users.user_id = todos.user_id
    WHERE users.name ILIKE '$1';
EOF
}

main() {
    if [[ "$1" == "list-users" ]]
    then
        list_users
    elif [[ "$1" == "list-todos" ]]
    then
        list_todos
    elif [ "$1" == "list-user-todos" ] && [[ "$2" =~ [a-z] ]]
    then
        list_user_todos_by_user "$2"
    elif [[ "$1" == "list-user-todos" ]]
    then
        list_user_todos
    else
        echo "Please specify at least one parameter: list-users, list-todos, list-user-todos <name>, or list-user-todos to all todo with users."
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
