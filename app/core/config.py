from pydantic_settings import BaseSettings
from pydantic import ConfigDict


class Settings(BaseSettings):
    SECRET_KEY:str
    ALGORITHM:str
    ACCESS_TOKEN_MINUTES:int = 20
    URL_DB:str
    
    model_config = ConfigDict(env_file=".env")
    
settings = Settings()
    