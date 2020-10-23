<template>
  <div class="page-container md-layout-column">
    <md-toolbar class="md-primary">
      <md-button class="md-icon-button" @click="showNavigation = true">
        <md-icon>menu</md-icon>
      </md-button>
      <span class="md-title">Gotham City Hall</span>
    </md-toolbar>

    <md-drawer :md-active.sync="showNavigation" md-swipeable>
      <md-toolbar class="md-transparent" md-elevation="0">
        <span class="md-title">Menu</span>
      </md-toolbar>

      <md-list>
        <md-list-item>
          <md-icon>move_to_inbox</md-icon>
          <router-link to="/account"
            ><span class="md-list-item-text">Account</span></router-link
          >
        </md-list-item>

        <md-list-item>
          <md-icon>move_to_inbox</md-icon>
          <router-link to="/dashboard"
            ><span class="md-list-item-text">Dashboard</span></router-link
          >
        </md-list-item>

        <md-list-item>
          <md-icon>move_to_inbox</md-icon>
          <router-link to="/register"
            ><span class="md-list-item-text">Register</span></router-link
          >
        </md-list-item>

        <md-list-item>
          <md-icon>send</md-icon>
          <router-link to="/workingtimes"
            ><span class="md-list-item-text">Working Times</span></router-link
          >
        </md-list-item>

        <md-list-item>
          <md-icon>delete</md-icon>
          <router-link to="/workingtime"
            ><span class="md-list-item-text">Working Time</span></router-link
          >
        </md-list-item>

        <md-list-item>
          <md-icon>error</md-icon>
          <router-link to="/login"
            ><span class="md-list-item-text">Login</span></router-link
          >
        </md-list-item>
        <md-list-item>
          <md-icon>error</md-icon>
          <router-link to="/graph"
            ><span class="md-list-item-text">Bar Chart</span></router-link
          >
        </md-list-item>
      </md-list>
    </md-drawer>

    <md-content>
      <div id="app">
        <router-view />
      </div>
    </md-content>
  </div>
</template>

<script>
export default {
  name: "App",
  data: () => ({
    showNavigation: false,
    showSidepanel: false,
  }),
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /* margin-top: 60px; */
  min-height: 85vh;
}
.page-container {
  min-height: 300px;
  overflow: hidden;
  position: relative;
  border: 1px solid rgba(#000, 0.12);
}
.md-drawer {
  width: 230px;
  max-width: calc(100vw - 125px);
}
.md-content {
  padding: 16px;
}

</style>
