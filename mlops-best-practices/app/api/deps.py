import secrets
from typing import AsyncGenerator

from aioredis import create_redis_pool
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBasic, HTTPBasicCredentials

from app.config import settings
from app.feature_store.backends.redis import RedisBackend

security = HTTPBasic()


def get_current_username(credentials: HTTPBasicCredentials = Depends(security)) -> str:
    correct_username = secrets.compare_digest(
        credentials.username, settings.FIRST_SUPERUSER
    )
    correct_password = secrets.compare_digest(
        credentials.password, settings.FIRST_SUPERUSER_PASSWORD
    )
    if not (correct_username and correct_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Basic"},
        )
    return credentials.username


async def get_backend() -> AsyncGenerator:
    pool = await create_redis_pool((settings.REDIS_HOST, settings.REDIS_PASSWORD))
    yield RedisBackend(redis=pool)
    pool.close()
    await pool.wait_closed()
