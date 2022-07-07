from fastapi import APIRouter
from pydantic import HttpUrl
from starlette.requests import Request

from app.core import TwitterSentiment
from app.decorator import async_log_response
from app.schemas import SentimentResponse

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
