
# Chat Api with Ruby on Rails

A simple chat api created with Ruby on Rails to understand more in depth about the language.



## Authors

- [@garryfishy](https://www.github.com/garryfishy)


## Run Locally

Clone the project

```bash
  git clone https://github.com/garryfishy/chat-app-ruby
```

Go to the project directory

```bash
  cd chat-app-ruby
```

Install dependencies

```bash
  gem install
```

Create Database

```
rake db:create
rake db:migrate
rake db:seed
```

Start the server

```bash
  rails server
```




## API Reference

#### Get all items

```http
  POST /api/login
```

| Body | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `username` | `string` | Your username (default username1) | 
| `password` | `string` | Your password (default username) |

#### Get item

```http
  POST /api/send/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | Id of reciever |

| Body | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `message`      | `integer` | Body for the chat message |

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `token`      | `integer` | Token recieved after login for authentication|

```http
  GET /api/messages/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | Id of reciever |

| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `token`      | `integer` | Token recieved after login for authentication|

```http
  GET /api/my-messages
```
| Headers | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `token`      | `integer` | Token recieved after login for authentication|

