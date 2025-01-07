# Микросервис ToDo на базе FastAPI

## Описание
Данный репозиторий содержи реализацию сервиса "ToDo" для формирования списка ежедневных задач на базе фреймворка FastAPI.
В приложении реализованы следующие функции:

1) Получение списка всех задач с возможностью фильрации по признаку завершенные/незавершенные
2) Получение конкретной задачи по ID
3) Создание новой задачи
4) Обновление атрибутов существующей задачи (например статус завершена/незавершена)
5) Удаление всех завершенных задач
6) Удаление конкретной задачи по ID

## Технологии
- **FastAPI**: Фреймворк для создания API.
- **Pydantic**: Библиотека предназначенная для валидации данных.
- **SQLAlchemy**: ORM для работы с базой данных.
- **Uvicorn**: ASGI сервер для запуска приложения.

---

## Запуск сервиса
1. Создание тома:
   
    ```docker volume create todo_data```

2. Сборка образа:
   
    ```docker build -t todo-sqlite:latest .```  

3. Запуск контейнера:
   
    ```docker run -d -p 8000:80 -v todo_data:/app/data todo-sqlite:latest```
   
![image](https://github.com/user-attachments/assets/62ac5d38-5ee6-4890-9f14-8add83694b0e)

**Запустить сервис локально можно по следующему URL:**  
    ```http://localhost:8000/docs```  


### Эндпоинты

    GET /items/: Получение списка всех задач с возможностью фильрации по признаку завершенные/незавершенные
    POST /items/: Создание новой задачи
    DELETE /items/: Удаление всех завершенных задач
    GET /items/{item_id}: Получение конкретной задачи по ID
    PUT /items/{item_id}: Обновление атрибутов существующей задачи (например статус завершена/незавершена)
    DELETE /items/{item_id}: Удаление конкретной задачи по ID
    

![image](https://github.com/user-attachments/assets/0df21db1-bbfc-46fa-9c53-c48a9fc0fc57)

  ### Примеры запросов к сервису:  
  **Создание задачи:**  
```
curl -X 'POST' \
  'http://localhost:8000/items' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "title": "Do homework",
  "description": "Do final task for Mentor'\''s Seminar",
  "completed": false
}'

curl -X 'POST' \
  'http://localhost:8000/items' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "title": "Go sleep",
  "description": "Go to sleep at 23:00 PM",
  "completed": false
}'
```

**Ответ:**  
```
{
  "id": 1,
  "title": "Do homework",
  "description": "Do final task for Mentor's Seminar",
  "completed": false
}

{
  "id": 2,
  "title": "Go sleep",
  "description": "Go to sleep at 23:00 PM",
  "completed": false
}
```

**Вывод задачи по ID:**  
```
curl -X 'GET' \
  'http://localhost:8000/items/2' \
  -H 'accept: application/json'
```

**Ответ:** 
```
{
  "id": 2,
  "title": "Go sleep",
  "description": "Go to sleep at 23:00 PM",
  "completed": false
}
```

**Удаление задачи по ID:**  
```
curl -X 'DELETE' \
  'http://localhost:8000/items/2' \
  -H 'accept: application/json'
```

**Ответ:**
```
{
  "message": "Item deleted"
}
```

**Обновление статуса задачи:**  
```
curl -X 'PUT' \
  'http://localhost:8000/items/1' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '  {
    "title": "Do homework",
    "description": "Do final task for Mentor'\''s Seminar",
    "completed": true
  }'
```

**Ответ:**
```
{
  "id": 1,
  "title": "Do homework",
  "description": "Do final task for Mentor's Seminar",
  "completed": true
}
```

**Получение всех завершенных задач:**  
```
curl -X 'GET' \
  'http://localhost:8000/items?iscompleted=true' \
  -H 'accept: application/json'
```

**Ответ:**
```
[
  {
    "id": 1,
    "title": "Do homework",
    "description": "Do final task for Mentor's Seminar",
    "completed": true
  }
]
```

**Удаление всех завершенных задач:**  
```
curl -X 'DELETE' \
  'http://localhost:8000/items' \
  -H 'accept: application/json'
```

**Ответ:**
```
{
  "message": "All completed items have been deleted"
}
```
  
