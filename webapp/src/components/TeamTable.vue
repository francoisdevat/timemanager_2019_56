<template>
  <div id="team-table">
    <md-table v-if="infos">
      <md-table-row>
        <md-table-head class="colum-container">Name</md-table-head>
        <md-table-head class="colum-container">Type</md-table-head>
        <md-table-head class="colum-container">Team</md-table-head>
      </md-table-row>
      <!-- <md-table-row v-for="(info, info.status) in infos" v-if="info.status=true" > -->

      <md-table-row v-for="(info, i) in infos" :key="info.id">
        <md-table-cell
          v-if="info.status"
          v-bind:class="{ active: isInactive.includes(info.id) }"
          class="colum-container"
          >{{ info.firstname }} {{ info.lastname }}</md-table-cell
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
              @md-selected="updateTeam(info[i], info.id)"
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
  </div>
</template>

<script>
import Axios from "axios";

// on push dans un tableau les info.id qui on été cliqué pour le display none afin de les garder en display none apres un clique sur une autre ligne

var infos = [];
for (var i = 1; i <= 10; i++) {
  infos.push({
    id: i,
  });
}

export default {
  name: "TeamTable",
  data: () => ({
    infos: [],
    email: null,
    firstname: null,
    lastname: null,
    status: null,
    team: null,
    id: null,
    type: null,
    teams: [],
    isInactive: [],
    test: {},
    teamSelected: null,
    // user: this.$store.getters.user
  }),

  methods: {
    updateFalse: function(info) {
      const id = info.id;
      try {
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
          .then(function(response) {
            console.log(response);
          })
          .catch(function(error) {
            console.log(error);
          });
      } catch (error) {
        console.log(error);
      }
    },
    // fonction qui remet le "status" d'un user en true pour l'afficher dans la liste nécéssite la tab de l'user
    updateTeam: function(info, infoId) {
      console.log(info, infoId);
      // this.test = info;
      //   try {

      //   Axios
      //     .get('http://localhost:4000/api/teams/' + teamId)
      //     .then(response => (this.teamName = response.data.data.name))

      //   Axios
      //     .put('http://localhost:4000/api/users/'+ id, {
      //       user : {
      //         email: info.email,
      //         firstname: info.firstname,
      //         lastname: info.lastname,
      //         password: info.password_hash,
      //         status: info.status,
      //         team_id: teamId,
      //         type: info.type,
      //         team: teamName
      //       }
      //     })
      //     .then(function (response) {
      //       console.log(response, "yes");
      //     })
      //     .catch(function (error) {
      //       console.log(error);
      //     });
      //   } catch (error) {
      //     console.log(error)
      //   }
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
  overflow: hidden;
  overflow-y: scroll;
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
  padding-left: 10px;
}

.team {
  width: 3vw;
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
