"""Initial database setup

Revision ID: 703e2fef4f9d
Revises: 
Create Date: 2024-12-04 09:15:06.146693

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '703e2fef4f9d'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('users',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('nom', sa.String(), nullable=False),
    sa.Column('prenom', sa.String(), nullable=False),
    sa.Column('email', sa.String(), nullable=False),
    sa.Column('telephone', sa.String(), nullable=True),
    sa.Column('role', sa.String(), nullable=False),
    sa.Column('mot_de_passe', sa.String(), nullable=False),
    sa.Column('localisation', sa.String(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('email')
    )
    op.create_index(op.f('ix_users_id'), 'users', ['id'], unique=False)
    op.create_table('plants',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('nom', sa.String(), nullable=False),
    sa.Column('espece', sa.String(), nullable=True),
    sa.Column('description', sa.String(), nullable=True),
    sa.Column('photo', sa.String(), nullable=True),
    sa.Column('owner_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['owner_id'], ['users.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_plants_id'), 'plants', ['id'], unique=False)
    op.create_table('advices',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('texte', sa.String(), nullable=False),
    sa.Column('date', sa.String(), nullable=False),
    sa.Column('botanist_id', sa.Integer(), nullable=True),
    sa.Column('plant_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['botanist_id'], ['users.id'], ),
    sa.ForeignKeyConstraint(['plant_id'], ['plants.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_advices_id'), 'advices', ['id'], unique=False)
    op.create_table('gardes',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('date_debut', sa.Date(), nullable=False),
    sa.Column('date_fin', sa.Date(), nullable=True),
    sa.Column('photo', sa.String(), nullable=True),
    sa.Column('statut', sa.String(), nullable=False),
    sa.Column('gardien_id', sa.Integer(), nullable=True),
    sa.Column('plant_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['gardien_id'], ['users.id'], ),
    sa.ForeignKeyConstraint(['plant_id'], ['plants.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_gardes_id'), 'gardes', ['id'], unique=False)
    op.create_table('photo_histories',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('date', sa.Date(), nullable=False),
    sa.Column('photo', sa.String(), nullable=False),
    sa.Column('description', sa.String(), nullable=True),
    sa.Column('plant_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['plant_id'], ['plants.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_photo_histories_id'), 'photo_histories', ['id'], unique=False)
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_photo_histories_id'), table_name='photo_histories')
    op.drop_table('photo_histories')
    op.drop_index(op.f('ix_gardes_id'), table_name='gardes')
    op.drop_table('gardes')
    op.drop_index(op.f('ix_advices_id'), table_name='advices')
    op.drop_table('advices')
    op.drop_index(op.f('ix_plants_id'), table_name='plants')
    op.drop_table('plants')
    op.drop_index(op.f('ix_users_id'), table_name='users')
    op.drop_table('users')
    # ### end Alembic commands ###