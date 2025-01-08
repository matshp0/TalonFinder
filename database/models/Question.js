import _sequelize from 'sequelize';
const { Model } = _sequelize;

export default class Question extends Model {
  static init(sequelize, DataTypes) {
    return super.init({
      id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true
      },
      category: {
        type: DataTypes.STRING(255),
        allowNull: true
      }
    }, {
      sequelize,
      tableName: 'Question',
      schema: 'apiDB',
      timestamps: true,
      indexes: [
        {
          name: 'Question_pkey',
          unique: true,
          fields: [
            { name: 'id' },
          ]
        },
      ]
    });
  }
}
