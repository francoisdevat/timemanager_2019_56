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
        <md-snackbar :md-active.sync="actionMessageHours"> {{message}}</md-snackbar>
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
      loaded: false,
      hours: [],
      labels: [],
      selectedDateStart: null,
      selectedDateEnd: null,
      apiurl: "http://localhost:4000/api/hours",
      message: "",
      actionMessageHours: false
    };
  },


  mounted() {
    this.requestData();
  },

  computed: {
      isSpecificHours: function() {
        return this.$store.getters.isSpecificHours;
      },
  },



  methods: {

    resetState() {
      this.loaded = false;
      this.showError = false;
    },

    selectDate(selectedDateStart, selectedDateEnd){
        if(selectedDateStart && selectedDateEnd && selectedDateStart < selectedDateEnd) {
          let start =selectedDateStart = moment(selectedDateStart).format("YYYY-MM-DD") + "T00:00:00"
          let end = selectedDateEnd = moment(selectedDateEnd).format("YYYY-MM-DD") + "T00:00:00"

          this.resetState();
          this.$store
          .dispatch("getspecifichours", {start, end})
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
        }
        else{
          this.message = "Please, select a correct date." 
          this.actionMessageHours = true
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

      if (this.isSpecificHours.length > 0) {
        this.hours = this.isSpecificHours.map(
          (time) => moment(time.end).diff(moment(time.start)) / (1000 * 60 * 60)
        );
        this.labels = this.isSpecificHours.map((hour) =>
          moment(hour.end).format("MM-DD")
        );
        this.loaded = true;
      }

    },

  }
}

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