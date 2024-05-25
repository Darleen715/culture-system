<template>
	<div id="home">
		<button id="scrollToTopBtn" title="Go to top" @click.stop="scrollToTop">↑</button>
		<div id="container">
			<el-row>
				<!-- 一级菜单 -->
				<el-col :span="4" :offset="1" class="cateList">
					<div class="cate_img">
						<i class="el-icon-office-building"></i>
						商品分类
					</div>
					<el-menu class="el-menu-vertical-demo" background-color="#545c64" text-color="#fff">
						<el-menu-item index="cate.cate_id" v-for="(cate) in categoryList" :key="cate.cate_id"
							@click="getRList(cate.cate_id)">
							<i :class="cate.cate_icon"></i>
							<span slot="title">{{ cate.cate_name }}</span>
						</el-menu-item>
					</el-menu>
				</el-col>
				<!--轮播图-->
				<el-col :span="14" class="aa" style="height: 100%;">
					<el-carousel v-if="homecasual.length > 0">
						<el-carousel-item v-for="(casual) in homecasual" :key="casual.id">
							<img :src="casual.imgurl" alt="">
						</el-carousel-item>
					</el-carousel>
				</el-col>
			</el-row>

			<!-- 分类产品展示区域 -->
			<div class="product" v-for="(cate) in categoryList" :key="cate.cate_id">
				<div class="pro_line">
					<img src="./img/public-icon3.png" alt="" style="height:40px;width: 30px;">
					<h3>{{ cate.cate_name }}</h3>
					<img src="./img/public-icon4.png" alt="" style="height:40px;width: 30px;">
					<div><a @click.prevent="getRList(cate.cate_id)">MORE</a></div>
				</div>
				<div class="pro_show">
					<ProductItem v-for="(pro) in homeshoplist[cate.cate_id - 1]" :key="pro.goods_id" :pro="pro" />
				</div>
			</div>
		</div>
		<div class="end_show"></div>
	</div>
</template>

<script>
import { mapState } from 'vuex'
import DrawerSection from './children/DrawerSection/DrawerSection'
import ProductItem from '../../components/ProductItem/ProductItem'
import { MessageBox } from 'element-ui'

export default {
	computed: {
		...mapState(['homecasual', 'categoryList', 'homeshoplist', 'userInfo'])
	},
	components: {
		DrawerSection,
		ProductItem
	},
	methods: {
		getRList(cate_id) {
			this.$router.replace('/search/' + cate_id + '/1');
		},
		goShopCar() {
			if (this.userInfo.id) {
				this.$router.replace('/shopcar');
			} else {
				MessageBox({
					type: 'info',
					message: "请先登录!",
					showClose: true,
				});
			}
		},
		scrollToTop() {
			// 做缓动动画返回顶部
			let docB = document.documentElement || document.body;
			animate(docB, { scrollTop: '0' }, 400, 'ease-out');
		},
	},
	mounted() {
		// 请求轮播图数据
		this.$store.dispatch('reqHomeCasual');
		// 请求分类数据
		this.$store.dispatch('reqCategory');
		// 请求商品数据
		if (this.userInfo && this.userInfo.id) {
			let user_id = this.userInfo.id;
			this.$store.dispatch('reqCartsGoods', { user_id });
		}
	},
	watch: {
		categoryList() {
			this.$nextTick(() => {
				// 请求首页商品数据
				this.$store.dispatch('reqHomeShopList');
			});
		},
		$route() {
			window.location.reload()
		}
	}
}
</script>

<style scoped>
#home {
	font-family: "Microsoft YaHei";
}

/*产品展示、购买、分类简介区*/
#container {
	position: relative;
	margin: 20px auto;
	width: 100%;
	background: rgba(254, 253, 253, 0.5);
}

#container .el-row .el-col {
	height: 100%;
}

.aa {
	min-width: 1000px;
	margin-left: 30px;
	height: 100%;
}

.el-row .cateList .cate_img {
	width: 100%;
	text-indent: 14px;
	height: 35px;
	color: white;
	line-height: 40px;
	font-size: 15px;
	background: #7a1723;
}

/*自动播放图片区域*/
.el-col .el-carousel {
	height: 100%;
	border: 1px solid #7a1723;
}

.el-carousel .el-carousel__item img {
	height: 100%;
	width: 100%;
}

/*每类产品的简单展示*/
#container>.product {
	margin-top: 50px auto;
	width: 100%;
	height: 300px;
}

.product>.pro_line {
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

.pro_line>div>a {
	color: red;
	font-weight: 700;
	font-size: 17px;
	text-decoration: none;
	transition: 0.5s;
}

.pro_line>div>a:after {
	content: '»';
	opacity: 0;
	/*opacity属性不占用文档流的空间*/
	transition: 0.5s;
}

.pro_line>div:hover a:after {
	opacity: 1;
}

.product>.pro_show {
	margin: 0 auto;
	padding-left: 20px;
	width: 980px;
	height: 200px;
}

.pro_1 {
	width: 100%;
	text-align: center;
	margin-top: 300px;
}

.pro_1>.item_content {
	width: 100%;
	text-align: center;
}

/*底部对商城的补充说明*/
#footer {
	margin-top: -80px;
	width: 100%;
	height: 200px;
	background: #F0F3EF;
}

#footer>img {
	display: block;
	margin: 0 auto;
}

#footer>.footer_text {
	width: 100%;
	border-top: 1px solid #DEDEDE;
}

#scrollToTopBtn {
	/* display: none; */
	position: fixed;
	bottom: 20px;
	right: 20px;
	z-index: 99;
	cursor: pointer;
	background-color: #f56c6c;
	/* 修改为黑色 */
	color: #fff;
	border: none;
	border-radius: 50%;
	width: 50px;
	height: 50px;
	font-size: 40px;
	text-align: center;
	line-height: 50px;
}
</style>
