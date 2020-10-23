<template>
  <div class="tableau">
    <md-table md-card>
      <md-table-toolbar>
        <h1 class="md-title">Working times</h1>
      </md-table-toolbar>

      <md-table-row>
        <md-table-head>Start</md-table-head>
        <md-table-head>End</md-table-head>
        <md-table-head>Remove</md-table-head>
      </md-table-row>

      <md-table-row v-for="time in times" :key="time.id">
        <md-table-cell>{{
          time.start | moment("MM/DD/YYYY hh:mm")
        }}</md-table-cell>
        <md-table-cell>{{
          time.end | moment("MM/DD/YYYY hh:mm")
        }}</md-table-cell>
        <md-table-cell @click.native="remove(time.id)" class="active"
          ><md-icon>delete</md-icon></md-table-cell
        >
      </md-table-row>
    </md-table>
    <md-snackbar :md-active.sync="timeOff"
      >The working time has been successfully removed!</md-snackbar
    >
  </div>
</template>

<script>
import Axios from "axios";
const moment = require('moment')
export default {
  name: "WorkingTimes",
  data: () => ({
    times: [],
    id: null,
    hover: false,
    timeOff: false,
    responseStatus: null,
  }),
  methods: {
    moment: function() {
      return moment();
    },
    remove: async function(timeId) {
      await Axios.delete(
        "http://localhost:4000/api/workingtimes/" + timeId
      ).then((response) => (this.responseStatus = response.status));
      if (this.responseStatus === 204) {
        this.timeOff = true;
      }
    },
  },
  async mounted() {
    await Axios.get("http://localhost:4000/api/workingtimes").then(
      (response) => (this.times = response.data.data)
    );
  },
};
</script>
<style scoped>
.md-table-head {
  text-align: center;
}

.tableau {
  margin-left: 15%;
  margin-right: 15%;
}

.active {
  cursor: pointer;
}
</style>
