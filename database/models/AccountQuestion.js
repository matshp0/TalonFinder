import _sequelize from 'sequelize';
const { Model } = _sequelize;

export default class AccountQuestion extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      questionId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        references: {
          model: 'Question',
          key: 'id'
        }
      },
      accountId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        references: {
          model: 'Account',
          key: 'id'
        }
      }
    }, {
      sequelize,
      tableName: 'AccountQuestion',
      schema: 'apiDB',
      timestamps: true,
      indexes: [
        {
          name: 'AccountQuestion_pkey',
          unique: true,
          fields: [
            { name: 'accountId' },
            { name: 'questionId' },
          ]
        },
      ]
    });
  }
}
