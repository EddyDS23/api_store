from sqlalchemy import Column, Integer, SmallInteger, String, text, TIMESTAMP,Numeric, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from database import Base

class Product(Base):
    __tablename__ = "tbProducts"
    
    prod_id = Column(Integer, autoincrement=True, primary_key=True)
    prod_name = Column(String(100), nullable=False, unique=True)
    prod_description = Column(String(200),nullable=True)
    prod_price = Column(Numeric(10,2),nullable=False)
    prod_stock = Column(Integer,nullable=False)
    prod_produni_id = Column(Integer,ForeignKey("tbProductUnits.produni_id"),nullable=False)
    prod_cat_id = Column(Integer,ForeignKey("tbCategories.cat_id"),nullable=False)
    prod_create = Column(TIMESTAMP, server_default=func.now())
    prod_update = Column(TIMESTAMP, server_default=func.now(),onupdate=func.now())
    prod_status = Column(SmallInteger, server_default=text("1"))
    
    saledetail = relationship("DetailSale",back_populates="product")
    shopdetail = relationship("DetailShopping",back_populates="product")
    inventory = relationship("Inventory",back_populates="product")
    
    
    alert = relationship("Alert",back_populates="product")
    categorie = relationship("Categorie",back_populates="product")
    produni = relationship("ProductUnit", back_populates="product")
    