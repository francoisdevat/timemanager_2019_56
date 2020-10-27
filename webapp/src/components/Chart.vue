<template>
  <div class="content">
    <div class="container">
      <!-- <div class="Search__container">
        <input
          class="Search__input"
          @keyup.enter="requestData"
          placeholder="npm package name"
          type="search"
          name="search"
          v-model="packages"
        />
        <button class="Search__button" @click="requestData">Find</button>
      </div> -->
      <!-- <div class="error-message" v-if="showError">
        {{ errorMessage }}
      </div>
      <hr />
      <h1 class="title" v-if="loaded">{{ packageName }}</h1> -->
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
            :chart-data="downloads"
            :chart-labels="labels"
          ></line-chart>
          <!-- <bar-chart
            v-if="loaded"
            :chart-data="downloads"
            :chart-labels="labels"
          ></bar-chart> -->
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
// import BarChart from "./LineChart";
import LineChart from "./LineChart";
const moment = require("moment");
export default {
  components: {
    // BarChart,
    LineChart
  },
  props: {},
  data() {
    return {
      selectedDate: null,
      packages: null,
      packageName: "",
      period: "last-month",
      loaded: false,
      downloads: [],
      labels: [],
      showError: false,
      errorMessage: "Please enter a package name",
      starttime: null,
      endtime: null,
    };
  },
  mounted() {
    if (this.$route.params.start) {
      this.starttime = this.$route.params.start;
      this.endtime = this.$route.params.end;
    } else {
      this.requestData();
    }
  },
  methods: {
    resetState() {
      this.loaded = false;
      this.showError = false;
    },
    requestData() {
      // if (
      //   this.packages === null ||
      //   this.packages === "" ||
      //   this.packages === "undefined"
      // ) {
      //   this.showError = true;
      //   return;
      // }
      this.resetState();
      axios
        .get(
          // `https://api.npmjs.org/downloads/range/${this.period}/${this.packages}`
          "http://localhost:4000/api/hours"
        )
        .then((response) => {
          console.log(response.data.data);
          this.downloads = response.data.data.map(
            (time) =>
              moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
          );
          this.labels = response.data.data.map((hour) =>
            moment(hour.end).format("DD MM YYYY")
          );
          // this.packageName = response.data.package;
          this.setURL();
          this.loaded = true;
        })
        .catch((err) => {
          this.errorMessage = err.response.data.error;
          this.showError = true;
        });
    },
    setURL() {
      history.pushState(
        { info: `npm-stats ${this.packages}` },
        this.packages,
        `/#/${this.packages}`
      );
    },
  },
};
</script>
