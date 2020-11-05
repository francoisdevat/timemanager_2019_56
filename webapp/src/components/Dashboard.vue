<template>
  <div class="container-large">
    <div class="large">
      <md-button
        v-bind:class="clockstatus ? 'md-raised red' : 'md-raised md-primary'"
        @click.native="pickdate"
        >{{ clockTitle }}</md-button
      >
      <div v-if="clocktime">
        <md-button v-if="clockstatus" class="button"
          >You clocked in on
          {{ clocktime | moment("MM/DD/YYYY hh:mm") }}</md-button
        >
        <md-button v-if="!clockstatus" class="button"
          >You clocked out on
          {{ clocktime | moment("MM/DD/YYYY hh:mm") }}</md-button
        >
      </div>
    </div>
    <div class="md-layout">
      <div class="md-layout-item">
        <h3>CHART</h3>
        <div v-if="isUser.right === 'employee'"><ChartUser /></div>
        <div v-if="isUser.right !== 'employee'"><Chart /><ChartUser /></div>
      </div>
      <div v-if="isUser.right !== 'employee'" class="md-layout-item">
        <TeamTable />
      </div>
    </div>
    <md-snackbar :md-active.sync="error"
      >An error occured, please try again later</md-snackbar
    >
  </div>
</template>

<script>
import Chart from "./Chart";
import ChartUser from "./ChartUser";
import TeamTable from "./TeamTable";
const moment = require("moment");

export default {
  components: {
    Chart,
    ChartUser,
    TeamTable,
  },

  name: "Dashboard",
  data: () => ({
    clocked: null,
    clockTitle: null,
    clocktime: null,
    clockstatus: false,
    error: false,
    user: null,
  }),
  computed: {
    isUser: function() {
      return this.$store.getters.isUser;
    },
  },
  mounted() {
    if (localStorage.getItem("token")) {
      this.$store.dispatch("getuser").then((response) => {
        this.user = response;
        this.$store
          .dispatch("lastclock", this.user.id)
          .then((resp) => {
            if (resp.data.data.user_id) {
              this.clocktime = resp.data.data.time;
              this.clockstatus = resp.data.data.status;
              if (resp.data.data.status) {
                this.clockTitle = "Clock out";
              } else {
                this.clockTitle = "Clock in";
              }
            } else {
              this.clockTitle = "Clock in";
            }
          })
          .catch(() => {
            this.clockTitle = "Clock in";
            this.clockstatus = false;
          });
      });
    }
  },
  methods: {
    moment: function() {
      return moment();
    },
    pickdate: function() {
      const user_id = this.user.id;
      let status;
      let start;
      const time = moment().format("YYYY-MM-DD" + "T" + "HH:mm:ss");
      const team_id = this.user.team_id;

      this.$store
        .dispatch("lastclock", user_id)
        .then((response) => {
          if (response.data.data.user_id) {
            start = response.data.data.time;
            status = !response.data.data.status;

            this.$store
              .dispatch("clockin", { user_id, time, status })
              .then((resp) => {
                this.status = resp.data.status;
                this.clocktime = resp.data.time;
                this.clockstatus = !this.clockstatus;
                if (status) {
                  this.clockTitle = "Clock out";
                }

                if (!status) {
                  this.$store
                    .dispatch("posthour", { start, time, user_id, team_id })
                    .catch(() => (this.error = true));
                }
              })
              .catch(() => (this.error = true));
          }
        })
        .catch(() => (this.error = true));
    },
  },
};
</script>

<style scoped>
.btn-color {
  color: white !important;
  background-color: Green !important;
  width: 95px;
  height: 80px;
}

.red {
  background-color: red !important;
  color: white !important;
}
.large {
  display: flex;
  justify-content: center;
}
.button {
  cursor: none;
}
</style>
