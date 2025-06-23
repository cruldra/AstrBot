FROM python:3.11-slim
WORKDIR /AstrBot

COPY . /AstrBot/

# 设置代理环境变量
ENV http_proxy=http://192.168.1.5:7890
ENV https_proxy=http://192.168.1.5:7890
ENV HTTP_PROXY=http://192.168.1.5:7890
ENV HTTPS_PROXY=http://192.168.1.5:7890
ENV no_proxy=localhost,127.0.0.1,::1
ENV NO_PROXY=localhost,127.0.0.1,::1

# 配置 apt 使用代理
RUN echo 'Acquire::http::proxy "http://192.168.1.5:7890";' > /etc/apt/apt.conf.d/95proxies \
    && echo 'Acquire::https::proxy "http://192.168.1.5:7890";' >> /etc/apt/apt.conf.d/95proxies

RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    gcc \
    build-essential \
    python3-dev \
    libffi-dev \
    libssl-dev \
    ca-certificates \
    bash \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install uv
RUN uv pip install -r requirements.txt --no-cache-dir --system
RUN uv pip install socksio uv pilk --no-cache-dir --system

EXPOSE 6185 
EXPOSE 6186

CMD [ "python", "main.py" ]



