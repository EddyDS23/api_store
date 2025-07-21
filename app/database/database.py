from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker, declarative_base

from core import settings

Base = declarative_base()

engine = create_engine(settings.URL_DB)

SessionLocal = sessionmaker(bind=engine,autocommit=False,autoflush=False)

def get_db():
    db:Session = SessionLocal()
    try:
        yield db
    finally:
        db.close()
        