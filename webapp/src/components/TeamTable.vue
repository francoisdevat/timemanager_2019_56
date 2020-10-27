<template>
  <div id="team-table">
    <md-table v-if="infos">
      <md-table-row>
          <md-table-head class="colum-container" >Name</md-table-head>
          <md-table-head class="colum-container" >Type</md-table-head>
          <md-table-head class="colum-container" >Team</md-table-head>
      </md-table-row>

      <md-table-row v-for="info in infos" :key="info.id">
          <md-table-cell class="colum-container" >{{info.firstname}} {{info.lastname}}</md-table-cell>
          <md-table-cell class="colum-container" >{{info.type}}</md-table-cell>
          <md-table-cell class="colum-container" ><md-field>
             <label for="team">{{info.team}}</label>
                <md-select class="team" name="team" id="team">
                     <md-option v-for="team in teams" :key="team.id" value="team" class="colum-container" >{{team.name}}</md-option>
                </md-select>
              </md-field>
          </md-table-cell>
          <md-table-cell class="colum-container" ><button v-on:click="updateFalse(info)" class="btn-icon-corbeille" ><md-icon class="icon-corbeille">delete</md-icon></button></md-table-cell>
      </md-table-row>
    </md-table>
  </div>
</template>

<script>
import Axios from "axios"
  export default {
    name: 'TeamTable',
    data: () => ({
      infos: null,
      email: null,
      firstname: null,
      lastname: null,
      status: null,
      team: null,
      id: null,
      type:null,
      teams: null,
    }),

    methods : {
        updateFalse: function (info) {
          const id= info.id
          try {
          Axios
            .put('http://localhost:4000/api/users/'+ id, {
              user : {
                email: info.email,
                firstname: info.firstname,
                lastname: info.lastname,
                password: info.password_hash, 
                status: false,
                team_id: info.team_id,
                type: info.type,
                team: info.team
              }
            })
            .then(function (response) {
              console.log(response);
            })
            .catch(function (error) {
              console.log(error);
            });
          } catch (error) {
            console.log(error)
          }

        },

        updateTrue: function (info) {
          const id= info.id
          try {
          Axios
            .put('http://localhost:4000/api/users/'+ id, {
              user : {
                email: info.email,
                firstname: info.firstname,
                lastname: info.lastname,
                password: info.password_hash, 
                status: true,
                team_id: info.team_id,
                type: info.type,
                team: info.team
              }
            })
            .then(function (response) {
              console.log(response);
            })
            .catch(function (error) {
              console.log(error);
            });
          } catch (error) {
            console.log(error)
          }

        },
    },

    mounted () {
      Axios
        .get('http://localhost:4000/api/users')
        .then(response => (this.infos = response.data.data))

      Axios
        .get('http://localhost:4000/api/teams')
        .then(response => (this.teams = response.data.data))
    }
  }
  
</script>




<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
#team-table {
  width: 26vw;
  height: 39vw;
  overflow: hidden;
  overflow-y: scroll;
}

.colum-container{
  padding: 0;
}

.md-table-head .md-table-head-container{
  text-align: center;
}

.md-table-cell:last-child, .md-table-cell-container, .md-content {
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

.md-menu.md-select:not(.md-disabled) .md-icon{
  display: none;
}

</style>