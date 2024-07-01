const { Sequelize, DataTypes } = require('sequelize');
const sequelize = new Sequelize('test_db', 'root', 'password', {
  host: 'localhost',
  dialect: 'mysql'
});

const Post = require('./post.js');

async function createPost() {

  await sequelize.sync();
  const post = await Post.create({title: 'TEST Post', content: 'TEST Again POST Content'});
  console.log('Post created: ', post.toJSON());

  await sequelize.close();

}

createPost();
