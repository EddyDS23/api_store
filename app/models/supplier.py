from sqlalchemy import Column, Integer, SmallInteger, String, text, TIMESTAMP
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from database import Base

class Supplier(Base):
    __tablename__ = "tbSuppliers"
    
    sup_id = Column(Integer, autoincrement=True, primary_key=True)
    sup_name = Column(String(100), nullable=False)
    sup_number = Column(String(20), nullable=False)
    sup_email = Column(String(100), nullable=False, unique=True)
    sup_contact = Column(String(100), nullable=False)
    sup_address = Column(String(255),nullable=True)
    sup_create = Column(TIMESTAMP, server_default=func.now())
    sup_update = Column(TIMESTAMP, server_default=func.now(), onupdate=func.now())
    sup_status = Column(SmallInteger, server_default=text("1"))
    
    shopping = relationship("Shopping",back_populates="supplier")