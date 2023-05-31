from importlib.metadata import version, PackageNotFoundError
from fastapi import APIRouter

router = APIRouter()

@router.get("/")
async def get_version():
    try:
        return {"version": version("test-observer")}
    except PackageNotFoundError:
        return {"version": "0.0.0"}