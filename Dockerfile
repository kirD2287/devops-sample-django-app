# Используем официальный образ Python из Docker Hub
FROM python:3.8-slim

# Устанавливаем необходимые пакеты для сборки и PCRE
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libpcre3 \
    libpcre3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файл с зависимостями
COPY requirements.txt /app/

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем файлы проекта
COPY . /app/

# Открываем порт, на котором будет работать приложение
EXPOSE 8000

# Команда для запуска приложения 
CMD ["sh", "-c", "python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000"]
