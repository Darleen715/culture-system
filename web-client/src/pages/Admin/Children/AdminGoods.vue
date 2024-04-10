<template>
  <div>
    <!--面包屑导航栏-->
    <el-breadcrumb separator-class="el-icon-arrow-right" style="margin-top:20px; margin-bottom:10px">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品信息</el-breadcrumb-item> </el-breadcrumb>
    <!--卡片-->
    <el-card class="box-card" style="box-shadow:0 1px 1px rgba( 0,0,0,0.15) !important">
      <div style="margin-top: 15px;">
        <el-row :gutter="70">
          <el-col :span="14">
            <el-input placeholder="请输入内容" type="text" style="width:250px; height:35px;">
              <el-button slot="append" icon="el-icon-search" @click="getUsers"></el-button>
            </el-input>
          </el-col>

        </el-row>
      </div>
      <el-table :data="tempData" style="width: 100%">
        <el-table-column type="expand">
          <template slot-scope="props">
            <el-form label-position="left" inline class="demo-table-expand">
              <el-form-item label="商品名称">
                <span>{{ props.row.short_name }}</span>
              </el-form-item>
              <el-form-item label="商品 ID">
                <span>{{ props.row.goods_id }}</span>
              </el-form-item>
              <el-form-item label="商品分类">
                <span>{{ category[props.row.category - 1] }}</span>
              </el-form-item>
              <el-form-item label="商品价格">
                <span>{{ (props.row.price / 100) | priceFormat }}</span>
              </el-form-item>
              <el-form-item label="商品库存">
                <span>{{ props.row.counts }}</span>
              </el-form-item>
              <el-form-item label="商品描述">
                <span>{{ props.row.goods_name }}</span>
              </el-form-item>
              <el-form-item label="商品图片">
                <img :src="props.row.thumb_url" style="width:70px" />
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column label="商品 ID" prop="goods_id">
        </el-table-column>
        <el-table-column label="商品名称" prop="short_name">
        </el-table-column>
        <el-table-column label="描述" prop="goods_name">
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="props">
            <el-button size="mini" @click="handleEdit(props.$index, props.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(props.$index, props.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination background layout="prev, pager, next" :page-count="pageNum" @current-change="handleCurrentChange">
      </el-pagination>
    </el-card>



  </div>
</template>

<script>
import { getAllgoods, deleteRecomGoods } from './../../../api/index';
import { mapState } from 'vuex';
import { mapActions } from 'vuex'

export default {
  data() {
    return {
      category: ['祥瑞潮玩系列', '锦鲤首饰', '香薰纸艺灯', '创意马克杯', '竹乡折扇'],
      currentIndex: 1,
      pageSize: 10,
      tableData: [],
      tempData: [],
    }
  },
  mounted() {
    this.getAllGoods();
  },
  methods: {
    handleEdit(index, row) {
      console.log(index, row);
      window.localStorage.setItem('goodsInfo', JSON.stringify(row));
      this.$router.replace('/admin/adminupdate');
    },
    async handleDelete(index, row) {
      this.$confirm('您确定永久删除该商品吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        let result = await deleteRecomGoods(row.goods_id);
        if (result.success_code === 200) {
          this.$message({
            type: 'success',
            message: '已删除'
          });
        }
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    handleCurrentChange(val) {
      this.currentIndex = val;
      this.tempData = [];
      this.tableData.forEach((data, index) => {
        if (index >= (this.currentIndex - 1) * this.pageSize && index < (this.currentIndex) * this.pageSize) {
          this.tempData.push(data);
        }
      });
    },
    async getAllGoods() {
      let result = await getAllgoods();
      if (result.success_code === 200) {
        this.tableData = result.message;
        this.tableData.forEach((data, index) => {
          if (index >= (this.currentIndex - 1) * this.pageSize && index < (this.currentIndex) * this.pageSize) {
            this.tempData.push(data);
          }
        });
      }
    },
  },
  computed: {
    pageNum() {
      return Math.ceil(this.tableData.length / this.pageSize);
    }
  },
  filters: {
    priceFormat(price) {
      return price.toFixed(2);
    },
  },
}
</script>

<style scoped>
.el-table {
  margin: 20px auto 50px;
}

.demo-table-expand {
  font-size: 0;
}

.demo-table-expand label {
  width: 90px;
  color: #99a9bf;
}

.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 50%;
}

.el-pagination {
  text-align: center;
}
</style>
