<template>
  <div class="content">
    <div class="container">
      <div>
        <md-datepicker v-model="selectedDate">
          <label>Select date</label>
        </md-datepicker>
      </div>
      <div class="Chart__container" v-if="loaded">
        <div class="Chart__title">
          Working time
          <hr />
        </div>
        <div class="Chart__content">
          <line-chart
            v-if="loaded"
            :chart-data="hours"
            :chart-labels="labels"
          ></line-chart>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import LineChart from "./LineChart";
const moment = require("moment");
export default {
  components: {
    LineChart,
  },
  props: {},
  data() {
    return {
      selectedDate: null,
      loaded: false,
      hours: [],
      labels: [],
      starttime: null,
      endtime: null,
    };
  },
  mounted() {
    this.requestData();
  },
  computed: {
    isUser: function() {
      return this.$store.getters.isUser;
    },
  },
  methods: {
    resetState() {
      this.loaded = false;
    },
    /* Tous les horaires */
    requestData() {
      this.resetState();

      this.$store
        .dispatch("getallhours")
        .then((response) => {
          this.hours = response.data.data.map(
            (time) =>
              moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
          );
          this.labels = response.data.data.map((hour) =>
            moment(hour.end).format("MM-DD")
          );
          this.loaded = true;
        })
        .catch((error) => console.log(error));
    },
    /* Tous les horaires d'un utilisateur */
    requestUserData() {
      this.resetState();
      let user_id = this.isUser.id;
      this.$store
        .dispatch("getuserhours", { user_id })
        .then((response) => {
          this.hours = response.data.data.map(
            (time) =>
              moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
          );
          this.labels = response.data.data.map((hour) =>
            moment(hour.end).format("MM-DD")
          );
          this.loaded = true;
        })
        .catch((error) => console.log(error));
    },
    /* Tous les horaires d'une team */
    requestTeamData() {
      this.resetState();
      let team_id = this.isUser.team_id
      this.$store
        .dispatch("getteamhours", { team_id })
        .then((response) => {
          this.hours = response.data.data.map(
            (time) =>
              moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
          );
          this.labels = response.data.data.map((hour) =>
            moment(hour.end).format("MM-DD")
          );
          this.loaded = true;
        })
        .catch((error) => console.log(error));
    },
    /* Tous les horaires par date */
    requestHourData() {
      this.resetState();
      let starttime = this.starttime
      let endtime = this.endtime
      this.$store
        .dispatch("getspecifichours", { starttime, endtime })
        .then((response) => {
          this.hours = response.data.data.map(
            (time) =>
              moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
          );
          this.labels = response.data.data.map((hour) =>
            moment(hour.end).format("MM-DD")
          );
          this.loaded = true;
        })
        .catch((error) => console.log(error));
    },
  },
};
</script>
