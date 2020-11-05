<template>
  <div class="page-container md-layout-column">
    <md-toolbar>
      <md-button class="md-icon-button" @click="showNavigation = true">
        <md-icon>menu</md-icon>
      </md-button>
      <span class="md-title">Gotham City Hall</span>
      <div v-if="user" class="md-toolbar-section-end">
        <md-button>{{ user.firstname + " " + user.lastname }}</md-button>
        <md-button>{{ user.right }}</md-button>
        <md-button>{{ user.team }}</md-button>
      </div>
      <div class="md-toolbar-section-end">
        <md-button
          class="bouton"
          v-if="this.$store.getters.isLoggedIn"
          @click="logout()"
          >Disconnect</md-button
        >
      </div>
    </md-toolbar>

    <md-drawer :md-active.sync="showNavigation" md-swipeable>
      <md-toolbar class="md-transparent" md-elevation="0">
        <span class="md-title">Menu</span>
      </md-toolbar>
      <md-list class="item-list-menu">
        <md-list-item v-if="isLoggedIn">
          <router-link to="/account"
            ><span @click="signout" class="md-list-item-text"
              >Account</span
            ></router-link
          >
        </md-list-item>
        <md-list-item v-if="!isLoggedIn">
          <router-link to="/register"
            ><span class="md-list-item-text">Register</span></router-link
          >
        </md-list-item>
        <md-list-item v-if="!isLoggedIn">
          <router-link to="/login"
            ><span class="md-list-item-text">Login</span></router-link
          >
        </md-list-item>

        <md-list-item>
          <router-link to="/dashboard"
            ><span class="md-list-item-text">Dashboard</span></router-link
          >
        </md-list-item>

        <md-list-item>
          <router-link to="/teamtable"
            ><span class="md-list-item-text">Team Table</span></router-link
          >
        </md-list-item>
        <md-list-item>
          <router-link to="/chart"
            ><span class="md-list-item-text">Chart</span></router-link
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
    signout: true,
    user: null,
  }),
  computed: {
    isLoggedIn: function() {
      return this.$store.getters.isLoggedIn;
    },
  },
  methods: {
    logout: function() {
      this.$store.dispatch("logout").then(() => {
        this.user = null;
        window.location.href = "/login";
      });
    },
  },
  mounted() {
    if (localStorage.getItem("token")) {
      this.$store.dispatch("getuser").then((response) => {
        this.user = response;
      });
    }
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  min-height: 75vh;
}

.md-title {
  font-weight: bold !important;
}

.md-list {
  margin: 25% !important;
  padding: 0;
}

.item-list-menu {
  text-align: center;
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

.bouton {
  background-color: red !important;
  color: #fff !important;
}
.boutons {
  background-color: green !important;
  color: #fff !important;
}
</style>
