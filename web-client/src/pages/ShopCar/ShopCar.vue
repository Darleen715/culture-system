<template>
  <div id="shopcar">
    <div id="content">
      <div class="header">
        <span>收藏列表</span>
      </div>
      <div class="cont_title">
        <span>全部商品</span>
      </div>
      <div class="cont_op">
        <div class="con_selet">
          <input type="checkbox" class="con_selectAll" :checked="isSelectedAll"
            @click.stop="selectedAll(isSelectedAll)" />
          <label for="con_selectAll">全选</label>
        </div>
        <div>商品信息</div>
        <div>单价</div>
        <!-- <div>数量</div>
				<div>金额</div> -->
        <div>操作</div>
        <div>更多</div>
      </div>
      <div class="pro_box" v-if="cartgoods.length">
        <div class="goods" v-for="(goods, index) in cartgoods" :key="index">
          <ul class="item_content">
            <li class="td td-chk">
              <div>
                <input type="checkbox" class="checkBox" :checked="goods.checked" @click="singleSelected(goods)" />
              </div>
            </li>
            <li class="td td-item">
              <div class="td-item-pic">
                <img :src="goods.thumb_url" />
              </div>
              <div class="td-item-info">{{ goods.goods_name }}</div>
            </li>
            <li class="td td-price"><strong>{{ goods.price / 100 | moneyFormat }}</strong></li>
            <!-- <li class="td td-amount">
							<div class="item-amout">
                <el-input-number v-model="goods.buy_count" :min="1" :max="goods.counts" @change="updateGoodsCount(goods, goods.buy_count)"></el-input-number>
							</div> 
						</li>-->
            <li class="td td-check" @click="goDetail(goods.goods_id)"><strong>查看详细</strong></li>
            <li class="td td-op"><a @click="clickTrash(goods)">删除</a></li>
          </ul>
        </div>
      </div>
      <div class="pro_box" v-else>收藏列表里空空如也</div>
    </div>
    <div id="footer">
      <div class="foot_select">
        <input type="checkbox" class="foot_selectAll" name="foot_selectAll" :checked="isSelectedAll"
          @click.stop="selectedAll(isSelectedAll)" />
        <label for="foot_selectAll">全选</label>
      </div>
      <div class="foot_op">
        <a class="foot_remove" @click.prevent="emptyCart">清空收藏列表</a>
      </div>

    </div>

    <div class="recommend_list">
      <div class="pro_line">
        <img src="./img/public-icon3.png" alt="" style="height:40px;width: 30px;">
        <h3>为你推荐</h3>
        <img src="./img/public-icon4.png" alt="" style="height:40px;width: 30px;">
      </div>
      <!-- 在模板中，使用 v-for 指令遍历 recommendedProducts 数组，并为每个商品创建一个 ProductItem 组件 -->
      <div class="recommended-products">
        <ProductItem v-for="(pro, index) in recommendedProducts" :key="index" :pro="pro" />
      </div>

    </div>

  </div>
</template>

<script>
import { mapState } from 'vuex';
import { mapActions } from 'vuex'
import { MessageBox } from 'element-ui';
import ProductItem from '../../components/ProductItem/ProductItem.vue'
import { getGoodsSaleTip, getSimilarProductsBySaleTip, getAllgoods } from '../../api/index'
// import ProductItem from '../../components/ProductItem/ProductItem'

export default {
  data() {
    return {
      shopsNum: [],
      isSelectedAll: false,
      // totalPrice: 0,  // 商品总价
      currentDelGoods: {}, // 当前删除的商品
      totalAmount: 0,//以选商品
      recommendedProducts: [],// 推荐商品
    }
  },
  computed: {
    ...mapState(['userInfo', 'cartgoods']),

  },
  components: {
    ProductItem
  },
  mounted() {
    let user_id = this.userInfo.id;
    // 请求商品数据
    this.$store.dispatch('reqCartsGoods', { user_id });
    this.getRecommendedProducts();
  },
  methods: {
    // 1.更新单个商品数量
    updateGoodsCount(goods, count) {
      let user_id = this.userInfo.id;
      this.$store.dispatch('updateGoodsCount', { goods, count, user_id });
      this.getAllGoodsPrice();
    },
    // 2.是否选中所有商品
    selectedAll(isSelectedAll) {
      this.isSelectedAll = !isSelectedAll;
      this.$store.dispatch('selectedAll', { isSelectedAll });
      this.getAllGoodsPrice();
    },
    // 3.计算商品总价
    getAllGoodsPrice() {
      let totalPrice = 0;
      this.cartgoods.forEach((goods, index) => {
        if (goods.checked) {
          totalPrice += goods.price / 100 * goods.buy_count;
        }
      });
      this.totalPrice = totalPrice;
    },
    // 4.单个商品的选中与否
    singleSelected(goods) {
      this.$store.dispatch('singleSelected', { goods });
      this.hasSelectedAll();
      this.getAllGoodsPrice();
    },
    // 5.判断是否全选
    hasSelectedAll() {
      let flag = true;
      let totalNum = 0
      this.cartgoods.forEach((goods, index) => {
        if (!goods.checked) {
          flag = false;
        } else {
          totalNum += 1;
        }
      });
      this.totalAmount = totalNum;
      this.isSelectedAll = flag;
    },
    // 6.删除单个商品
    clickTrash(goods) {
      this.$confirm('您确定删除该商品吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        let user_id = this.userInfo.id;
        this.currentDelGoods = goods;
        this.$store.dispatch('delSingleGoods', { goods, user_id });
        this.getAllGoodsPrice();
        location.reload(); // 重新加载当前页面
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    // 7.删除所有商品
    emptyCart() {
      this.$confirm('您确定删除所有商品吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        let user_id = this.userInfo.id;
        this.$store.dispatch('delAllGoods', { user_id });
        this.getAllGoodsPrice();
        location.reload(); // 重新加载当前页面
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    //8.结算
    moneyCount(goods) {
      this.$confirm('您确定购买该商品吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$message({
          type: 'info',
          message: '购买成功！'
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消购买'
        });
      });
    },
    // 跳转到商品详细页
    goDetail(id) {
      this.$router.replace('/goods/' + id);
    },
    // 获取用户推荐列表
    async getRecommendedProducts() {
      try {
        this.recommendedProducts = []; // 初始化为一个空数组
        if (this.cartgoods.length > 0) {
          // 遍历用户的收藏列表
          for (const goods of this.cartgoods) {
            const goodsId = goods.goods_id;

            // 使用 goods_id 值查询 recommend 表中的 sale_tip 字段的值
            const saleTipResponse = await getGoodsSaleTip(goodsId);
            const saleTip = saleTipResponse.sales_tip;

            // 根据 sale_tip 值查询 recommend 表中具有相同 sale_tip 值的其他商品
            const recommendedResponse = await getSimilarProductsBySaleTip(saleTip);
            const recommendedProducts = recommendedResponse;
            const randomList = this.getRandomNumbers(recommendedProducts.length, 3)
            for (let i = 0; i < 3; i++) {
              this.recommendedProducts.push(recommendedProducts[randomList[i]]);
            }
          }
        } else {
          const response = await getAllgoods();
          if (response.success_code == 200) {
            let getAllgoods = response.message;
            console.log(getAllgoods);
            let recommendIndex = this.getRandomNumbers(getAllgoods.length, 9)
            console.log(recommendIndex);
            for (let i = 0; i < 9; i++) {
              console.log(getAllgoods[recommendIndex[i]]);
              this.recommendedProducts.push(getAllgoods[recommendIndex[i]]);
            }
          }
        }
      } catch (error) {
        console.error('Error fetching recommended products:', error);
      }
    },
    // 从0-n里随机选择m个数的最优算法
    getRandomNumbers(n, m) {
      const result = [];
      for (let i = 0; i < m; i++) {
        let randomNum;
        do {
          randomNum = Math.floor(Math.random() * n);
        } while (result.includes(randomNum));
        result.push(randomNum);
      }
      return result;
    }




  },
}
</script>

<style scoped>
#content>.header {
  width: 100%;
  padding-left: 130px;
  height: 90px;
  margin-top: 10px;
  position: relative;
}

.header>img {
  width: 80px;
  height: 80px;
  cursor: pointer;
}

.header>span {
  display: inline-block;
  font-size: 25px;
  height: 35px;
  font-weight: 700;
  position: absolute;
  top: 30%;
  margin-left: 20px;
  cursor: pointer;
  color: #f22d00;
}

#content>.cont_title {
  margin: 10px auto;
  width: 80%;
  height: 35px;
  border-bottom: 2px solid #e6e6e6;
}

.cont_title>span {
  display: inline-block;
  font-weight: 700;
  font-size: 17px;
  height: 100%;
  width: 100px;
  text-align: center;
  line-height: 25px;
  cursor: pointer;
  color: #f40;
  border-bottom: 2px solid #f40;
}

#content>.cont_op {
  width: 80%;
  margin: 0 auto;
  height: 40px;
  display: flex;
  justify-content: space-around;
}

.cont_op>div {
  line-height: 40px;
}

.cont_op>div:nth-child(2) {
  width: 120px;
}

#content>.pro_box {
  margin: 0 auto;
  width: 80%;
}

.pro_box>.goods {
  background: #fcfcfc;
  width: 100%;
  height: 130px;
  border: 1px solid #CCCCCC;
}

.goods>.item_content {
  padding: 15px;
  list-style: none;

  display: flex;
  justify-content: space-around;
}

.item_content>.td-item {
  width: 180px;
  position: relative;
}

.td-item>div {
  display: inline-block;
}

.td-item>.td-item-pic>img {
  width: 80px;
  height: 80px;
}

.td-item>.td-item-info {
  position: absolute;
  width: 80px;
  line-height: 15px;
  font-size: 12px;
  top: 0;
  margin-left: 20px;
}

.item_content>.td-check {
  color: #f40;
  cursor: pointer;
}

.td-amount>.item-amout {
  height: 25px;
}

.item-amout a {
  display: inline-block;
  height: 23px;
  width: 17px;
  border: 1px solid #e5e5e5;
  background: #f0f0f0;
  text-align: center;
  line-height: 23px;
  color: #444;
  cursor: pointer;
}

.item-amout a:hover {
  color: #f50;
  border-color: #f60;
}

.item-amout>.text_amount {
  width: 40px;
  height: 20px;
  text-align: center;
  display: inline-block;
}

.td-op a {
  color: black;
}

.td-op a:hover {
  cursor: pointer;
  color: #f40;
}

#footer {
  width: 80%;
  height: 50px;
  margin: 0 auto;
  background: #E5E5E5;
  z-index: 9999;
}

#footer div {
  display: inline-block;
}

#footer>.foot_select {
  width: 50px;
  height: 50px;
  line-height: 50px;
  padding-left: 5px;
  cursor: pointer;
  font-size: 14px;
}

.foot_select input,
.foot_select label {
  cursor: pointer;
}

.foot_op {
  line-height: 50px;
  height: 50px;
}

.foot_op>.foot_remove {
  margin-left: 25px;
  font-size: 14px;
  cursor: pointer;
}

.foot_remove:hover {
  color: #f40;
}

.foot_total {
  float: right;
}

.foot_total>.amout-sum {
  cursor: pointer;
  height: 50px;
  color: #3c3c3c;
}

.foot_total .txt {
  line-height: 50px;
  font-size: 14px;
}

.amout-sum>#selected_amout {
  padding: 0 5px;
  color: #f40;
  font-weight: 700;
  font-size: 18px;
}

.price-sum {
  margin-left: 50px;
}

.price-sum>.selected_price {
  color: #f40;
  font-weight: 700;
  font-size: 20px;
  line-height: 50px;
}

.btn-area>.btn-sumbit {
  display: inline-block;
  background: #B0B0B0;
  color: #fff;
  border-left: 1px solid #e7e7e7;
  width: 119px;
  height: 50px;
  cursor: not-allowed;
  text-align: center;
  line-height: 50px;
  font-size: 20px;
}

.btn-area>.btn-sumbit.btn-allow {
  background: #f22d00;
  cursor: pointer;
}

.recommend_list {
  margin: 50px auto;
  width: 100%;
  height: auto;
  padding-bottom: 50px;
}

.pro_line {
  width: 100%;
  height: 50px;
  text-align: center;
  line-height: 50px;
  font-size: 26px;
  font-family: sans-serif;
  font-weight: normal;
  color: #222;
  margin-bottom: 20px;
}

.pro_line>h3 {
  display: inline-block;
  height: 40px;
  line-height: 40px;
}

.pro_line>div {
  display: inline-block;
  margin-left: 15px;
  cursor: pointer;
}


.recommended-products {
  margin: 0 auto;
  padding-left: 20px;
  width: 980px;
  min-height: 480px;
}
</style>
