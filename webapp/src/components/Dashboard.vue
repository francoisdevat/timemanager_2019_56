<template>
  <div class="container-large">
    <div class="large">
      <md-button
        v-bind:class="clockstatus ? 'md-raised red' : 'md-raised md-primary'"
        @click.native="pickdate"
        >{{ clockTitle }}</md-button
      >
      <div v-if="time">
        <md-content v-if="clockstatus" class="md-elevation-10"
          >You clocked in on {{ time | moment("MM/DD/YYYY hh:mm") }}</md-content
        >
        <md-content v-if="!clockstatus" class="md-elevation-10"
          >You clocked out on
          {{ time | moment("MM/DD/YYYY hh:mm") }}</md-content
        >
      </div>
    </div>
    <div class="md-layout">
      <div class="md-layout-item">
        <h3>CHART</h3>
        <Chart />
        <ChartUser />
      </div>
      <div class="md-layout-item"><TeamTable /></div>
    </div>
  </div>
</template>

<script>
import Chart from "./Chart";
import ChartUser from "./ChartUser";
import TeamTable from "./TeamTable";

const moment = require("moment");

export default {
  components: {
    Chart,
    ChartUser,
    TeamTable,
  },

  name: "Dashboard",
  data: () => ({
    clocked: null,
    clockTitle: null,
    time: null,
    clockstatus: null,
  }),
  computed: {
    isUser: function() {
      return this.$store.getters.isUser;
    },
  },
  mounted() {
    const user_id = this.isUser.id;
    if (user_id) {
      this.$store
        .dispatch("lastclock", user_id)
        .then((response) => {
          if (response.data.length > 0) {
            this.time = response.data.data.time;
            this.clockstatus = response.data.data.status;
            if (response.data.data.status) {
              this.clockTitle = "Clock out";
            } else {
              this.clockTitle = "Clock in";
            }
          } else {
            this.clockTitle = "Clock in";
          }
        })
        .catch((error) => {
          console.log(error);
          // gestion de l'erreur
        });
    }
  },
  methods: {
    moment: function() {
      return moment();
    },
    pickdate: function() {
      const user_id = this.isUser.id;
      console.log(this.clockstatus);
      const status = !this.clockstatus;
      const time = moment().format("YYYY-MM-DD" + "T" + "HH:mm:ss");
      if (status) {
        this.clockTitle = "Clock out";
      } else {
        this.clockTitle = "Clock in";
      }
      this.$store
        .dispatch("clockin", { user_id, time, status })
        .then((response) => {
          this.status = response.data.status;
          this.time = response.data.time;
        })
        .catch((error) => {
          console.log(error);
          //gestion erreur
        });
    },
  },
};
</script>

<style scoped>

.btn-color {
  color: white !important;
  background-color: Green !important;
  width: 95px;
  height: 80px;
}

.red {
  background-color: red !important;
  color: white !important;
}

</style>
