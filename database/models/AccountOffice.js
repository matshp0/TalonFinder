import _sequelize from 'sequelize';
const { Model } = _sequelize;

export default class AccountOffice extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      accountId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        references: {
          model: 'Account',
          key: 'id'
        }
      },
      officeId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        references: {
          model: 'Office',
          key: 'id'
        }
      }
    }, {
      sequelize,
      tableName: 'AccountOffice',
      schema: 'apiDB',
      timestamps: true,
      indexes: [
        {
          name: 'AccountOffice_pkey',
          unique: true,
          fields: [
            { name: 'accountId' },
            { name: 'officeId' },
          ]
        },
      ]
    });
  }
}
