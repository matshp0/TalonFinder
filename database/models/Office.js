import _sequelize from 'sequelize';
const { Model } = _sequelize;

export default class Office extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true
      },
      address: {
        type: DataTypes.STRING(255),
        allowNull: true
      }
    }, {
      sequelize,
      tableName: 'Office',
      schema: 'apiDB',
      timestamps: true,
      indexes: [
        {
          name: 'Office_pkey',
          unique: true,
          fields: [
            { name: 'id' },
          ]
        },
      ]
    });
  }
}
