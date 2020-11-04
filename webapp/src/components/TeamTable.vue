<template>
  <div>
    <div v-if="isUser.right != 'employee'" class="team-table-component">
      <div class="team-list-container">
        <h3 class="title-team">TEAM LIST :</h3>
        <div>
          <ul class="team-list">
            <li
              v-for="team in teams"
              :key="team.id"
              :value="team.id"
              @click="showSpecificGraphic(team.id)"
              class="name-team"
            >
              {{ team.name }}
            </li>
          </ul>
        </div>
      </div>
      <div id="team-table">
        <md-table id="team-table-container" v-if="infos">
          <md-table-row>
            <md-table-head class="colum-container table-head-font"
              >Name</md-table-head
            >
            <md-table-head class="colum-container table-head-font"
              >Type</md-table-head
            >
            <md-table-head class="colum-container table-head-font"
              >Team</md-table-head
            >
          </md-table-row>

          <md-table-row
            v-for="(info, i) in infos"
            :key="info.id"
            class="table-row-container"
          >
            <md-table-cell
              v-if="info.status"
              v-bind:class="{ active: isInactive.includes(info.id) }"
              class="colum-container name-user table-cellule"
              ><p @click="showSpecificGraphic(info.id)">
                {{ info.firstname }} {{ info.lastname }}
              </p></md-table-cell
            >

            <div v-if="isUser.right != 'general manager'">
              <md-table-cell
                v-if="info.status"
                v-bind:class="{ active: isInactive.includes(info.id) }"
                class="colum-container table-cellule"
                >{{ info.right }}</md-table-cell
              >
            </div>

            <div v-if="isUser.right != 'manager'">
              <md-table-cell
                v-if="info.status"
                v-bind:class="{ active: isInactive.includes(info.id) }"
                class="colum-container table-cellule"
              >
                <md-field>
                  <label for="right">{{ infos[i].right }}</label>
                  <md-select
                    class="right"
                    name="right"
                    :id="info.id"
                    v-model="infos[i].right_id"
                    @md-selected="updateRight(infos[i].right_id, info)"
                    :key="info.id"
                  >
                    <md-option
                      v-for="right in rights"
                      :key="right.id"
                      :value="right.id"
                      class="colum-container"
                      >{{ right.name }}</md-option
                    >
                  </md-select>
                </md-field>
              </md-table-cell>
            </div>

            <md-table-cell
              v-if="info.status"
              v-bind:class="{ active: isInactive.includes(info.id) }"
              class="colum-container table-cellule"
            >
              <md-field>
                <label for="team">{{ info.team }}</label>
                <md-select
                  class="team"
                  name="team"
                  :id="info.id"
                  v-model="info[i]"
                  @md-selected="updateTeam(info[i], info)"
                  :key="info.id"
                >
                  <md-option
                    v-for="team in teams"
                    :key="team.id"
                    :value="team.id"
                    class="colum-container"
                    >{{ team.name }}</md-option
                  >
                </md-select>
              </md-field>
            </md-table-cell>

            <md-table-cell
              v-if="info.status"
              v-bind:class="{ active: isInactive.includes(info.id) }"
              class="colum-container table-cellule"
              ><button
                @click="
                  updateFalse(info),
                    isInactive.includes(info.id)
                      ? isInactive.splice(isInactive.indexOf(info.id), 1)
                      : isInactive.push(info.id)
                "
                class="btn-icon-corbeille"
              >
                <md-icon class="icon-corbeille">delete</md-icon>
              </button></md-table-cell
            >
          </md-table-row>
        </md-table>
        <md-snackbar :md-active.sync="actionMessage">
          {{ message }}</md-snackbar
        >
      </div>
    </div>
    <p>Team</p>
    <div>
      <ul class="team-list">
        <li
          v-for="team in teams"
          :key="team.id"
          :value="team.id"
          @click="showTeamChart(team.id)"
          class="name-team"
        >
          {{ team.name }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: "TeamTable",
  data: () => ({
    infos: null,
    email: null,
    firstname: null,
    lastname: null,
    status: null,
    team: null,
    id: null,
    right: null,
    teams: null,
    rights: null,
    isInactive: [],
    message: "",
    actionMessage: false,
    idGraphicToShow: null,
  }),

  computed: {
    isUser: function() {
      return this.$store.getters.isUser;
    },
    isTeam: function() {
      return this.$store.getters.isTeam;
    },
  },

  methods: {
    updateFalse: function(info) {
      this.$store
        .dispatch("updateuserstatus", { info })
        .then((response) => {
          if (response.status === 200) {
            this.message =
              "The user " +
              info.firstname +
              " " +
              info.lastname +
              " has successfully been deleted!";
            this.actionMessage = true;
          }
        })
        .catch(() => {
          this.message = "An error has occured, please try again";
          this.actionMessage = true;
        });
    },

    updateTeam: function(teamId, info) {
      this.$store
        .dispatch("updateuser", { teamId, info })
        .then((response) => {
          if (response.status === 200) {
            this.message =
              "The team of user " +
              info.firstname +
              " " +
              info.lastname +
              " has successfully been changed!";
            this.actionMessage = true;
          }
        })
        .catch(() => {
          this.message = "An error has occured, please try again";
          this.actionMessage = true;
        });
    },

    updateRight: function(rightId, info) {
      this.$store
        .dispatch("updateuserright", { rightId, info })
        .then((response) => {
          if (response.status === 200) {
            this.message =
              "The rights of user " +
              info.firstname +
              " " +
              info.lastname +
              " have successfully been changed!";
            this.actionMessage = true;
          }
        })
        .catch(() => {
          this.message = "An error has occured, please try again";
          this.actionMessage = true;
        });
    },

    showUserChart: function(id) {
      const user_id = id;
      this.$store.dispatch("getuserhours", { user_id });
    },
    showTeamChart: function(id) {
      const team_id = id;
      this.$store.dispatch("getteamhours", { team_id });
    },
  },

  mounted() {
    this.$store
      .dispatch("getallusers")
      .then((response) => {
        this.infos = response.data.data;
      })
      .catch((error) => console.log(error));

    this.$store
      .dispatch("getallteams")
      .then((response) => {
        this.teams = response.data.data;
      })
      .catch((error) => console.log(error));

    this.$store
      .dispatch("getallrights")
      .then((response) => {
        this.rights = response.data.data;
      })
      .catch((error) => console.log(error));
  },
};
</script>

<style>
#team-table {
  width: 100%;
  height: 70vh;
  overflow: hidden;
  overflow-y: scroll;
  margin-top: 5%;
}

.md-table-head .md-table-head-container {
  text-align: center;
}

.team-list {
  display: flex;
  justify-content: space-around;
  padding: 0;
}

.title-team {
  text-transform: capitalize;
}

.name-user,
.name-team {
  cursor: pointer;
  font-weight: bold;
}

.table-head-font {
  font-size: 18px;
}

.name-user:hover,
.name-team:hover {
  color: cornflowerblue;
}
.name-team:hover {
  font-style: italic;
}

.name-user:hover {
  font-size: 15px;
}

@media only screen and (max-width: 1433px) {
  .team-list-container {
    margin-top: 15vw;
  }
}

@media only screen and (max-width: 1280px) {
  .team-list-container {
    margin-top: 20vw;
  }
}
@media only screen and (max-width: 1200px) {
  .team-list-container {
    margin-top: 30vw;
  }
}
@media only screen and (max-width: 1000px) {
  .team-list-container {
    margin-top: 40vw;
  }
}

.active {
  display: none;
}
</style>
