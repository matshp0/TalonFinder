import _sequelize from 'sequelize';
const { Model } = _sequelize;

export default class Account extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true
      },
      role: {
        type: DataTypes.ENUM('admin', 'user'),
        allowNull: false,
        defaultValue: 'user'
      }
    }, {
      sequelize,
      tableName: 'Account',
      schema: 'apiDB',
      timestamps: true,
      indexes: [
        {
          name: 'Account_pkey',
          unique: true,
          fields: [
            { name: 'id' },
          ]
        },
      ]
    });
  }
}
