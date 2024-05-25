// 1. 引入对应模块
import Vue from 'vue'
import VueRouter from 'vue-router'

const Home = () => import('./../pages/Home/Home');
const Login = () => import('./../pages/Login/Login');
const Register = () => import('./../pages/Login/Register');
const Search = () => import('./../pages/Search/Search');
const Goods = () => import('./../pages/Goods/Goods');
const Me = () => import('./../pages/Me/Me');
const ShopCar = () => import('./../pages/ShopCar/ShopCar');
const AdminLogin = () => import('./../pages/AdminLogin/AdminLogin');
const Admin = () => import('./../pages/Admin/Admin');
const SearchDetail = () => import('./../pages/SearchDetail/SearchDetail');

const China = () => import('./../pages/Map/china.vue')
const Province = () => import('./../pages/Map/province.vue')
const City = () => import('./../pages/Map/city.vue')

const Articles = () => import('./../pages/Articles/Articles.vue')
const ArticlesShow = () => import('./../pages/Articles/Children/ArticleShow.vue')
const AddArticle = () => import('./../pages/Articles/Children/AddArticle.vue')


const Profile = () => import('./../pages/Me/Children/Profile');
const Update = () => import('./../pages/Me/Children/Update');
const EditPwd = () => import('./../pages/Me/Children/EditPwd');
const EditPhone = () => import('./../pages/Me/Children/EditPhone');
const Sales = () => import('./../pages/Me/Children/Sales');
const AdminSales = () => import('./../pages/Admin/Children/AdminSales');
const AddGoods = () => import('./../pages/Admin/Children/AddGoods');
const AdminGoods = () => import('./../pages/Admin/Children/AdminGoods');
const AdminUpdate = () => import('./../pages/Admin/Children/AdminUpdate');
const AdminUsers = () => import('./../pages/Admin/Children/AdminUsers');
const AdminArticles = () => import('./../pages/Admin/Children/AdminArticles.vue')

const math = () => import('../pages/Admin/Children/math');
const comment = () => import('../pages/Admin/Children/comment');

// 2. 声明使用
Vue.use(VueRouter);

// 3. 输出路由对象
export default new VueRouter({
  // 3.1 配置一级路由
  routes: [
    {
      path: '/home',
      component: Home,
      meta: { showHeaderTop: true, showHeaderSearch: true, keepAlive: true },
      // beforeRouteEnter: (to, from, next) => {
      //   // 每次进入Home页面之前都执行页面刷新逻辑
      //   window.location.reload();
      //   next();
      // }
    },
    {
      path: '/login',
      component: Login,
      meta: { keepAlive: true }
    },
    {
      path: '/register',
      component: Register,
      meta: { keepAlive: true }
    },
    {
      path: '/china',
      component: China,
      meta: { showHeaderTop: true, keepAlive: true }
    },
    {
      path: '/province',
      component: Province,
      meta: { showHeaderTop: true, keepAlive: false }
    },
    {
      path: '/city',
      component: City,
      meta: { showHeaderTop: true, keepAlive: false }
    },
    {
      path: '/articles',
      component: Articles,
      children: [
        { path: '', component: ArticlesShow },
        { path: 'addarticle', component: AddArticle }
      ],
      meta: { showHeaderTop: true, keepAlive: true }
    },
    {
      path: '/search/:id/:pageNo',
      component: Search,
      meta: { showHeaderTop: true, showHeaderSearch: true, keepAlive: false }
    },
    {
      path: '/goods/:id',
      component: Goods,
      meta: { showHeaderTop: true, keepAlive: true }
    },
    {
      path: '/me',
      component: Me,
      children: [
        { path: 'profile', component: Profile },
        { path: 'update', component: Update },
        { path: 'editpwd', component: EditPwd },
        { path: 'editphone', component: EditPhone },
        { path: 'sales', component: Sales },
        { path: '/me', redirect: '/me/profile' }
      ],
      meta: { keepAlive: true }
    },
    {
      path: '/shopcar',
      component: ShopCar,
      meta: { showHeaderTop: true, keepAlive: true }
    },
    {
      path: '/adminlogin',
      component: AdminLogin,
      meta: { keepAlive: true }
    },
    {
      path: '/admin',
      component: Admin,
      children: [
        { path: 'adminsales', component: AdminSales },
        { path: 'math', component: math },
        { path: 'comment', component: comment },
        { path: 'adminusers', component: AdminUsers },
        { path: 'addgoods', component: AddGoods },
        { path: 'admingoods', component: AdminGoods },
        { path: 'adminupdate', component: AdminUpdate },
        { path: 'adminarticles', component: AdminArticles },
        { path: '/admin', redirect: '/admin/admingoods' }
      ],
      meta: { keepAlive: true }
    },
    {
      path: '/searchdetail',
      component: SearchDetail,
      meta: { showHeaderTop: true, showHeaderSearch: true, keepAlive: true }
    },
    {
      path: '/',
      redirect: '/home',
      meta: { keepAlive: true }
    },
  ]
});
