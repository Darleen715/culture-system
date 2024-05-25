<template>
	<div v-if="categoryList.length">
		<div id="container">
			<div class="product">
				<div class="pro_line">
					<h3 v-text="currentCategoryName"></h3>
					<el-dropdown @command="handleCommand">
						<span class="el-dropdown-link">
							更多类别<i class="el-icon-arrow-down el-icon--right"></i>
						</span>
						<el-dropdown-menu slot="dropdown">
							<el-dropdown-item v-for="cate in categoryList" :key="cate.cate_id" :command="cate.cate_id">
								{{ cate.cate_name }}
							</el-dropdown-item>
						</el-dropdown-menu>
					</el-dropdown>
					<router-link to="/home" class="goHome" @click="goToHome">返回首页</router-link>

				</div>
				<div class="pro_show">
					<ProductItem v-for="goods in recommendshoplist" :key="goods.goods_id" :pro="goods" />
				</div>
			</div>
		</div>
		<div id="footer">
			<ul class="pagination">
				<li><a class="pag_back" @click="getMore(activeIndex - 1)">«</a></li>
				<li>
					<router-link v-for="index in catePages" :key="index" :to="`/search/${currentCate}/${index}`"
						class="pag_a" :class="{ pag_active: activeIndex === index }">
						{{ index }}
					</router-link>
				</li>
				<li><a class="pag_go" @click="getMore(activeIndex + 1)">»</a></li>
			</ul>
		</div>
	</div>
</template>

<script>
import { mapState } from 'vuex'
import ProductItem from '../../components/ProductItem/ProductItem'

export default {
	data() {
		return {
			activeIndex: 1,
			currentCate: 1,
			pageSize: 3,
		}
	},
	components: {
		ProductItem
	},
	computed: {
		...mapState(['categoryList', 'userInfo', 'recommendshoplist']),
		catePages() {
			if (!this.categoryList[this.currentCate - 1]) return 0;
			return Math.ceil(this.categoryList[this.currentCate - 1].cate_counts / this.pageSize);
		},
		currentCategoryName() {
			return this.categoryList[this.currentCate - 1].cate_name || '';
		}
	},
	created() {
		this.currentCate = Number(this.$route.params.id);
		this.activeIndex = Number(this.$route.params.pageNo);
		console.log(this.currentCate, this.activeIndex);
		this.$store.dispatch('reqCategory');
		this.$store.dispatch('reqRecommendShopList', {
			category: this.currentCate,
			pageNo: this.activeIndex,
			count: this.pageSize
		});
		// console.log(this.categoryList);
		// this.$store.dispatch('getUserInfo');
	},
	watch: {
		watch: {
			$route() {
				this.currentCate = Number(this.$route.params.id);
				this.activeIndex = Number(this.$route.params.pageNo);
				this.$store.dispatch('reqRecommendShopList', {
					category: this.currentCate,
					pageNo: this.activeIndex,
					count: this.pageSize
				});
			},
		},
	},

	methods: {
		handleCommand(command) {
			console.log('Command:', command);
			const categoryId = parseInt(command);
			if (!isNaN(categoryId)) {
				this.$store.dispatch('reqRecommendShopList', {
					category: categoryId,
					pageNo: 1,
					count: this.pageSize
				});
				this.$router.replace(`/search/${categoryId}/1`);
				this.currentCate = categoryId;
				this.activeIndex = 1;
			} else {
				console.error('Invalid category ID:', command);
			}
		},

		goDetail(id) {
			this.$router.replace('/goods/' + id);
		},

		getMore(index) {
			if (index > 0 && index <= this.catePages) {
				this.$store.dispatch('reqRecommendShopList', {
					category: this.currentCate,
					pageNo: index,
				});
				this.activeIndex = index;
				this.$router.replace(`/search/${this.currentCate}/${index}`);
			}
		},
		goToHome() {
			// 导航到首页并刷新
			this.$router.push('/home');
			location.reload();
		},
	},
}
</script>






<style scoped>
#container {
	background-image: url("R-C.jpg");
	background-size: 100%;
	margin: 0 auto;
	width: 100%;

}

.product {
	margin: 50px auto;
	width: 980px;
}

.product>.pro_line {
	margin-bottom: 20px;
	width: 980px;
	height: 60px;
	line-height: 50px;
	font-size: 26px;
	font-family: sans-serif;
	font-weight: normal;
	color: #222;
}

.pro_line>h3 {
	margin-top: 80px;
	display: inline-block;
}

.el-dropdown-link {
	display: inline-block;
	cursor: pointer;
	color: #4498f9;
}

.el-icon-arrow-down {
	font-size: 12px;
}

.goHome {
	font-size: 14px;
	display: inline-block;
	margin-left: 20px;
	text-decoration: none;
	color: rgb(1, 180, 250);
	cursor: pointer;
}

.goHome:hover {
	color: #ccc;
}

.product>.pro_show {
	margin: 80px auto;
	padding-left: 20px;
	width: 980px;
	height: 300px;
}

.pro_show>.pro {
	position: relative;
	float: left;
	margin-right: 20px;
	margin-bottom: 20px;
	width: 300px;
	height: 200px;
	border: 1px solid rgb(143, 32, 32);
}

.pro>.pro_img {
	margin: 20px;
	width: 120px;
	height: 120px;
}

.pro>.pro_text {
	position: absolute;
	top: 30px;
	right: 0;
	height: 130px;
	width: 140px;
	line-height: 25px;
}

.pro_text>p {
	margin-bottom: 10px;
}

.pro_text>p:first-child {
	color: red;
	font-weight: 900;
}

.pro_text>p:nth-child(2) {
	font-size: 13px;
}

.pro_text>p:nth-child(3) {
	font-size: 12px;
	color: #999;
}

.pro>.add_btn {
	float: right;
	position: absolute;
	bottom: 15px;
	right: 20px;
}

.add_btn>a {
	display: block;
	width: 120px;
	height: 25px;
	text-align: center;
	line-height: 25px;
	background: #FF0036;
	color: white;
	cursor: pointer;
}

#footer {
	height: 50px;
	width: 100%;
	display: flex;
}

#footer>ul.pagination {
	margin: 0 auto;
}

ul.pagination li {
	float: left;
}

ul.pagination li a {
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	color: black;
	border: 1px solid #ddd;
}

ul.pagination li a.pag_active {
	background-color: #c40000;
	color: white;
	border: 1px solid #c40000;
}

ul.pagination li a:hover:not(.pag_active) {
	background-color: #ddd;
}

div.center {
	text-align: center;
}
</style>
