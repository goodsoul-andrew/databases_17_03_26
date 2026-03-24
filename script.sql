-- https://github.com/goodsoul-andrew/databases_17_03_26
CREATE TABLE IF NOT EXISTS products
(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    brand_id uuid NOT NULL,
    category_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    weight numeric NOT NULL CHECK (weight >= 0),
    count integer NOT NULL DEFAULT 0 CHECK (count >= 0),
    price numeric NOT NULL DEFAULT 0 CHECK (price >= 0)
);

CREATE TABLE IF NOT EXISTS brands
(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    title character varying(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS orders
(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    payment_status boolean NOT NULL DEFAULT false,
    delivery_status boolean NOT NULL DEFAULT false,
    delivery_address character varying(255),
    user_id uuid NOT NULL
);

CREATE TABLE IF NOT EXISTS orders_products
(
    order_id uuid NOT NULL,
    product_id uuid NOT NULL,
    count integer NOT NULL DEFAULT 1,
    fix_price numeric NOT NULL DEFAULT 0,
    PRIMARY KEY(order_id, product_id)
);

CREATE TABLE IF NOT EXISTS categories
(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    title character varying(255) NOT NULL UNIQUE,
    parent_category_id uuid
);

CREATE TABLE IF NOT EXISTS baskets
(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL
);

CREATE TABLE IF NOT EXISTS baskets_products
(
    basket_id uuid NOT NULL,
    product_id uuid NOT NULL,
    count integer NOT NULL DEFAULT 1,
    PRIMARY KEY (basket_id, product_id)
);

CREATE TABLE IF NOT EXISTS users
(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL UNIQUE
);

ALTER TABLE IF EXISTS products
    ADD FOREIGN KEY (brand_id)
    REFERENCES brands (id)
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS products
    ADD FOREIGN KEY (category_id)
    REFERENCES categories (id)
    ON DELETE SET NULL;


ALTER TABLE IF EXISTS orders
    ADD FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS orders_products
    ADD FOREIGN KEY (order_id)
    REFERENCES orders (id)
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS orders_products
    ADD FOREIGN KEY (product_id)
    REFERENCES products (id)
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS categories
    ADD FOREIGN KEY (parent_category_id)
    REFERENCES categories (id)
    ON DELETE SET NULL;


ALTER TABLE IF EXISTS baskets
    ADD FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS baskets_products
    ADD FOREIGN KEY (basket_id)
    REFERENCES baskets (id)
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS baskets_products
    ADD FOREIGN KEY (product_id)
    REFERENCES products (id)
    ON DELETE CASCADE;
