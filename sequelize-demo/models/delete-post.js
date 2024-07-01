const { Sequelize, DataTypes } = require('sequelize')
const sequelize = new Sequelize('test_db', 'root', 'password', {
  host: 'localhost',
  dialect: 'mysql'
})

const Post = require('./post');

async function deletePost(){
  await sequelize.sync();

  const post = await Post.findOne({
    where: {
      id: 3
    }
  })

  if (post) {
    await post.destroy();
    console.log('Post deleted');
  }

  await sequelize.close();
}

deletePost();
