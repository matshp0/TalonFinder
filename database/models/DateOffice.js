import _sequelize from 'sequelize';
const { Model } = _sequelize;

export default class DateOffice extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      officeId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        references: {
          model: 'Office',
          key: 'id'
        }
      },
      date: {
        type: DataTypes.DATEONLY,
        allowNull: false,
        primaryKey: true
      },
      questionId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        references: {
          model: 'Question',
          key: 'id'
        }
      },
      status: {
        type: DataTypes.SMALLINT,
        allowNull: true
      }
    }, {
      sequelize,
      tableName: 'DateOffice',
      schema: 'apiDB',
      timestamps: true,
      indexes: [
        {
          name: 'DateOffice_pkey',
          unique: true,
          fields: [
            { name: 'officeId' },
            { name: 'date' },
            { name: 'questionId' },
          ]
        },
      ]
    });
  }
}
