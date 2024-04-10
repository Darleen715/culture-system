<template>
  <div>
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
      <router-link class="navbar-brand col-sm-3 col-md-2 mr-0" to="/home">文创推广系统</router-link>
      <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
          <el-button type="primary" @click="goToAddArticle">发布新文章</el-button>
          <a class="nav-link" @click.prevent="goBack">返回商城</a>
        </li>
      </ul>
    </nav>
    <div>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
// 引入您的API
import { getArticles } from './../../api/index'
import {mapState} from 'vuex'


export default {
  data() {
    return {
      articles: []  // 初始化空数组来存储文章信息
    }
  },
  computed: {
      ...mapState(['userInfo'])
    },
  mounted() {
    this.getAllArticles();  // 在组件挂载后立即调用获取文章信息的方法
  },
  methods: {
    getAllArticles() {
      // 使用您的API方法获取文章信息
      getArticles()
        .then(response => {
          // 成功获取文章信息后将其存储到组件的articles数组中
          this.articles = response.message.map(article => {
            article.likes = 0; // 添加likes字段并初始化为0
            article.liked = false; // 添加liked字段并初始化为false
            return article;
          });
        })
        .catch(error => {
          console.error('获取文章信息时出错：', error);
        });
    },
    toggleLike(index) {
      // 切换点赞状态
      this.articles[index].liked = !this.articles[index].liked;
      // 更新点赞数
      if (this.articles[index].liked) {
        this.articles[index].likes++;
      } else {
        this.articles[index].likes--;
      }
    },
    formatDate(date) {
      const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
      const formattedDate = new Date(date).toLocaleDateString('en-US', options);
      // 将日期字符串拆分为年、月、日
      const [month, day, year] = formattedDate.split('/');
      // 重新拼接日期字符串，年在最前面，用短横线连接
      return `${year}-${month}-${day}`;
    },
    goToAddArticle() {
      this.$router.push('/articles/addarticle');
    },
    goBack() {
      this.$router.replace('/home');
    },
  }
}
</script>

<style scoped>
.article-list {
  display: flex;
  align-items: center;
}

.article-item {
  margin-bottom: 20px;
  width: 30%;
  height: 400px;
  margin: 10%;
  max-width: 600px;
}

.article-header h2 {
  font-size: 24px;
  margin-bottom: 5px;
  color: rgb(247, 137, 137);
}

.author,
.publish-date,
.category {
  font-size: 14px;
  margin-bottom: 5px;
  color: #666;
}

.article-content p {
  font-size: 16px;
  margin-bottom: 10px;
}

.like-button {
  display: flex;
  align-items: center;
  color: rgb(247, 137, 137);
}

.like-button .el-icon-star-off,
.like-button .el-icon-star-on {
  font-size: 18px;
  margin-right: 5px;
}

.like-button .liked {
  color: #ff578a;
}

.nav-item {
  display: flex;
}

.nav-link {
  margin: 0 20px;
}
</style>
