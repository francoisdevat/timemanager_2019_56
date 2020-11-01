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
