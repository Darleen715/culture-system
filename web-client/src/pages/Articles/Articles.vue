<template>
  <div>
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
      <router-link class="navbar-brand col-sm-3 col-md-2 mr-0" to="/home">文创推广系统</router-link>
      <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
          <el-button type="primary" @click="goToAddArticle">发布新文章</el-button>
          <a class="nav-link" @click.prevent="goBackCom">返回社区</a>
          <a class="nav-link" @click.prevent="goBackHome">返回商城</a>
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
import { mapState } from 'vuex'


export default {
  data() {
    return {
      articles: []  // 初始化空数组来存储文章信息
    }
  },
  computed: {
    ...mapState(['userInfo'])
  },
  methods: {
    goToAddArticle() {
      this.$router.push('/articles/addarticle');
    },
    goBackHome() {
      this.$router.replace('/home');
    },
    goBackCom() {
      this.$router.replace('/articles');
    }
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
  cursor: pointer;
}
</style>
