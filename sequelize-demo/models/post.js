const { Sequelize, DataTypes } = require('sequelize')
const sequelize = new Sequelize('test_db', 'root', 'password', {
  host: 'localhost',
  dialect: 'mysql'
})

const Post = sequelize.define ('Post', 
  {
  title: {
    type: DataTypes.STRING,
    allowNull: false
  },
  content: {
    type: DataTypes.TEXT,
    allowNull: false
  }
  },
  {
    hooks: {
        beforeCreate: (post, options) => {
          console.log('Before creating a post:', post)
        },
        afterCreate: (post, options) => {
          console.log('After creating a post:', post)
        }
      }
  }
)

// Define associations
const User = require('./user')
User.hasMany(Post)
Post.belongsTo(User)

// Sync the models with the database
async function syncModels() {
  await sequelize.sync()
  console.log('Models were synchronized successfully.')
}

syncModels()

module.exports = Post;