from sqlalchemy.sql import func,expression
from sqlalchemy import Column,Integer, String,TIMESTAMP, SmallInteger, text
from sqlalchemy.orm import relationship

from database import Base

class User(Base):
    __tablename__="tbUsers"
    
    user_id = Column(Integer, autoincrement=True, primary_key=True)
    user_name = Column(String(100),nullable=False)
    user_lastname_paternal = Column(String(100), nullable=False)
    user_lastname_maternal = Column(String(100), nullable=False)
    user_number = Column(String(20),nullable=False)
    user_email = Column(String(100),nullable=False,unique=True)
    user_password = Column(String(255),nullable=False)
    user_address = Column(String(255),nullable=True)
    user_create = Column(TIMESTAMP, server_default=func.now())
    user_update = Column(TIMESTAMP,server_default=func.now(),onupdate=func.now())
    user_status = Column(SmallInteger, server_default=text("1"))
    