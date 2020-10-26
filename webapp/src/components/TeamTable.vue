<template>
  <div id="team-table">
    <md-table>
      <md-table-row>
          <md-table-head class="colum-container" >Name</md-table-head>
          <md-table-head class="colum-container" >Type</md-table-head>
          <md-table-head class="colum-container" >Team</md-table-head>
      </md-table-row>

      <md-table-row v-for="info in infos.data" :key="info.id">
          <md-table-cell class="colum-container" >{{info.firstName}} {{info.lastName}}</md-table-cell>
          <md-table-cell class="colum-container" >Employee</md-table-cell>
          <md-table-cell class="colum-container" ><md-field>
             <label for="team">Team2</label>
                <md-select class="test" name="team" id="team">
                    <md-option v-for="team in teams" :key="team.id" value="team" class="colum-container" >{{team}}</md-option>
                </md-select>
              </md-field>
          </md-table-cell>
          <md-table-cell class="colum-container" ><md-icon>delete</md-icon></md-table-cell>
      </md-table-row>
    </md-table>
    <div>{{infos.data[0].type}}</div>
  </div>
</template>

<script>
import Axios from "axios"
  export default {
    name: 'TeamTable',
    data: () => ({
      infos: null,
      name: null,
      email: null,
      types: [{"id":1, "name":"test1"}, {"id":2, "name":"toto"}],
      teams: ["Joker", "Joker", "Joker", "Joker", "Joker"]
    }),
    method
    mounted () {
      Axios
        .get('http://localhost:4000/api/testusers')
        .then(response => (this.infos = response.data))
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

.md-table-cell:last-child .md-table-cell-container {
  padding: 0;
}

.test {
  width: 3vw;
}

.md-menu.md-select:not(.md-disabled) .md-icon{
  display: none;
}

</style>