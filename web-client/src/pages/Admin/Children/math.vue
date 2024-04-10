<template>
  <div>
    <!-- 面包屑导航区域 -->
    <el-breadcrumb style="margin-top: 20px;font-size: 16px;" separator-class="el-icon-arrow-right">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
      <el-breadcrumb-item>数据统计</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 卡片视图区域 -->
    <el-row :gutter="20" style="margin-top:50px;margin-bottom:150px">
      <el-col >
        <el-card>
          <div id="main" style="width:800px;height:600px"></div>
        </el-card>
      </el-col>
    </el-row>

  </div>
</template>


<script>
import * as echarts from 'echarts';
import 'echarts-wordcloud';
import { getArticles } from './../../../api/index';

export default {
  mounted() {
    this.fetchDataAndRenderWordCloud();


  },
  methods: {
    async fetchDataAndRenderWordCloud() {
      try {
        // 调用 API 接口获取文章数据
        const response = await getArticles();
        const articles = response.message;

        // 1. 解析文章数据对象中的 tags 字段并统计喜欢数
        const tagCountMap = {};
        articles.forEach(article => {

          const tags = JSON.parse(article.tags); // 解析 tags 字段为数组
          if (Array.isArray(tags)) {
            tags.forEach(tag => {
              tagCountMap[tag] = (tagCountMap[tag] || 0) + article.likes; // 统计标签出现次数并累加喜欢数
            });
          }

        });

        // 2. 构建词云图的数据格式
        const wordCloudData = Object.keys(tagCountMap).map(tag => ({
          name: tag,
          value: tagCountMap[tag], // 使用标签的喜欢数作为词的大小
        }));

        // 初始化 echarts 实例
        var myChart = echarts.init(document.getElementById('main'))

        // 设置词云图的配置项
        const option = {
          series: [{
            type: 'wordCloud',
            gridSize: 20,
            sizeRange: [20, 80],
            rotationRange: [-45, 45],
            shape: 'circle',
            textStyle: {
              normal: {
                fontFamily: 'Arial, sans-serif',
                fontWeight: 'bold',
                // color: function () {
                //   const colors = [
                //     'rgb(245, 108, 108)', // 红色
                //     'rgb(122, 23, 35)',   // 深红色
                //     'rgb(52, 168, 83)',   // 绿色
                //     'rgb(0, 114, 206)',   // 蓝色
                //     'rgb(255, 185, 0)',   // 黄色
                //     // 添加更多颜色...
                //   ];
                //   return colors[Math.floor(Math.random() * colors.length)];
                // }
                color: function () {
                  return 'rgb(' + [
                    Math.round(Math.random() * 160),
                    Math.round(Math.random() * 160),
                    Math.round(Math.random() * 160)
                  ].join(',') + ')';
                }
              }
            },
            data: wordCloudData,
          }]
        };


        // 使用配置项设置词云图
        myChart.setOption(option);
      } catch (error) {
        console.error('Failed to fetch data:', error);
      }
    }
  }
};
</script>


<style></style>