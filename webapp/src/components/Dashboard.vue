<template>
  <div>
    <div class="large">
      <md-button
        v-if="!pointed"
        class="md-raised md-primary"
        @click.native="pickdate"
        >Clock in</md-button
      >
      <md-button v-if="pointed" class="md-raised red" @click.native="pickdate"
        >Clock out</md-button
      >
      <md-content v-if="pointed" class="md-elevation-10"
        >You clocked in on
        {{ selectedDate | moment("MM/DD/YYYY hh:mm") }}</md-content
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
// import Axios from "axios";
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
    pointed: false,
  }),
  methods: {
    moment: function() {
      return moment();
    },
    pickdate: function() {
      this.selectedDate = new Date();
      this.pointed = true;
      // Axios.post("http://localhost:4000/api/clocks/", {
      //   clock: {
      //     status: true,
      //     time: new Date().toLocaleString(),
      //     user_id: 1,
      //   },
      // })
      //   .then((response) => {
      //     if (response.status === 200) {
      //       this.selectedDate = new Date().toLocaleString();
      //       this.pointed = true;
      //     } else {
      //       //handle error
      //     }
      //   })
      //   .catch((error) => console.log(error));
    },
  },
  async mounted() {
    // console.log(this.$store.getters.user);
    // if (!this.$store.getters.user) {
    //   this.$router.push("login");
    // }
  },
};
</script>
<style scoped>
.large {
  margin-left: 15%;
  margin-right: 15%;
}
.red {
  background-color: red !important;
  color: white !important;
}
.test {
  display: flex;
}
</style>
