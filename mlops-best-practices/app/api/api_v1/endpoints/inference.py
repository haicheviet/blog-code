from starlette.requests import Request
from pydantic import HttpUrl
from fastapi import APIRouter, HTTPException

from app.schemas import SentimentResponse
from app.decorator import async_log_response
from app.core import TwitterSentiment

router = APIRouter()


@router.get("/inference", response_model=SentimentResponse)
@async_log_response
async def inference(
    request: Request,
    twitter_link: HttpUrl,
):

    twitter = TwitterSentiment(**request.app.model_params)

    prediction = twitter.prediction("hello world")

    return SentimentResponse(sentiment_analyst=prediction)
