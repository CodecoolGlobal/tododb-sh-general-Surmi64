DROP TABLE public.todos;

CREATE TABLE public.todos
(
  todo_id integer NOT NULL DEFAULT nextval('todos_todo_id_seq'::regclass),
  task character varying(100) NOT NULL,
  user_id integer NOT NULL,
  done boolean DEFAULT false,
  CONSTRAINT todos_pkey PRIMARY KEY (todo_id),
  CONSTRAINT fk_userid_userid FOREIGN KEY (user_id)
      REFERENCES public.users (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.todos
  OWNER TO ubuntu;