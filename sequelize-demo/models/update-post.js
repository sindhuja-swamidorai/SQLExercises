const { Sequelize, DataTypes } = require('sequelize')
const sequelize = new Sequelize('test_db', 'root', 'password', {
  host: 'localhost',
  dialect: 'mysql'
})

const Post = require('./post');

Post.addHook('beforeUpdate', (post, options) => {
  console.log('Before updating a post:', post)
});

async function updatePost() {
  await sequelize.sync();

  const post = await Post.findOne({
    where: {
      id: 4
    }
  });

  if (post) {
    post.title = 'Newly Updated TEST';
    await post.save();
    console.log('Post updated: ', post.toJSON());
  }

  await sequelize.close();
}

updatePost();