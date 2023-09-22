#!/bin/bash
#
# delete.sh delete-todo <todo-id>
# delete.sh delete-done
#
# Usage:
#    delete.sh delete-todo 99
#    delete.sh delete-done
#

echo "Your code"

delete_todo(){
psql <<EOF
  DELETE FROM basic_schema.todo
  WHERE basic_schema.todo.id = '$1'
EOF
}

delete_done(){
psql <<EOF
  DELETE FROM basic_schema.todo
  WHERE basic_schema.todo.done = true
EOF
}

main(){
  if [[ "$1" == "delete-todo" ]]
  then delete_todo "$2"
  elif [[ "$1" == "delete-done" ]]
  then delete_done
  fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then main "$@"
fi
