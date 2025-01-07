# Микросервис ShortURL на базе FastAPI

## Описание
Данный репозиторий содержит реализацию сервиса "ShortURL" для сокращения URL на базе фреймворка FastAPI.
В приложении реализованы следующие функции:

1) Генерация уникального короткого идентификатора для любой валидной ссылки
2) Переход на оригинальный URL по короткой ссылке
3) Удаление сокращённой ссылки
4) Статистика по конкретной сокращённой ссылке

## Технологии
- **FastAPI**: Фреймворк для создания API.
- **Pydantic**: Библиотека предназначенная для валидации данных.
- **SQLAlchemy**: ORM для работы с базой данных.
- **Uvicorn**: ASGI сервер для запуска приложения.

---

## Запуск сервиса
1. Создание тома:
   
    ```docker volume create shorturl_data```

2. Сборка образа:
   
    ```docker build -t shorturl-sqlite:latest .```  

3. Запуск контейнера:
   
    ```docker run -d -p 8000:80 -v shorturl_data:/app/data shorturl-sqlite:latest```
   
![image](https://github.com/user-attachments/assets/b1ed754c-9578-480f-8f76-f9099ffafe22)

**Запустить сервис локально можно по следующему URL:**  
    ```http://localhost:8001/docs```  

### Эндпоинты

    POST /shorten/: Генерация уникального короткого идентификатора для любой валидной ссылки
    GET /{short_id}/: Переход на оригинальный URL по короткой ссылке
    DELETE /{short_id}/: Удаление сокращённой ссылки
    GET /stats/{short_id}: Статистика по конкретной сокращённой ссылке
    
![image](https://github.com/user-attachments/assets/7d25c74f-f940-4468-ad8f-1b932d4d17ee)

  ### Примеры запросов к сервису:  
  **Создание короткого ID:**  
```
curl -X 'POST' \
  'http://localhost:8001/shorten' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "url": "https://example1.com/"
}'
```

**Ответ:**  
```
{
  "short_url": "http://localhost:8001/K1WSkQ"
}
```

**Вывод информации по короткому ID:**  
```
curl -X 'GET' \
  'http://localhost:8001/stats/K1WSkQ' \
  -H 'accept: application/json''
```

**Ответ:** 
```
{
  "short_id": "K1WSkQ",
  "full_url": "https://example1.com/"
}
```

**Удаление сокращенной ссылки по ID:**  
```
curl -X 'DELETE' \
  'http://localhost:8001/K1WSkQ' \
  -H 'accept: application/json'
```

**Ответ:**
```
{
  "detail": "Короткая ссылка удалена"
}
```
