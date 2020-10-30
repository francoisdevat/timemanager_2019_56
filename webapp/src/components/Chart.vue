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
      <div id="select-date">
          <div>
            <md-datepicker v-model="selectedDateStart" md-immediately>
              <label>Select date start</label>
            </md-datepicker>
          </div>
          <div>
            <md-datepicker v-model="selectedDateEnd" md-immediately>
              <label>Select date end</label>
            </md-datepicker>
          </div>
          <md-button class="md-dense md-primary btn-show" @click="(selectDate(selectedDateStart, selectedDateEnd))" >Show</md-button>
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
          <!-- <bar-chart
            v-if="loaded"
            :chart-data="hours"
            :chart-labels="labels"
          ></bar-chart> -->
        </div>
      </div>
    </div>
  </div>
</template>


<script>
// import axios from "axios";
// import BarChart from "./LineChart";
import LineChart from "./LineChart";
const moment = require("moment");


export default {
  components: {
    // BarChart,
    LineChart,
  },

  props: {},
  data() {
    return {
      selectedDate: null,
      packages: null,
      packageName: "",
      period: "last-month",
      loaded: false,
      hours: [],
      labels: [],
      showError: false,
      errorMessage: "Please enter a package name",
      starttime: null,
      endtime: null,
      apiurl: "http://localhost:4000/api/hours",
    };
  },


  mounted() {
    // on selectdate
    //   this.starttime = this.$route.params.start;
    //   this.endtime = this.$route.params.end;
    // if (props.starttime && props.endtime) {
    //   this.apiurl = `http://localhost:4000/api/hour?start=${props.starttime}T00:00:00&end=${props.endtime}T00:00:00`;
    //   this.requestData();
    // }
    // if (props.userId) {
    //   this.apiurl = `http://localhost:4000/api/myhours/${props.userId}`;
    //   this.requestData();
    // }
    // if (props.teamId) {
    //   this.apiurl = `http://localhost:4000/api/myteamhours/${props.teamId}`;
    //   this.requestData();
    // }

    this.requestData();
  },


  methods: {

    resetState() {
      this.loaded = false;
      this.showError = false;
    },

    selectDate(selectedDateStart, selectedDateEnd){
        if(selectedDateStart && selectedDateEnd && selectedDateStart < selectedDateEnd) {
            selectedDateStart = moment(selectedDateStart).format("YYYY-MM-DD") + "T00:00:00"
            selectedDateEnd = moment(selectedDateEnd).format("YYYY-MM-DD") + "T00:00:00"
            console.log(selectedDateStart, " " ,selectedDateEnd)
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
          this.setURL();
          this.loaded = true;
        })
        .catch((error) => console.log(error));

      // axios
      //   .get(this.apiurl)
      //   .then((response) => {
      //     this.hours = response.data.data.map(
      //       (time) =>
      //         moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
      //     );
      //     this.labels = response.data.data.map((hour) =>
      //       moment(hour.end).format("DD MM YYYY")
      //     );
      //     // this.packageName = response.data.package;
      //     this.setURL();
      //     this.loaded = true;
      //   })
      //   .catch((err) => {
      //     this.errorMessage = err.response.data.error;
      //     this.showError = true;
      //   });
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


<style>

#select-date {
  display: flex;
  justify-content: space-between;
}

.btn-show {
  margin-top: 3%;
}

</style>