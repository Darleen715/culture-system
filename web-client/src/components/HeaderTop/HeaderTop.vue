<template>
  <div class="header_nav">
    <div>
      <p>嗨~欢迎来到文创推广系统</p>
    </div>
    <ul>
      <li v-if="!userInfo.id">
        <router-link to="/login">登录</router-link><router-link to="/register">免费注册</router-link>
      </li>
      <li v-else>
        <a v-if="userInfo.user_nickname">您好,{{ userInfo.user_nickname }}</a>
        <a v-else>您好,{{ userInfo.user_name | nameFormat }}</a>
        <a @click="headerLogout">退出登录</a>
      </li>
      <li v-if="!isHome"><a @click="goHome">返回首页</a></li>
      <li><a @click="goArticle">文创社区</a></li>
      <li><a @click="goMe">个人中心</a></li>
      <li><a @click="goMap">我的地图</a></li>
      <li><a @click="goShopCar">我的收藏</a></li>
      <li><a @click="goAdmin">管理员通道</a></li>
    </ul>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import { mapActions } from 'vuex';
import { MessageBox } from 'element-ui';

export default {
  computed: {
    ...mapState(["userInfo"]),
    isHome() {
      return this.$route.path === '/home';
    }
  },
  methods: {
    ...mapActions(["logOut"]),

    async headerLogout() {
      try {
        await this.$confirm('您确定退出登录吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        });
        await this.logOut({});
        window.localStorage.removeItem("userInfo");
        this.$message({
          type: 'success',
          message: '退出成功!'
        });
        this.$router.replace('/home');
      } catch (error) {
        this.$message({
          type: 'info',
          message: '已取消退出'
        });
      }
    },
    goHome() {
      this.$router.replace('/home');
    },
    goMe() {
      this.navigateTo('/me');
    },
    goAdmin() {
      this.$router.replace('/admin');
    },
    goShopCar() {
      this.navigateTo('/shopcar');
    },
    goMap() {
      this.navigateTo('/china');
    },
    goArticle() {
      this.navigateTo('/articles');
    },
    navigateTo(route) {
      if (this.userInfo.id) {
        this.$router.replace(route);
      } else {
        MessageBox({
          type: 'info',
          message: "请先登录!",
          showClose: true,
        });
      }
    }
  }
}
</script>


<style scoped>
/*头部导航*/
.header_nav {
  width: 100%;
  height: 30px;
  background: #F2F2F2;
  font-family: "Microsoft YaHei";

  display: flex;
  align-items: center;
  justify-content: space-between;
}

.header_nav>div {
  display: flex;
  align-items: center;
}

.header_nav>div p {
  margin: 0 30px 0 20px;
  color: #999;
  font-size: 15px;
}

.locationWrapper {
  position: relative;
  max-width: 100px;

  display: flex;
  align-items: center;

}

.locationWrapper .el-cascader {
  position: absolute;
  opacity: 0;
}

.locationWrapper .address {
  max-width: 58px;
  font-size: 12px;
  color: #999;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  vertical-align: middle;
}

.locationWrapper .icon {
  margin: 0 3px;
  width: 15px;
  height: 15px;
  vertical-align: middle;
}

.locationWrapper .icon path {
  fill: #dd6161;
}

.header_nav>ul {
  margin: 0 50px;
  list-style: none;

  display: flex;
  align-items: center;
}

.header_nav>ul>li:first-child {
  font-size: 14px;
  color: rgb(164, 57, 57);
  line-height: 20px;
  cursor: pointer;
}

.header_nav>ul>li>a {
  display: inline-block;
  padding: 5px 15px;
  font-size: 12px;
  line-height: 20px;
  color: #999;
  text-decoration: none;
  cursor: pointer;
}

.header_nav>ul>li>a:hover {
  color: red;
}

.header_nav>ul>li:first-child>a:nth-child(2) {
  padding-left: 0;
  color: red;
}
</style>
