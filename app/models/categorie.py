from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship

from database import Base

class Categorie(Base):
    __tablename__ = "tbCategories"
    
    cat_id = Column(Integer, autoincrement=True, primary_key=True)
    cat_name = Column(String(150),nullable=False)
    
    product = relationship("Product",back_populates="categorie")
    
    