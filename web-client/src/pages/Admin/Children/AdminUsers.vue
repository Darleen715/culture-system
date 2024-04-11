<template>
  <div id="admin-users">
    <!--面包屑导航栏-->
    <el-breadcrumb separator-class="el-icon-arrow-right" style="margin-top:20px; margin-bottom:10px">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>

    <!--卡片-->
    <el-card class="box-card" style="box-shadow:0 1px 1px rgba( 0,0,0,0.15) !important">
      <div style="margin-top: 15px;">
        <el-input type="text" v-model="input3" placeholder="请输入内容" style="width:250px; height:35px;">
          <el-button slot="append" icon="el-icon-search" @click="getUsers"></el-button>
        </el-input>
        <el-button type="primary" size="mini" style="margin-left:700px">添加</el-button>
      </div>
      <el-table :data="pagedTableData" style="width: 100%; margin-top:20px;font-size:13px" border stripe>
        <el-table-column type="index">
        </el-table-column>
        <el-table-column prop="id" label="用户ID">
        </el-table-column>
        <el-table-column prop="user_name" label="账号">
        </el-table-column>
        <el-table-column prop="user_phone" label="手机">
        </el-table-column>
        <el-table-column prop="user_nickname" label="昵称">
        </el-table-column>
        <el-table-column prop="user_address" label="住址">
        </el-table-column>

        <el-table-column label="操作">
          <template slot-scope="props">
            <el-button size="mini" type="danger" @click="handleDelete(props.$index, props.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination style="margin-left:400px; margin-top:25px" background layout="prev, pager, next"
        :page-count="totalPages" @current-change="handlePageChange">
      </el-pagination>
    </el-card>


  </div>
</template>

<script>
import { getAllUsers, deleteUser } from '../../../api/index'

export default {
  data() {
    return {
      input3: "",
      tableData: [],
      pagedTableData: [], // 当前页的用户数据
      totalPages: 0, // 总页数
      pageSize: 10, // 每页显示的条数
      currentIndex: 1, // 当前页码，默认为第一页
    }
  },
  mounted() {
    this.getUsers();
  },
  methods: {
    async getUsers() {
      const results = await getAllUsers();
      if (results.success_code === 200) {
        this.tableData = results.message;
        this.totalPages = Math.ceil(this.tableData.length / this.pageSize); // 计算总页数
        this.updatePagedTableData();
      }
    },
    async handleDelete(index, row) {
      const results = await deleteUser(row.id, row.user_name);
      if (results.success_code === 200) {
        this.$message({
          type: 'success',
          message: `成功删除用户${row.user_name}！`
        });
        setTimeout(() => {
          this.getUsers(); // 重新获取用户数据
          window.location.reload(); // 评论成功后等待两秒再刷新当前页面
        }, 1000); // 1000毫秒等于一秒

      } else {
        this.$message({
          type: 'error',
          message: '该用户有发布过的文章未清空，无法删除！'
        });
        setTimeout(() => {
          window.location.reload(); // 评论成功后等待两秒再刷新当前页面
        }, 1000); // 1000毫秒等于一秒
      }
    },
    handlePageChange(val) {
      // 当前页码发生变化时触发
      this.currentIndex = val;
      this.updatePagedTableData();
    },
    updatePagedTableData() {
      // 更新当前页的用户数据
      const startIndex = (this.currentIndex - 1) * this.pageSize;
      const endIndex = Math.min(startIndex + this.pageSize, this.tableData.length);
      this.pagedTableData = this.tableData.slice(startIndex, endIndex);
    }
  }
}
</script>

<style scoped></style>
