import _sequelize from 'sequelize';
const { Model } = _sequelize;

export default class Cookie extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      id: {
        autoIncrement: true,
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true
      },
      value: {
        type: DataTypes.TEXT,
        allowNull: true
      }
    }, {
      sequelize,
      tableName: 'Cookie',
      schema: 'apiDB',
      timestamps: false,
      indexes: [
        {
          name: 'Cookie_pkey',
          unique: true,
          fields: [
            { name: 'id' },
          ]
        },
      ]
    });
  }
}
