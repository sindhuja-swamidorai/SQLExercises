const { Sequelize, DataTypes } = require('sequelize')
const sequelize = new Sequelize('test_db', 'root', 'password', {
  host: 'localhost',
  dialect: 'mysql'
})

const Post = require('./post');

async function readPosts() {
  await sequelize.sync();

  const posts = await Post.findAll();
  console.log('All posts: ', JSON.stringify(posts, null, 2));

  await sequelize.close();

}

readPosts();
