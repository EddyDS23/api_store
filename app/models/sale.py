from sqlalchemy import Column, Integer, Numeric, TIMESTAMP, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from database import Base

class Sale(Base):
    __tablename__ = "tbSales"
    
    sale_id = Column(Integer, autoincrement=True, primary_key=True)
    sale_amount_total = Column(Numeric(12,2),nullable=False)
    sale_cli_id = Column(Integer, ForeignKey("tbClients.cli_id"),nullable=False)
    sale_create = Column(TIMESTAMP, server_default=func.now())
    
    client = relationship("Client", back_populates="sale")
    invoice = relationship("Invoice", back_populates="sale")
    
    saledetail = relationship("DetailSale",back_populates="sale")
    