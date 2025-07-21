from sqlalchemy import Column, Integer,SmallInteger, String, text, TIMESTAMP, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from database import Base

class Alert(Base):
    __tablename__ = "tbAlerts"
    
    alert_id = Column(Integer,autoincrement=True,primary_key=True)
    alert_prod_id = Column(Integer, ForeignKey("tbProduct.prod_id"),nullable=False)
    alert_message = Column(String(200),nullable=False)
    alert_seen = Column(SmallInteger, server_default=text("0"))
    alert_create = Column(TIMESTAMP,server_default=func.now())
    
    product = relationship("Product",back_populates="alert")