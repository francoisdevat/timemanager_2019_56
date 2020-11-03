<template>
  <div>
    <div id="team-table">
      <md-table id="team-table-container" v-if="infos">
        <md-table-row>
          <md-table-head class="colum-container">Name</md-table-head>
          <md-table-head class="colum-container">Type</md-table-head>
          <md-table-head class="colum-container">Team</md-table-head>
        </md-table-row>

        <md-table-row v-for="(info, i) in infos" :key="info.id">
          <md-table-cell
            v-if="info.status"
            v-bind:class="{ active: isInactive.includes(info.id) }"
            class="colum-container name-user"
            ><p @click="showSpecificGraphic(info.id)">
              {{ info.firstname }} {{ info.lastname }}
            </p></md-table-cell
          >
          <md-table-cell
            v-if="info.status"
            v-bind:class="{ active: isInactive.includes(info.id) }"
            class="colum-container"
            >{{ info.type }}</md-table-cell
          >
          <md-table-cell
            v-if="info.status"
            v-bind:class="{ active: isInactive.includes(info.id) }"
            class="colum-container"
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
            class="colum-container"
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
      <md-snackbar :md-active.sync="actionMessage"> {{ message }}</md-snackbar>
    </div>
    <p>Team</p>
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
</template>

<script>
import Axios from "axios";

// on push dans un tableau les info.id qui on été cliqué pour le display none afin de les garder en display none apres un clique sur une autre ligne

// var tabTeam = [];
// for (var i = 1; i <= 10; i++) {
//   tabTeam.push({
//     id: i,
//   });
// }

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
    type: null,
    teams: null,
    isInactive: [],
    message: "",
    actionMessage: false,
    idGraphicToShow: null,
  }),

  methods: {
    updateFalse: function(info) {
      const id = info.id;
      Axios.put("http://localhost:4000/api/users/" + id, {
        user: {
          email: info.email,
          firstname: info.firstname,
          lastname: info.lastname,
          password: info.password_hash,
          status: false,
          team_id: info.team_id,
          type: info.type,
          team: info.team,
        },
      })
        .then((response) => {
          if (response.status === 200) {
            this.message =
              "The user " +
              info.firstname +
              " " +
              info.lastname +
              " has successfully been delete!";
            this.actionMessage = true;
          }
        })
        .catch(() => {
          this.message = "An error has occured, please try again";
          this.actionMessage = true;
        });
    },

    updateTeam: function(teamId, info) {
      Axios.get("http://localhost:4000/api/teams/" + teamId).then(
        (response) => (this.teamName = response.data.data.name)
      );

      Axios.put("http://localhost:4000/api/users/" + info.id, {
        user: {
          email: info.email,
          firstname: info.firstname,
          lastname: info.lastname,
          password: info.password_hash,
          status: info.status,
          team_id: teamId,
          type: info.type,
          team: this.teamName,
        },
      })
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

    showSpecificGraphic: function(id) {
      const user_id = id;
      this.$store.dispatch("getuserhours", { user_id });
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
  },
};
</script>

<style>
#team-table {
  width: 30vw;
  height: 70vh;
  overflow: hidden;
  overflow-y: scroll;
}

.md-layout-item {
  display: flex;
  justify-content: flex-end;
}

#team-table-container {
  max-width: 30vw;
  overflow: hidden;
}

.colum-container {
  padding: 0;
}

.md-table-head .md-table-head-container {
  text-align: center;
}

.md-table-cell:last-child,
.md-table-cell-container,
.md-content {
  padding-right: 0;
  padding-left: 0;
}

.team {
  width: 3vw;
}

.team-list {
  display: flex;
  justify-content: space-around;
  padding: 0;
}

.name-user,
.name-team {
  cursor: pointer;
}

.md-list-item-content {
  min-height: 0;
}

.md-menu-content {
  max-width: 165px;
}

.icon-corbeille:hover {
  cursor: pointer;
}

.btn-icon-corbeille {
  border: initial;
  background: initial;
}

.md-menu.md-select:not(.md-disabled) .md-icon {
  display: none;
}

.active {
  display: none;
}
</style>
