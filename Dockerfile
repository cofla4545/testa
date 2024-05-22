# 베이스 이미지 설정
FROM cloudtype/python:3.8

# 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Node.js 및 npm 버전 확인 (이미 캐시됨)
RUN node -v && npm -v

# 작업 디렉토리 설정
WORKDIR /app

# requirements.txt 파일 복사
COPY ./requirements.txt* ./

# gunicorn 설치
RUN pip install gunicorn

# requirements.txt 파일에 있는 모든 패키지 설치
RUN if [ -f "./requirements.txt" ]; then pip install -r requirements.txt; fi

# 애플리케이션 소스 파일 복사
COPY . .

# Flask 애플리케이션 시작 명령어
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
