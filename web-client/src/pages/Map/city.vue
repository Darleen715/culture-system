<template>
  <div>
    <div @click="goBack()" class="back">返回</div>
    <div :id="id" class="cityCharts"></div>
  </div>
</template>

<script>
import { cityMap } from '@/utils/城市数据/china-main-city-map.js'
export default {
  name: 'city',
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
            name: '城市数据',
            type: 'map',
            geoIndex: 0, // 不可缺少，否则无tooltip 指示效果
            data: []
          }
        ],
        cityJSON: {},
        cityName: ''
      }
    }
  },
  mounted() {
    this.initDate();
    this.resizeListener();
  },
  methods: {
    initDate() {
      const city = this.$route.query.city
      this.option.title.text = city;
      this.cityName = city;
      const cityId = cityMap[city];
      this.cityJSON = require('../../utils/城市数据/' + cityId + '.json')
      this.option.geo.map = city
      this.echartObj = this.$echarts.init(document.getElementById(this.id))
      this.$echarts.registerMap(city, this.cityJSON)
      this.echartObj.setOption(this.option);
    },
    resizeListener() {
      window.addEventListener('resize', () => {
        if (this.echartObj && this.echartObj.resize) {
          this.echartObj.resize()
        }
      })
    },
    goBack() {
      this.$router.go(-1)
    },
  }
}
</script>
<style scoped>
.cityCharts {
  height: 800px;
  width: 800px;
  margin: auto;
}

.back {
  text-align: center;
}
</style>
