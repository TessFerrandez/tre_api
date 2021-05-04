from fastapi import FastAPI
from .routers import ping


app = FastAPI()
app.include_router(ping.router)


@app.get("/")
async def home():
    return {"message": "Hello TRE API"}
