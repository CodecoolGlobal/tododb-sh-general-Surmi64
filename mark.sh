#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#

mark_todo() {
    psql <<EOF
UPDATE "todos" SET done = true WHERE todo_id=('$1')
EOF
}

unmark_todo() {
    psql <<EOF
UPDATE "todos" SET done = false WHERE todo_id = '$1'
EOF
}


main() {
    if [[ "$1" == "mark-todo" ]]
    then 
        echo "1"
        mark_todo "$2"
    elif [[ "$1" == "unmark-todo" ]]
    then
        echo "2"
        unmark_todo "$2"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
