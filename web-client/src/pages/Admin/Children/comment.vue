<template>
<!--面包屑导航栏--> <span v-if="cartgoods.length" class="one">
      <el-breadcrumb separator-class="el-icon-arrow-right" style="margin-top:20px; margin-bottom:10px">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
      <el-breadcrumb-item>订单管理</el-breadcrumb-item>
      </el-breadcrumb>
 <el-card class="box-card" style="box-shadow:0 1px 1px rgba( 0,0,0,0.15) !important">
  <table>
    <tr class="title">
      <th>商品名称</th>
      <th>商品图片</th>
      <th>商品价格</th>
      <th>购买数量</th>
      <th>付款状态</th>
      <th>操作</th>
    </tr>
    <tr v-for="(goods, index) in cartgoods" :key="index">
      <th>{{ goods.goods_name }}</th>
      <th class="imgs"> <img :src="goods.thumb_url"/></th>
      <th>{{ goods.price/100 }}</th>
      <th>{{ goods.buy_count }}</th>
      <th v-if="goods.is_pay==1">
        未付款
      </th>
      <th v-else>已付款</th>
      <th @click="clickTrash(goods)" style=""><button style="background-color:red;color:white;width:50px;height:30px;border-radius:5px;border:none;">删除</button></th>
    </tr>
  </table>
 </el-card>
  </span>
  <div v-else>您还没有订单，快去商城选购吧！</div>
  
</template>

<script>
  import {mapState} from 'vuex';
  import {mapActions} from 'vuex'
  // import {getCartsGoods} from './../../../api/index';

  export default {
    data() {
      return {
        
      }
    },
    computed: {
      ...mapState(['userInfo', 'cartgoods']),
    },
    mounted() {
      let user_id = this.userInfo.id;
      // 请求商品数据
      this.$store.dispatch('reqCartsGoods',{user_id});
      
    },
    methods: {
      // 6.删除单个商品
      clickTrash(goods){
        this.$confirm('您确定删除该商品吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          let user_id = this.userInfo.id;
          this.currentDelGoods = goods;
          this.$store.dispatch('delSingleGoods', {goods, user_id});
          this.getAllGoodsPrice();
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });
        });
      },
    }

  }
</script>

<style scoped>
.one table{
  width: 100%;
  border-top: 1px solid rgb(218, 217, 217);
  margin: 20px auto;
}
.one th{
  margin: 0 auto;
  padding: 10px;
  border-bottom: 1px solid rgb(218, 217, 217);
}
.title{
  font-size: 16px;
}
.imgs img{
  width: 40px;
  height: 50px;
}
</style>
