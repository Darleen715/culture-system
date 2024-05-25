<template>
	<div class="header_container">
		<!-- <div class="header_img"><img src="../../common/img/logo.png" /></div> -->
		<div class="header_search">
			<div>
				<input type="text" placeholder="搜索  商品名称" v-model="keywords" />
				<el-button type="danger" icon="el-icon-search" @click="postSearch"></el-button>
			</div>
		</div>
	</div>
</template>

<script>
import { MessageBox } from 'element-ui'
import { mapState } from 'vuex'
import { mapActions } from 'vuex'

export default {
	data() {
		return {
			keywords: ''
		}
	},
	computed: {
		...mapState(['userInfo'])
	},
	methods: {
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
		async postSearch() {
			if (this.keywords) {
				let keywords = this.keywords;
				this.$store.dispatch('reqSearch', { keywords });
				this.keywords = ''
				this.$router.replace('/searchdetail');
			}
		},
	},
}
</script>

<style scoped>
/*头部搜索区*/
.header_container {
	position: relative;
	width: 100%;
	height: 140px;
	margin: 0;
	padding: 0;
}

/*商城标识图片区域*/
.header_container>.header_img {
	position: absolute;
	left: 120px;
	margin-top: 10px;
	width: 200px;
	height: 140px;
}

.header_img>img {
	width: 100%;
	height: 100%;
}

.header_search {
	position: absolute;
	left: 50%;
	margin-left: -290px;
	margin-top: 50px;
}

.header_search div {
	display: flex;
	align-items: center;
}

.header_search input {
	padding-left: 10px;
	width: 490px;
	height: 46px;
	font-size: 14px;
	line-height: 40px;
	border: 1px solid #71041a;
	border-right: none;
	outline: none;
}

.header_search button.el-button.el-button--danger {
	padding: 0;
	width: 60px;
	height: 47px;
	font-size: 18px;
	border-radius: 0;
	outline: none;

	display: flex;
	justify-content: center;
	align-items: center;
}

.header_search>p>a {
	display: inline-block;
	padding: 5px 10px;
	font-size: 12px;
	color: #999;
	cursor: pointer;
}

.header_search>p>a:hover {
	color: rgb(93, 5, 5);
}

/*头部的收藏夹标记区域*/
.header_container>.shopping_bag {
	position: absolute;
	margin-top: 55px;
	right: 120px;
	width: 190px;
	height: 35px;
	text-align: center;
	line-height: 35px;
	font-size: 14px;
	border: 1px solid red;
	border-radius: 5%;
	background: #f8f9fa;
	color: red;
	cursor: pointer;
}

.shopping_bag>img {
	display: inline-block;
	margin-left: 5px;
	margin-top: 5px;
	width: 17px;
	height: 17px;
}

.shopping_bag>a {
	color: red;
}
</style>
