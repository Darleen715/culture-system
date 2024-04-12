<template>
    <div>
        <!--面包屑导航栏-->
        <el-breadcrumb separator-class="el-icon-arrow-right" style="margin-top:20px; margin-bottom:10px">
            <el-breadcrumb-item>首页</el-breadcrumb-item>
            <el-breadcrumb-item>文章信息</el-breadcrumb-item> </el-breadcrumb>
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
                        <el-form label-position="left" inline-block class="demo-table-expand">
                            <el-form-item label="文章标题">
                                <span>{{ props.row.title }}</span>
                            </el-form-item>
                            <el-form-item label="文章内容">
                                <span>{{ props.row.content }}</span>
                            </el-form-item>
                            <el-form-item label="文章标签">
                                <span>{{ props.row.tags }}</span>
                            </el-form-item>
                        </el-form>
                    </template>
                </el-table-column>
                <el-table-column label="文章ID" prop="article_id">
                </el-table-column>
                <el-table-column label="作者ID" prop="author_id">
                </el-table-column>
                <el-table-column label="文章标题" prop="title">
                </el-table-column>
                <!-- <el-table-column label="标签" prop="tags">
                </el-table-column> -->
                <el-table-column label="操作">
                    <template slot-scope="props">
                        <el-button size="mini" type="danger"
                            @click="handleDelete(props.$index, props.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination background layout="prev, pager, next" :page-count="pageNum"
                @current-change="handleCurrentChange">
            </el-pagination>
        </el-card>



    </div>
</template>

<script>
import { getArticles, deleteArticle } from './../../../api/index';
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
        this.getAllArticles();
    },
    methods: {
        async handleDelete(index, row) {
            this.$confirm('您确定永久删除该文章吗?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(async () => {
                let result = await deleteArticle(row.article_id, row.title);
                if (result.success_code === 200) {
                    this.$message({
                        type: 'success',
                        message: '已删除'
                    });
                    setTimeout(() => {
                        window.location.reload(); // 删除成功后等待两秒再刷新当前页面
                    }, 2000); // 2000毫秒等于两秒
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
        async getAllArticles() {
            let result = await getArticles();
            if (result.success_code === 200) {
                this.tableData = result.message;
                console.log(this.tableData);
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