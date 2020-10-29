<script>
// import { Bar } from "vue-chartjs";
import { Line } from "vue-chartjs";
export default {
  // extends: Bar,
  extends: Line,
  props: {
    chartData: {
      type: Array,
      required: false,
      // default: function() {
      //   return {};
      // },
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
            borderColor: "#249EBF",
            pointBackgroundColor: "white",
            borderWidth: 1,
            pointBorderColor: "#249EBF",
            backgroundColor: "#448AFF",
            data: this.chartData,
          },
        ],
      },
      this.options
    );
  },
};
</script>
