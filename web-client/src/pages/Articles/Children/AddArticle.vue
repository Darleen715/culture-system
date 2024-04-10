<template>
  <div class="add-article-container">
    <h2>发表文创文章</h2>
    <el-form :model="article" ref="articleForm" label-width="80px" class="article-form"
      @submit.native.prevent="submitArticle">
      <el-form-item label="标题" prop="title" required>
        <el-input v-model="article.title" placeholder="请输入文章标题" clearable></el-input>
      </el-form-item>
      <el-form-item label="内容" prop="content" required>
        <el-input type="textarea" v-model="article.content" placeholder="请输入文章内容" :rows="6" clearable></el-input>
      </el-form-item>

      <el-form-item label="标签" prop="tags" required>
        <el-tag v-for="tag in article.tags" :key="tag" closable @close="removeTag(tag)">{{ tag }}</el-tag>
        <el-input v-model="newTag" placeholder="请输入标签" @keyup.enter="addTag"></el-input>
        <el-button @click="addTag">添加标签</el-button>
      </el-form-item>
      <el-form-item label="" prop="confirmAuthor" required>
        <el-checkbox v-model="article.confirmAuthor">确认为本人</el-checkbox>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" native-type="submit">发表文章</el-button>
        <el-button @click="goBack">返回</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
// 引入您的API
import { addArticle } from './../../../api/index'

export default {
  data() {
    return {
      article: {
        title: '',
        content: '',
        tags: [],
        likes: 0,
        collects: 0,
        confirmAuthor: false
      },
      newTag: ''
    }
  },
  methods: {

    async submitArticle() {
      if (this.article.tags.length === 0) {
        this.$message.error('请至少添加一个标签！');
        return;
      }
      let userInfo = JSON.parse(window.localStorage.getItem("userInfo"));
      // 异步函数内部
      this.$refs.articleForm.validate(async (valid) => {
        if (valid) {

          try {
            // 调用API添加文章
            let result = await addArticle(this.article.title, this.article.content, this.article.likes, this.article.collects, JSON.parse(JSON.stringify(this.article.tags)), userInfo.id);
            if (result.success_code === 200) {
              this.$message({
                type: 'success',
                message: result.message,
                showClose: true,
              });
              // 清空表单
              this.clearForm();
              // 等待3秒后跳转到目标页面
              setTimeout(() => {
                this.$router.push({ path: '/articles' }); 
              }, 2000);
            } else {
              this.$message({
                type: 'error',
                message: result.message,
                showClose: true,
              });
            }
          } catch (error) {
            this.$message.error('添加文章时出错，请重试！');
            console.error('添加文章时出错：', error);
          }
        } else {
          return false;
        }
      });
    },
    clearForm() {
      // 清空表单
      this.article.title = '';
      this.article.content = '';
      this.article.tags = [];
      this.article.likes = this.generateRandomNumber();
      this.article.collects = this.generateRandomNumber();
    },
    goBack() {
      this.$router.back();
    },
    addTag() {
      if (this.newTag.trim() !== '' && !this.article.tags.includes(this.newTag)) {
        this.article.tags.push(this.newTag.trim());
        this.newTag = '';
      }
    },
    removeTag(tag) {
      const index = this.article.tags.indexOf(tag);
      if (index !== -1) {
        this.article.tags.splice(index, 1);
      }
    },
    generateRandomNumber() {
      // 生成15到25之间的随机数
      return Math.floor(Math.random() * 11) + 15;
    }
  }
}
</script>

<style scoped>
.add-article-container {
  max-width: 800px;
  margin: 60px auto;
  padding: 20px;
}

.el-form-item__label {
  width: 120px;
}

.article-form {
  margin-top: 20px;
}
</style>
