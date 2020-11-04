<template>
  <div class="page-container md-layout-column">
    <md-toolbar>
      <md-button class="md-icon-button" @click="showNavigation = true">
        <md-icon>menu</md-icon>
      </md-button>
      <span class="md-title"
        >Gotham City Hall</span
      >
      <div v-if="this.$store.getters.isLoggedIn" class="md-toolbar-section-end">
        <md-button>{{ isUser.firstname + " " + isUser.lastname }}</md-button>
        <md-button>{{isUser.right}}</md-button>
        <md-button>Team 56 Epitech</md-button>
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

        <md-list-item>
          <router-link to="/register"
            ><span class="md-list-item-text">Register</span></router-link
          >
        </md-list-item>

        <md-list-item>
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
        <md-list-item>
          <span class="md-list-item-text" @click="logout()">Logout</span>
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
    isUser: function() {
      return this.$store.getters.isUser;
    },
  },
  methods: {
    logout: function() {
      this.$store.dispatch("logout").then(() => {
        this.$router.push("/login");
      });
    },
  },
  async mounted() {},
  created: function() {
    // this.$http.interceptors.response.use(undefined, function (err) {
    //   // return new Promise(function (resolve, reject) {
    //   return new Promise(function () {
    //     if (err.status === 401 && err.config && !err.config.__isRetryRequest) {
    //       this.$store.dispatch("logout")
    //     }
    //     throw err;
    //   });
    // });
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
  font-weight: bold!important;
}

.md-list {
    margin: 25%!important;
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
