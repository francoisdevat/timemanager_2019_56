<script>
import { Line } from "vue-chartjs";
export default {
  extends: Line,
  props: {
    chartData: {
      type: Array,
      required: false,
    },
    chartLabels: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      options: {
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true,
              },
              gridLines: {
                display: true,
              },
            },
          ],
          xAxes: [
            {
              gridLines: {
                display: false,
              },
            },
          ],
        },
        legend: {
          display: false,
        },
        responsive: true,
        maintainAspectRatio: false,
      },
    };
  },
  mounted() {
    this.renderChart(
      {
        labels: this.chartLabels,
        datasets: [
          {
            label: "hours worked",
            borderColor: "black",
            pointBackgroundColor: "black",
            borderWidth: 1,
            pointBorderColor: "black",
            backgroundColor: "cornflowerblue",
            data: this.chartData,
          },
        ],
      },
      this.options
    );
  },
};
</script>


<style>
#line-chart {
  height: 250px!important;
}
</style>