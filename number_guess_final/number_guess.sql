--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: data; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.data (
    user_id integer NOT NULL,
    name character varying(22) NOT NULL,
    games_played integer DEFAULT 0 NOT NULL,
    best_game integer
);


ALTER TABLE public.data OWNER TO freecodecamp;

--
-- Name: data_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.data_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_user_id_seq OWNER TO freecodecamp;

--
-- Name: data_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.data_user_id_seq OWNED BY public.data.user_id;


--
-- Name: data user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.data ALTER COLUMN user_id SET DEFAULT nextval('public.data_user_id_seq'::regclass);


--
-- Data for Name: data; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.data VALUES (18, '4', 1, 2);
INSERT INTO public.data VALUES (20, 'user_1677624149258', 2, 493);
INSERT INTO public.data VALUES (3, 'Waschi', 8, 7);
INSERT INTO public.data VALUES (19, 'user_1677624149259', 4, 147);
INSERT INTO public.data VALUES (2, 'Patrick', 2, 3);
INSERT INTO public.data VALUES (9, 'user_1677622762972', 2, 1001);
INSERT INTO public.data VALUES (8, 'user_1677622762973', 4, 265);
INSERT INTO public.data VALUES (11, 'user_1677622804928', 2, 451);
INSERT INTO public.data VALUES (10, 'user_1677622804929', 5, 38);
INSERT INTO public.data VALUES (13, 'user_1677622843352', 2, 774);
INSERT INTO public.data VALUES (12, 'user_1677622843353', 4, 153);
INSERT INTO public.data VALUES (15, 'user_1677622911001', 2, 452);
INSERT INTO public.data VALUES (14, 'user_1677622911002', 5, 300);
INSERT INTO public.data VALUES (1, 'Robin', 31, 8);
INSERT INTO public.data VALUES (21, '1', 5, 1);
INSERT INTO public.data VALUES (17, 'user_1677622955860', 2, 299);
INSERT INTO public.data VALUES (16, 'user_1677622955861', 5, 153);
INSERT INTO public.data VALUES (22, 'Peter', 2, 10);


--
-- Name: data_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.data_user_id_seq', 22, true);


--
-- Name: data data_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.data
    ADD CONSTRAINT data_name_key UNIQUE (name);


--
-- Name: data data_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.data
    ADD CONSTRAINT data_pkey PRIMARY KEY (user_id);


--
-- PostgreSQL database dump complete
--

