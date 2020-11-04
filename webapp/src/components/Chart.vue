<template>
  <div class="content">
    <div class="container">
      <div id="select-date">
        <div>
          <md-datepicker v-model="selectedDateStart" md-immediately>
            <label>Select start date</label>
          </md-datepicker>
        </div>
        <div>
          <md-datepicker v-model="selectedDateEnd" md-immediately>
            <label>Select end date</label>
          </md-datepicker>
        </div>
        <md-button
          class="md-dense md-primary btn-show"
          @click="selectDate(selectedDateStart, selectedDateEnd)"
          >Show</md-button
        >
      </div>

      <div class="Chart__container" v-if="loaded">
        <div class="Chart__title">
          Actual working hours
          <hr />
        </div>
        <div class="Chart__content">
          <line-chart
            :key="chartKey"
            v-if="loaded"
            :chart-data="hours"
            :chart-labels="labels"
          ></line-chart>
        </div>
      </div>
    </div>
    <md-snackbar :md-active.sync="actionMessageHours">
      {{ message }}</md-snackbar
    >
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
      selectedDateStart: null,
      selectedDateEnd: null,
      message: "",
      actionMessageHours: false,
      chartKey: 0,
    };
  },
  mounted() {
    this.requestData();
  },
  computed: {
    isUserHours: function() {
      return this.$store.getters.isUserHours;
    },
    isTeamHours: function() {
      return this.$store.getters.isTeamHours;
    },
  },
  watch: {
    isUserHours: function() {
      this.userChart();
    },
    isTeamHours: function() {
      this.teamChart();
    },
  },
  methods: {
    forceRerender() {
      this.chartKey += 1;
    },
    resetState() {
      this.loaded = false;
    },
    userChart() {
      this.forceRerender();
      this.resetState();
      if (this.isUserHours.data.length > 0) {
        this.hours = this.isUserHours.data.map(
          (time) => moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
        );
        this.labels = this.isUserHours.data.map((hour) =>
          moment(hour.end).format("MM-DD")
        );
      } else {
        this.message = "This user doesn't have any working hours";
        this.actionMessageHours = true;
      }
      this.loaded = true;
    },
    teamChart() {
      this.forceRerender();
      this.resetState();
      if (this.isTeamHours.data.length > 0) {
        this.hours = this.isTeamHours.data.map(
          (time) => moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
        );
        this.labels = this.isTeamHours.data.map((hour) =>
          moment(hour.end).format("MM-DD")
        );
      } else {
        this.message = "This team doesn't have any working hours";
        this.actionMessageHours = true;
      }
      this.loaded = true;
    },
    selectDate(selectedDateStart, selectedDateEnd) {
      if (
        selectedDateStart &&
        selectedDateEnd &&
        selectedDateStart < selectedDateEnd
      ) {
        let start =
          moment(selectedDateStart).format("YYYY-MM-DD") + "T00:00:00";
        let end = moment(selectedDateEnd).format("YYYY-MM-DD") + "T23:59:00";

        this.resetState();
        this.$store
          .dispatch("getspecifichours", { start, end })
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
      } else {
        this.message = "Please, select a correct date.";
        this.actionMessageHours = true;
      }
    },
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
  },
};
</script>

<style>
#select-date {
  display: flex;
  justify-content: space-between;
  margin-left: 10%;
}

.content {
  margin-top : 10%;
  max-height: 25vw;
}

.btn-show {
  margin-top: 3%;
}
</style>
