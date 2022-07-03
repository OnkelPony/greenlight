--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: greenlight
--

CREATE TABLE public.movies
(
    id         bigint                                    NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    title      text                                      NOT NULL,
    year       integer                                   NOT NULL,
    runtime    integer                                   NOT NULL,
    genres     text[]                                    NOT NULL,
    version    integer                     DEFAULT 1     NOT NULL,
    CONSTRAINT genres_length_check CHECK (((array_length(genres, 1) >= 1) AND (array_length(genres, 1) <= 5))),
    CONSTRAINT movies_runtime_check CHECK ((runtime >= 0)),
    CONSTRAINT movies_year_check CHECK (((year >= 1888) AND
                                         ((year)::double precision <= date_part('year'::text, now()))))
);


ALTER TABLE public.movies
    OWNER TO greenlight;

--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: greenlight
--

CREATE SEQUENCE public.movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_id_seq
    OWNER TO greenlight;

--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: greenlight
--

ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: greenlight
--

CREATE TABLE public.schema_migrations
(
    version bigint  NOT NULL,
    dirty   boolean NOT NULL
);


ALTER TABLE public.schema_migrations
    OWNER TO greenlight;

--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: greenlight
--

ALTER TABLE ONLY public.movies
    ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: greenlight
--

COPY public.movies (id, created_at, title, year, runtime, genres, version) FROM stdin;
1	2022-07-03 22:25:33+02	Moana	2016	107	{animation,adventure}	1
2	2022-07-03 22:34:45+02	Black Panther	2018	134	{action,adventure}	1
3	2022-07-03 22:35:13+02	Deadpool	2016	108	{action,comedy}	1
4	2022-07-03 22:35:36+02	The Breakfast Club	1986	96	{drama}	1
5	2022-07-03 23:00:28+02	Deep Inside Celeste	2004	180	{adult}	1
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: greenlight
--

COPY public.schema_migrations (version, dirty) FROM stdin;
2	f
\.


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: greenlight
--

SELECT pg_catalog.setval('public.movies_id_seq', 5, true);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: greenlight
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: greenlight
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- PostgreSQL database dump complete
--

