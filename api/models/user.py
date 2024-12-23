from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from utils.database import Base

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    nom = Column(String, nullable=False)
    prenom = Column(String, nullable=False)
    email = Column(String, unique=True, nullable=False)
    telephone = Column(String, nullable=True)
    mot_de_passe = Column(String, nullable=False)
    localisation = Column(String, nullable=True)

    # Relations
    owned_plants = relationship("Plant", back_populates="owner", cascade="all, delete-orphan")  # Propriétaire
    caretaker_gardes = relationship("Garde", back_populates="caretaker")  # Gardien
    created_advices = relationship("Advice", back_populates="botanist")  # Botaniste
