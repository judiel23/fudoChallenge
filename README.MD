# FUDO API


Este proyecto es una API RESTful construida en Ruby usando Rack (sin Rails), que implementa autenticación con JWT, manejo de productos y un endpoint asíncrono.


## Características principales:

- Autenticación con JWT (/auth/login)

- Gestión de productos (/products y /products/:id)

- Creación de productos asíncrona (simulada con jobs y delay de 5 segundos)

- Middleware para validación de JWT

- Soporte de compresión GZIP en las respuestas si el cliente lo solicita

- Archivos estáticos: openapi.yaml y AUTHORS

- openapi.yaml → nunca cacheado

- AUTHORS → cacheado por 24h

- Dockerizado con Docker Compose

  

## Estructura de carpetas:

  ```

app/

├── domain/

│ └── products/

│ ├── product.rb

│ ├── product_repository.rb

│ ├── create_product.rb

│ ├── list_products.rb

│ └── find_product.rb

│ └── auth/

│ └── jwt_auth.rb

├── infrastructure/

│ └── web/

│ ├── app.rb

│ ├── routes/

│ │ ├── auth_routes.rb

│ │ └── products_routes.rb

│ ├── controllers/

│ │ └── products_controller.rb

│ ├── requests/

│ │ ├── login_request.rb

│ │ └── create_product_request.rb

│ ├── responses/

│ │ └── api_response.rb

│ └── middleware/

│ └── jwt_middleware.rb

│ └── jobs/

│ └── job_queue.rb

mock/

└── users_repository.rb

config.ru

Dockerfile

docker-compose.yml

openapi.yaml

AUTHORS

Gemfile

Gemfile.lock

README.txt
```
  

## Instrucciones para levantar el proyecto:

  

1. Clonar el repositorio:

  

```

git clone https://github.com/judiel23/fudoChallenge.git

```

  

```

cd fudoChallenge

```

  

2. Construir y levantar los contenedores con Docker Compose:

```

docker-compose build

```

  

```

docker-compose up

```

  

3. La API estará disponible en:

  

`http://localhost:3000`

  
  

## Uso de la API (CURLS):

  

### Login:

  
```
curl -X POST http://localhost:3000/auth/login \

-H "Content-Type: application/json" \

-d '{"email": "user1@example.com", "password": "password1"}'

  ```

### Crear producto:

  ```

curl -X POST http://localhost:3000/products \

-H "Content-Type: application/json" \

-H "Authorization: Bearer <token>" \

-d '{"name": "Producto Test", "price": 10.5}'

  ```

### Listar productos:

  ```

curl -X GET http://localhost:3000/products \

-H "Authorization: Bearer <token>"

  ```

### Obtener producto por ID:

  ```

curl -X GET http://localhost:3000/products/1 \

-H "Authorization: Bearer <token>"

  ```

Tambien esta disponible una collecion de postman en `Fudo.postman_collection.json`