<script>
import { mapState } from 'vuex';
const chinaJson = require('../../utils/china.json');
export default {
  render: function (createElement) {
    return createElement("div", {
      attrs: {
        id: "main",
      },
      style: {
        height: "800px",
        width: '800px',
        margin: 'auto'
      },
    });
  },
  data() {
    return {
      dataList: [
        { name: "南海诸岛" },
        { ename: "beijing", name: "北京" },
        { ename: "tianjin", name: "天津" },
        { ename: "shanghai", name: "上海" },
        { ename: "chongqing", name: "重庆" },
        { ename: "hebei", name: "河北" },
        { ename: "henan", name: "河南" },
        { ename: "yunnan", name: "云南" },
        { ename: "liaoning", name: "辽宁" },
        { ename: "heilongjiang", name: "黑龙江" },
        { ename: "hunan", name: "湖南" },
        { ename: "anhui", name: "安徽" },
        { ename: "shandong", name: "山东" },
        { ename: "xinjiang", name: "新疆" },
        { ename: "jiangsu", name: "江苏" },
        { ename: "zhejiang", name: "浙江" },
        { ename: "jiangxi", name: "江西" },
        { ename: "hubei", name: "湖北" },
        { ename: "guangxi", name: "广西" },
        { ename: "gansu", name: "甘肃" },
        { ename: "shanxi", name: "山西" },
        { ename: "neimenggu", name: "内蒙古" },
        { ename: "shanxi1", name: "陕西" },
        { ename: "jilin", name: "吉林" },
        { ename: "fujian", name: "福建" },
        { ename: "guizhou", name: "贵州" },
        { ename: "guangdong", name: "广东" },
        { ename: "qinghai", name: "青海" },
        { ename: "xizang", name: "西藏" },
        { ename: "sichuan", name: "四川" },
        { ename: "ningxia", name: "宁夏" },
        { ename: "hainan", name: "海南" },
        { name: "台湾" },
        { ename: "xianggang", name: "香港" },
        { ename: "aomen", name: "澳门" },
      ],
    };
  },
  computed: {
    ...mapState(['userInfo', 'cartgoods'])
  },
  mounted() {
    this.initEchart()
  },
  methods: {
    initEchart() {
      const dataList = this.dataList;
      const regionCounts = {}; // 创建一个空对象来存储每个 region 的计数

      // 遍历 cartgoods 数组
      for (let i = 0; i < this.cartgoods.length; i++) {
        const region = this.cartgoods[i].region;

        // 如果当前 region 已经存在于 regionCounts 中，则将其计数加一；否则，初始化为 1
        if (regionCounts.hasOwnProperty(region)) {
          regionCounts[region]++;
        } else {
          regionCounts[region] = 1;
        }
      }
      console.log(regionCounts);
      // 遍历 dataList 数组，设置每个 dataList[i].value 为对应的 regionCounts 中的值
      for (let i = 0; i < dataList.length; i++) {
        const region = dataList[i].name;
        // 如果 region 存在于 regionCounts 中，则将 dataList[i].value 设置为 regionCounts 中对应的值，否则设置为 0
        dataList[i].value = regionCounts[region] || 0;
      }


      // 计算 likeSum，即获取 regionCounts[region] 的最大值
      let likeSum = 0;
      for (const region in regionCounts) {
        if (regionCounts[region] > likeSum) {
          likeSum = regionCounts[region];
        }
      }

      const _this = this;
      var myChart = this.$echarts.init(document.getElementById("main"));
      this.$echarts.registerMap('china', chinaJson)
      var option = {
        tooltip: {
          //数据格式化
          formatter: function (params, callback) {
            return (
              params.seriesName + "<br />" + params.name + "：" + params.value
            );
          },
        },
        visualMap: {
          min: 0,
          max: likeSum, // 使用 likeSum 作为 max 属性的值
          left: "left",
          top: "bottom",
          text: ["高", "低"], //取值范围的文字
          inRange: {
            color: ["#e0ffff", "#E72929"], //取值范围的颜色
          },
          show: true, //图注
        },
        geo: {
          map: 'china', //引入地图数据
          roam: false, //不开启缩放和平移
          zoom: 1, //视角缩放比例
          label: {
            normal: {
              show: true,
              fontSize: "10",
              color: "rgba(0,0,0,0.7)",
            },
          },
          itemStyle: {
            normal: {
              borderColor: "rgba(0, 0, 0, 0.2)",
            },
            emphasis: { //高亮的显示设置
              areaColor: "skyblue", //鼠标选择区域颜色
              shadowOffsetX: 0,
              shadowOffsetY: 0,
              shadowBlur: 20,
              borderWidth: 0,
              shadowColor: "rgba(0, 0, 0, 0.5)",
            },
          },
        },
        // 鼠标悬浮提示框
        series: [
          {
            name: "省份",
            type: "map",
            geoIndex: 0,
            data: dataList,
          },
        ],
      };
      myChart.setOption(option);
    }
  },
};
</script>
