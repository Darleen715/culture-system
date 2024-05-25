<template>

    <div class="article-list">
        <el-card v-for="(article, index) in articles" :key="index" class="article-item">
            <div slot="header" class="article-header">
                <h2>{{ article.title }}</h2>
                <p class="publish-date">发布日期：{{ formatDate(article.publish_date) }}</p>
                <p class="category">文章标签：{{ article.tags }}</p>
            </div>
            <div class="article-content">
                <p>{{ article.content }}</p>
                <el-button @click="toggleLike(article.article_id, article.likes, index)"
                    :class="{ liked: article.liked }">
                    <i class="el-icon-star-off" v-if="!article.liked"></i>
                    <i class="el-icon-star-on" v-else></i>
                    <span>{{ article.likes }}</span>
                </el-button>
            </div>
        </el-card>
    </div>

</template>

<script>
// 引入您的API
import { getArticles, addArticleLikes } from './../../../api/index'
import { mapState } from 'vuex'


export default {
    data() {
        return {
            articles: []  // 初始化空数组来存储文章信息
        }
    },
    mounted() {
        this.getAllArticles();  // 在组件挂载后立即调用获取文章信息的方法
    },
    computed: {
        ...mapState(['userInfo'])
    },
    methods: {
        getAllArticles() {
            // 使用您的API方法获取文章信息
            getArticles()
                .then(response => {
                    // 成功获取文章信息后将其存储到组件的articles数组中
                    this.articles = response.message.map(article => {
                        // 添加likes字段并初始化为0
                        article.likes = article.likes || 0;
                        // 添加liked字段并初始化为false
                        article.liked = false;
                        return article;
                    });

                    // 根据likes属性对文章列表进行排序，降序排列
                    this.articles.sort((a, b) => b.likes - a.likes);
                })
                .catch(error => {
                    console.error('获取文章信息时出错：', error);
                });
        },
        async toggleLike(article_id, likes, index) {
            try {
                // 检查本地存储是否存在点赞记录
                console.log(this.userInfo);
                const likedArticles = JSON.parse(localStorage.getItem('likedArticles')) || [];
                // 如果用户已经点赞过该文章，则不执行点赞操作
                if (likedArticles.includes(article_id)) {
                    this.$message({
                        type: 'warning',
                        message: '您已经点赞过该文章了！',
                        showClose: true,
                    });
                    return;
                }
                const result = await addArticleLikes(article_id, likes + 1);
                if (result.success_code === 200) {
                    this.$message({
                        type: 'success',
                        message: result.message,
                        showClose: true,
                    });
                    // 更新本地文章列表中的likes数
                    this.articles[index].likes++;
                    // 标记已点赞
                    this.articles[index].liked = true;
                    // 将文章ID添加到已点赞列表中，保存到本地存储
                    likedArticles.push(article_id);
                    localStorage.setItem('likedArticles', JSON.stringify(likedArticles));
                } else {
                    this.$message({
                        type: 'error',
                        message: result.message,
                        showClose: true,
                    });
                }
            } catch (error) {
                this.$message.error('Failed to toggle like:');
                console.error('Failed to toggle like:', error);
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
        }
    }
}
</script>

<style scoped>
.article-list {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    align-items: flex-start;
}

.article-item {
    margin-bottom: 20px;
    width: 27%;
    height: 100%;
    min-height: 400px;
    margin: 2.5%;
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
</style>
