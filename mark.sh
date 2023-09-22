#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
#

mark_todo(){
    psql <<EOF
    UPDATE basic_schema.todo
    SET "done" = true
    WHERE basic_schema.todo.id =('$1')
EOF
echo "Marked as done."
}

unmark_todo(){
    psql <<EOF
    UPDATE basic_schema.todo
    SET "done" = false
    WHERE basic_schema.todo.id =('$1')
EOF
}

main() {
if [[ "$1" == "mark-todo" ]]
then
  mark_todo "$2"
elif [[ "$1" == "unmark-todo" ]]
then
  unmark_todo "$2"
fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    main "$@"
fi
