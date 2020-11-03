<template>
  <div class="container-large">
    <div class="large">

      <md-button class="md-raised md-primary" @click.native="pickdate">{{
        clockTitle
      }}</md-button>
      <md-content v-if="this.isLastClock.status" class="md-elevation-10"
        >You clocked in on
        {{ this.isLastClock.time | moment("MM/DD/YYYY hh:mm") }}</md-content
      >
      <md-content v-if="!this.isLastClock.status" class="md-elevation-10"
        >You clocked out on
        {{ this.isLastClock.time | moment("MM/DD/YYYY hh:mm") }}</md-content
      >
    </div>
    <div class="md-layout">
      <div class="md-layout-item">
        <Chart />
      </div>
      <div class="md-layout-item"><TeamTable /></div>
    </div>
  </div>
</template>

<script>
import Chart from "./Chart";
import TeamTable from "./TeamTable";

const moment = require("moment");

export default {

  components: {
    Chart,
    TeamTable,
  },

  name: "Dashboard",
  data: () => ({
    selectedDate: "",
    clocked: null,
    clockTitle: null,
  }),
  computed: {
    isUser: function() {
      return this.$store.getters.isUser;
    },
    isLastClock: function() {
      return this.$store.getters.isLastClock;
    },
  },
  mounted() {
    this.clocked = this.isLastClock.status;
    this.selectedDate = this.isLastClock.time;
    console.log(this.isLastClock.time);
    console.log(this.isLastClock.status);
    if (this.isLastClock.status) {
      this.clockTitle = "Clock out";
    } else {
      this.clockTitle = "Clock in";
    }
  },

  methods: {

    moment: function() {
      return moment();
    },

    pickdate: function() {
      console.log(this.isLastClock.status);
      this.selectedDate = moment();

      const user_id = this.isUser.id;
      const status = !this.isLastClock.status;
      const time = moment().format("YYYY-MM-DD" + "T" + "HH:mm:ss");
      if (status) {
        this.clockTitle = "Clock out";
      } else {
        this.clockTitle = "Clock in";
      }
      this.$store
        .dispatch("clockin", { user_id, time, status })
        .then((response) => {
          this.clocked = response.data.status;
          this.selectedDate = response.data.time;
        })
        .catch((error) => console.log(error));
    },
  },
};
</script>


<style scoped>

.container-large {
  position: relative;
}

.btn-color {
  color: white!important;
  background-color: Green!important;
  width: 95px;
  height: 80px;
}

.large {
    position: absolute;
    left: 60%;
    top: -6%;
    transform: translateX(-50%);
}

.red {
  background-color: red !important;
  color: white !important;
}

</style>
