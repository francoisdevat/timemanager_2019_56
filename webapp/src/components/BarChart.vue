<script>
import { Bar } from "vue-chartjs";
// import Axios from "axios";

export default {
  extends: Bar,
  data() {
    return {
    //   chartDonnees: [],
      chartData: {
        labels: [
          "1 week",
          "2 Weeks",
          "3 weeks",
          "4 weeks",
          "5 weeks",
          "6 weeks",
          "7 weeks",
          "8 weeks",
          "9 weeks",
          "10 weeks",
          "11 weeks",
          "12 weeks",
        ],
        datasets: [
          {
            label: "Heures effectuées",
            borderWidth: 1,
            backgroundColor: [
              "rgba(255, 99, 132, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(255, 206, 86, 0.2)",
              "rgba(75, 192, 192, 0.2)",
              "rgba(153, 102, 255, 0.2)",
              "rgba(255, 159, 64, 0.2)",
              "rgba(255, 99, 132, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(255, 206, 86, 0.2)",
              "rgba(75, 192, 192, 0.2)",
              "rgba(153, 102, 255, 0.2)",
              "rgba(255, 159, 64, 0.2)",
            ],
            borderColor: [
              "rgba(255,99,132,1)",
              "rgba(54, 162, 235, 1)",
              "rgba(255, 206, 86, 1)",
              "rgba(75, 192, 192, 1)",
              "rgba(153, 102, 255, 1)",
              "rgba(255, 159, 64, 1)",
              "rgba(255,99,132,1)",
              "rgba(54, 162, 235, 1)",
              "rgba(255, 206, 86, 1)",
              "rgba(75, 192, 192, 1)",
              "rgba(153, 102, 255, 1)",
              "rgba(255, 159, 64, 1)",
            ],
            pointBorderColor: "#2554FF",
            data: [12, 19, 3, 5, 2, 3, 20, 3, 5, 6, 2, 1],
          },
        ],
      },
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
          display: true,
        },
        responsive: true,
        maintainAspectRatio: false,
      },
    };
  },
  methods: {
    randomize: function() {
      const random = Math.floor(Math.random() * 2 ** 24)
        .toString(16)
        .padStart(6, "0");
      return "#" + random;
    },
  },
  async mounted() {
    this.renderChart(this.chartData, this.options);
    // await Axios.get("http://localhost:4000/api/workingtimes").then(
    //   (response) => {
    //     // response.data.data = this.chartDonnees;
    //     console.log(response.data.data)
    //   }
    // );
  },
};
</script>
