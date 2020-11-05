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
          Your average work time : {{avg}} hours
          <hr />
        </div>
        <div class="Chart__content">
          <bar-chart
            v-if="loaded"
            :chart-data="hours"
            :chart-labels="labels"
          ></bar-chart>
        </div>
      </div>
    </div>
    <md-snackbar :md-active.sync="actionMessageHours">
      {{ message }}</md-snackbar
    >
  </div>
</template>

<script>
import BarChart from "./BarChart";
const moment = require("moment");

export default {
  components: {
    BarChart,
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
      avg : null,
    };
  },
  computed: {
    isUserHours: function() {
      return this.$store.getters.isUserHours;
    },
    isTeamHours: function() {
      return this.$store.getters.isTeamHours;
    },
    isUser: function() {
      return this.$store.getters.isUser;
    },
  },
  mounted() {
    this.requestData();
  },
  watch: {
    // isUserHours: function() {
    //   this.userChart();
    // },
    isUser: function() {
      this.requestData();
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
            var i = 0;
            var moyenne = 0
            while(i != this.hours.length){
              moyenne = moyenne + this.hours[i]
              i++
            }
          this.avg = Math.round((moyenne / i) * 100) / 100
            this.labels = response.data.data.map((hour) =>
              moment(hour.end).format("MM-DD")
            );
            this.loaded = true;
          })
          .catch((error) => {
            console.log(error);
            this.message = "An error occured, please try again later";
            this.actionMessageHours = true;
          })
      } else {
        this.message = "Please, select a correct date.";
        this.actionMessageHours = true;
      }
    },
    requestData() {
      this.resetState();
      if (this.isUser.id) {
        const user_id = this.isUser.id;
        this.$store
          .dispatch("getuserhours", {user_id})
          .then((response) => {
            this.hours = response.data.data.map(
              (time) =>
                moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
            );
            var i = 0;
              var moyenne = 0
              while(i != this.hours.length){
                moyenne = moyenne + this.hours[i]
                i++
              }
            this.avg = Math.round((moyenne / i) * 100) / 100
            this.labels = response.data.data.map((hour) =>
              moment(hour.end).format("MM-DD")
            );
            this.loaded = true;
          })
          .catch((error) => {
            console.log(error);
            this.message = "An error occured, please try again later";
            this.actionMessageHours = true;
          })
          
      }
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
  margin-top : 1%;
}

.btn-show {
  margin-top: 3%;
}
</style>
