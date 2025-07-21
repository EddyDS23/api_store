from sqlalchemy import Column, Integer, SmallInteger, String, text, TIMESTAMP
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship

from database import Base

class Client(Base):
    __tablename__ = "tbClients"
    
    cli_id = Column(Integer, autoincrement=True, primary_key=True)
    cli_name = Column(String(100),nullable=False)
    cli_lastname_paternal = Column(String(100),nullable=False)
    cli_lastname_maternal = Column(String(100),nullable=False)
    cli_number = Column(String(20))
    cli_email = Column(String(100), nullable=False, unique=True)
    cli_address = Column(String(255),nullable=False)
    cli_create = Column(TIMESTAMP, server_default=func.now())
    cli_update = Column(TIMESTAMP, server_default=func.now(),onupdate=func.now())
    cli_status = Column(SmallInteger, server_default=text("1"))
    
    #Uno a muchos
    sales = relationship("Sale",back_populates="client")