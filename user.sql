DROP TABLE public.users;

CREATE TABLE public.users
(
  user_id integer NOT NULL DEFAULT nextval('user_user_id_seq'::regclass),
  name character varying(50) NOT NULL,
  CONSTRAINT user_pkey PRIMARY KEY (user_id),
  CONSTRAINT name_unique UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.users
  OWNER TO ubuntu;