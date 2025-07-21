from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship

from database import Base

class ProductUnit(Base):
    __tablename__ = "tbProductUnits"
    
    produni_id = Column(Integer,autoincrement=True,primary_key=True)
    produni_name = Column(String(20),nullable=False)
    
    product = relationship("Product",back_populates="produni")