const { Sequelize, DataTypes } = require('sequelize')
const sequelize = new Sequelize('test_db', 'root', 'password', {
  host: 'localhost',
  dialect: 'mysql'
})

const User = require('./user');
const Post = require('./post');

async function createUserAndPosts() {
    const transaction = await sequelize.transaction()
  
    try {
      const user = await User.create({ name: 'Jane Doe', email: 'Jane.doe@example.com' }, { transaction })
      await Post.create({ title: 'First Post', content: 'This is my first post!', userId: user.id }, { transaction })
  
      await transaction.commit()
      console.log('Transaction committed successfully.')
    } catch (error) {
      await transaction.rollback()
      console.error('Transaction rolled back due to an error:', error)
    } finally {
      await sequelize.close()
    }
  }
  
  createUserAndPosts()
