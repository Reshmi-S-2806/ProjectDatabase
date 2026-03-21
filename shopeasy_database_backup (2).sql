--
-- PostgreSQL database dump
--

\restrict 6noYEw2fIXgPzUmIKDVhv0YrBDLw0SLwZE65kcbcqrQBDQJozTIFQrrVOnoLcnB

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    id integer NOT NULL,
    user_id integer,
    product_id integer,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT cart_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_id_seq OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer,
    product_id integer,
    product_name character varying(200) NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount numeric(10,2) NOT NULL,
    shipping_address text NOT NULL,
    shipping_city character varying(50) NOT NULL,
    shipping_state character varying(50) NOT NULL,
    shipping_pincode character varying(10) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying,
    payment_status character varying(50) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    category character varying(50),
    image_url character varying(500),
    stock_quantity integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    order_id integer,
    user_id integer,
    amount numeric(10,2) NOT NULL,
    payment_method character varying(50) NOT NULL,
    transaction_id character varying(100) NOT NULL,
    payment_status character varying(50) DEFAULT 'completed'::character varying,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    age integer,
    email character varying(100) NOT NULL,
    phone character varying(15) NOT NULL,
    password character varying(255) NOT NULL,
    address text,
    city character varying(50),
    state character varying(50),
    pincode character varying(10),
    is_admin boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_age_check CHECK ((age >= 18))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (id, user_id, product_id, quantity, created_at) FROM stdin;
66	2	8	1	2026-02-26 05:14:24.221368
68	2	2	1	2026-02-26 05:53:42.055201
69	2	3	1	2026-02-26 05:53:44.082403
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, product_name, quantity, price, subtotal) FROM stdin;
1	1	1	Smartphone X	1	59999.00	59999.00
2	2	2	Laptop Pro	1	89999.00	89999.00
3	2	3	Wireless Headphones	1	2999.00	2999.00
4	2	1	Smartphone X	1	59999.00	59999.00
5	3	1	Smartphone X	1	59999.00	59999.00
6	4	1	Smartphone X	2	59999.00	119998.00
7	5	4	Smart Watch	1	3999.00	3999.00
8	5	2	Laptop Pro	1	89999.00	89999.00
9	5	3	Wireless Headphones	1	2999.00	2999.00
10	6	4	Smart Watch	2	3999.00	7998.00
11	6	14	Cookbook	1	599.00	599.00
12	6	15	Self-Help Book	1	499.00	499.00
13	6	7	Designer Jeans	1	1999.00	1999.00
14	6	8	Leather Jacket	1	4999.00	4999.00
15	6	1	Smartphone X	1	59999.00	59999.00
16	6	2	Laptop Pro	6	89999.00	539994.00
17	7	4	Smart Watch	1	3999.00	3999.00
18	7	2	Laptop Pro	2	89999.00	179998.00
19	7	3	Wireless Headphones	1	2999.00	2999.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, order_date, total_amount, shipping_address, shipping_city, shipping_state, shipping_pincode, status, payment_status, created_at) FROM stdin;
1	2	2026-02-18 03:37:58.086174	59999.00	36,Prasanthi Nagar, 2nd Street,	Chennai	Tamil Nadu	612401	pending	completed	2026-02-18 03:37:58.086174
2	2	2026-02-18 03:53:21.352402	152997.00	36,Prasanthi Nagar, 2nd Street, Valliyamai Garden,	Kumbakonam	Tamil Nadu	612401	pending	completed	2026-02-18 03:53:21.352402
3	2	2026-02-18 04:01:37.227111	59999.00	36,Prasanthi Nagar, 2nd Street,	Chennai	Tamil Nadu	612401	pending	completed	2026-02-18 04:01:37.227111
4	2	2026-02-18 04:49:50.510614	119998.00	36,Prasanthi Nagar, 2nd Street, Valliyamai Garden,	Kumbakonam	Tamil Nadu	612401	pending	completed	2026-02-18 04:49:50.510614
5	2	2026-02-18 04:57:27.450752	96997.00	36,Prasanthi Nagar, 2nd Street, Valliyamai Garden,	Kumbakonam	Tamil Nadu	612401	pending	completed	2026-02-18 04:57:27.450752
6	2	2026-02-26 05:00:12.806091	616087.00	36,Prasanthi Nagar, 2nd Street, Valliyamai Garden,	Kumbakonam	Tamil Nadu	612401	pending	completed	2026-02-26 05:00:12.806091
7	2	2026-02-26 05:05:04.991633	186996.00	36,Prasanthi Nagar, 2nd Street, Valliyamai Garden,	Kumbakonam	Tamil Nadu	612401	pending	completed	2026-02-26 05:05:04.991633
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, description, price, category, image_url, stock_quantity, created_at) FROM stdin;
4	Smart Watch	Fitness tracking smartwatch	3999.00	Electronics	data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22400%22%20height%3D%22400%22%3E%3Crect%20width%3D%22400%22%20height%3D%22400%22%20fill%3D%22%23e67e22%22%2F%3E%3Ctext%20x%3D%2250%22%20y%3D%22150%22%20font-family%3D%22Arial%22%20font-size%3D%2224%22%20fill%3D%22white%22%3ESmart%20Watch%3C%2Ftext%3E%3C%2Fsvg%3E	71	2026-02-18 02:26:57.927121
2	Laptop Pro	High-performance laptop for professionals	89999.00	Electronics	data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22400%22%20height%3D%22400%22%3E%3Crect%20width%3D%22400%22%20height%3D%22400%22%20fill%3D%22%232ecc71%22%2F%3E%3Ctext%20x%3D%2250%22%20y%3D%22150%22%20font-family%3D%22Arial%22%20font-size%3D%2224%22%20fill%3D%22white%22%3ELaptop%20Pro%3C%2Ftext%3E%3C%2Fsvg%3E	20	2026-02-18 02:26:57.927121
9	Cotton T-shirt	100% cotton plain t-shirt	599.00	Fashion	https://picsum.photos/200/200?random=9	100	2026-02-26 03:58:10.853727
10	Sofa Set	3-seater comfortable sofa	15999.00	Home	https://picsum.photos/200/200?random=10	10	2026-02-26 03:58:10.853727
11	Dining Table	Wooden dining table with 4 chairs	12999.00	Home	https://picsum.photos/200/200?random=11	8	2026-02-26 03:58:10.853727
12	Bed Sheet Set	Cotton bed sheet set	999.00	Home	https://picsum.photos/200/200?random=12	60	2026-02-26 03:58:10.853727
3	Wireless Headphones	Premium noise-cancelling headphones	2999.00	Electronics	data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22400%22%20height%3D%22400%22%3E%3Crect%20width%3D%22400%22%20height%3D%22400%22%20fill%3D%22%239b59b6%22%2F%3E%3Ctext%20x%3D%2250%22%20y%3D%22150%22%20font-family%3D%22Arial%22%20font-size%3D%2224%22%20fill%3D%22white%22%3EWireless%20Headphones%3C%2Ftext%3E%3C%2Fsvg%3E	97	2026-02-18 02:26:57.927121
13	Fiction Novel	Bestselling fiction novel	399.00	Books	https://picsum.photos/200/200?random=13	200	2026-02-26 03:58:10.853727
17	Running Shoes	Comfortable running shoes for daily workout	2999.00	Fashion	\N	45	2026-02-26 05:18:19.048415
18	Coffee Table	Modern coffee table with glass top	5999.00	Home	\N	15	2026-02-26 05:18:19.048415
14	Cookbook	100 healthy recipes	599.00	Books	https://picsum.photos/200/200?random=14	79	2026-02-26 03:58:10.853727
15	Self-Help Book	Transform your life	499.00	Books	https://picsum.photos/200/200?random=15	119	2026-02-26 03:58:10.853727
7	Designer Jeans	Premium quality denim jeans	1999.00	Fashion	https://picsum.photos/200/200?random=7	49	2026-02-26 03:58:10.853727
8	Leather Jacket	Genuine leather jacket	4999.00	Fashion	https://picsum.photos/200/200?random=8	19	2026-02-26 03:58:10.853727
1	Smartphone X	Latest smartphone with amazing features	59999.00	Electronics	data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22400%22%20height%3D%22400%22%3E%3Crect%20width%3D%22400%22%20height%3D%22400%22%20fill%3D%22%233498db%22%2F%3E%3Ctext%20x%3D%2250%22%20y%3D%22150%22%20font-family%3D%22Arial%22%20font-size%3D%2224%22%20fill%3D%22white%22%3ESmartphone%20X%3C%2Ftext%3E%3C%2Fsvg%3E	44	2026-02-18 02:26:57.927121
19	Science Book	Understanding the universe and beyond	799.00	Books	\N	50	2026-02-26 05:18:19.048415
21	Floor Lamp	Modern floor lamp for living room	2499.00	Home	\N	25	2026-02-26 05:36:06.796176
22	Leather Belt	Genuine leather belt	899.00	Fashion	\N	40	2026-02-26 05:37:05.533316
23	History Book	World history explained	699.00	Books	\N	35	2026-02-26 05:37:32.474406
24	Digital Camera	24MP mirrorless camera with 4K video recording	45999.00	Electronics	\N	25	2026-02-26 05:40:32.832075
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, order_id, user_id, amount, payment_method, transaction_id, payment_status, transaction_date) FROM stdin;
1	1	2	59999.00	upi	TXN17713660969424f6ob	completed	2026-02-18 03:38:16.943467
2	2	2	152997.00	card	TXN1771367043458vdz7i	completed	2026-02-18 03:54:03.458435
3	3	2	59999.00	netbanking	TXN177136755513851veo	completed	2026-02-18 04:02:35.138969
4	4	2	119998.00	upi	TXN17713704022239lsgf	completed	2026-02-18 04:50:02.230098
5	5	2	96997.00	upi	TXN1771370863677i4vva	completed	2026-02-18 04:57:43.679284
6	6	2	616087.00	upi	TXN1772062218834yw52d	completed	2026-02-26 05:00:18.835683
7	7	2	186996.00	upi	TXN17720625144196h478	completed	2026-02-26 05:05:14.418959
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, age, email, phone, password, address, city, state, pincode, is_admin, created_at, updated_at) FROM stdin;
2	Super Admin	30	superadmin@shopeasy.com	99999999999	$2a$10$sVoS7gjKeb9VrpSX7cerDOPeM6I5b3EZ6yB0ZCCfiOWYkO0VAO..G	\N	\N	\N	\N	t	2026-02-18 02:40:56.307192	2026-02-18 02:40:56.307192
5	Reshmi	21	reshmis@gmail.com	9999999999	$2a$10$DElZMf0htn0TNDiCE2hw.O3L9Vtfb.20RAi.CimruBc/wVHsb.dSm	\N	\N	\N	\N	f	2026-02-26 03:30:43.699263	2026-02-26 03:30:43.699263
\.


--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_id_seq', 69, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 19, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 7, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 24, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 7, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: cart cart_user_id_product_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_id_product_id_key UNIQUE (user_id, product_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_transaction_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_transaction_id_key UNIQUE (transaction_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cart cart_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: cart cart_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 6noYEw2fIXgPzUmIKDVhv0YrBDLw0SLwZE65kcbcqrQBDQJozTIFQrrVOnoLcnB

