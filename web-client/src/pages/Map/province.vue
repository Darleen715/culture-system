<template>
  <div>
    <div @click="goBack()" class="back">返回</div>
    <div :id="id" class="provinceCharts"></div>
  </div>
</template>

<script>
import { mapState } from 'vuex';
export default {
  name: 'province',
  data() {
    return {
      id: 'echarts_' + new Date().getTime() + Math.floor(Math.random() * 1000),
      echartObj: null,
      option: {
        title: {
          text: '',
          top: '8%',
          left: '8%',
          textStyle: {
            fontSize: 14,
            fontWeight: 300,
            color: '#000'
          }
        },
        tooltip: {
          padding: 0,
          // 数据格式化
          formatter: function (params, callback) {
            return params.name + '：' + (params.value || 0)
          }
        },
        legend: {
          orient: 'vertical',
          top: '9%',
          left: '5%',
          icon: 'circle',
          data: [],
          selectedMode: 'single',
          selected: {},
          itemWidth: 12,
          itemHeight: 12,
          itemGap: 30,
          inactiveColor: '#b6d7ff',
          textStyle: {
            color: '#ec808d',
            fontSize: 14,
            fontWeight: 300,
            padding: [0, 0, 0, 15]
          }
        },
        visualMap: {
          min: 0,
          max: 500,
          left: 'left',
          top: 'bottom',
          text: ['高', '低'], // 取值范围的文字
          inRange: {
            color: ['#e0ffff', 'blue'] // 取值范围的颜色
          },
          show: true // 图注
        },
        geo: {
          map: '',
          roam: false, // 不开启缩放和平移
          zoom: 0.6, // 视角缩放比例
          label: {
            normal: {
              show: true,
              fontSize: 10,
              color: '#000'
            },
            emphasis: {
              show: true,
              color: 'blue',
            }
          },
          itemStyle: {
            normal: {
              borderColor: 'rgba(0, 0, 0, 0.2)'
            },
            emphasis: {
              areaColor: 'skyblue', // 鼠标选择区域颜色
              shadowOffsetX: 0,
              shadowOffsetY: 0,
              shadowBlur: 20,
              borderWidth: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          },
          left: '5%',
          right: '5%',
          top: '5%',
          bottom: '5%'
        },
        series: [
          {
            name: '省份数据',
            type: 'map',
            geoIndex: 0, // 不可缺少，否则无tooltip 指示效果
            data: []
          }
        ],
        provinceJSON: {},
        provinceName: ''
      }
    }
  },
  computed: {
    ...mapState(['userInfo', 'cartgoods'])
  },
  mounted() {
    this.initDate();
    this.resizeListener();

    let user_id = this.userInfo.id;
    this.initCart(user_id);
    this.initProvinceCount(this.cartgoods)
  },
  methods: {
    initProvinceCount(dataList) {
      // 创建一个空对象来存储每个 region 的计数
      const regionCounts = {};

      // 遍历 dataList 数组
      for (let i = 0; i < dataList.length; i++) {
        const region = dataList[i].region;

        // 如果当前 region 已经存在于 regionCounts 中，则将其计数加一；否则，初始化为 1
        if (regionCounts.hasOwnProperty(region)) {
          regionCounts[region]++;
        } else {
          regionCounts[region] = 1;
        }
      }

      // 输出每个 region 的计数
      for (const region in regionCounts) {
        console.log(`${region}: ${regionCounts[region]}`);
      }
    },

    initCart(user_id) {
      console.log(user_id);
      // this.$store.dispatch('reqCartsGoods', { user_id });
      console.log('aaaa');
      console.log(this.cartgoods);
      // 绘制地图
    },
    initDate() {
      const provinceName = this.$route.query.provinceName
      const province = this.$route.query.province
      this.provinceName = provinceName
      this.provinceJSON = require('../../utils/省份数据/json(省份)/' + provinceName)
      this.option.title.text = province;
      this.option.geo.map = province
      this.echartObj = this.$echarts.init(document.getElementById(this.id))
      this.$echarts.registerMap(province, this.provinceJSON)
      this.echartObj.setOption(this.option);
      this.echartObj.on("click", (params) => {
        this.$router.push({
          path: "/city",
          query: { city: params.name },
        });
      });
    },
    resizeListener() {
      window.addEventListener('resize', () => {
        if (this.echartObj && this.echartObj.resize) {
          this.echartObj.resize()
        }
      })
    },
    goBack() {
      this.$router.back()

    },
  }
}
</script>
<style scoped>
.provinceCharts {
  height: 800px;
  width: 800px;
  margin: auto;
}

.back {
  text-align: center;
}
</style>
