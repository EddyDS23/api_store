from sqlalchemy import Column, Integer,TIMESTAMP, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from database import Base

class Invoice(Base):
    __tablename__ = "tbInvoice"
    
    invo_id = Column(Integer, autoincrement=True, primary_key=True)
    invo_sale_id = Column(Integer, ForeignKey("tbSales.sale_id"),nullable=False)
    invo_create = Column(TIMESTAMP, server_default=func.now())
    
    sale = relationship("Sale",back_populates="invoice")
    
    
