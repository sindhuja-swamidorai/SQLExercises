const { Sequelize, DataTypes } = require('sequelize')
const sequelize = new Sequelize('test_db', 'root', 'password', {
  host: 'localhost',
  dialect: 'mysql'
})

const Post = require('./post');

async function complexQuery() {
  await sequelize.sync()

  const posts = await Post.findAll({
    where: {
      title: {
        [Sequelize.Op.like]: '%Post%'
      }
    },
    order: [
      ['title', 'ASC']
    ],
    limit: 2,
    offset: 1
  })
  console.log('Complex query result:', JSON.stringify(posts, null, 2))

  await sequelize.close()
}

complexQuery()
