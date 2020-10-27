import Vue from "vue";
import App from "./App.vue";
import VueMaterial from "vue-material";
import "vue-material/dist/vue-material.min.css";
import "vue-material/dist/theme/default.css";
import VueRouter from "vue-router";
import Register from "./components/Register";
import VueMoment from "vue-moment";
import Login from "./components/Login";
import Account from "./components/Account";
import Dashboard from "./components/Dashboard";
import TeamTable from "./components/TeamTable";
import Chart from "./components/Chart"
// import store from './store';

Vue.use(VueMoment);
Vue.use(VueMaterial);
Vue.use(VueRouter);
Vue.config.productionTip = false;

const routes = [
  { path: "/", component: Dashboard },
  { path: "/register", component: Register },
  { path: "/login", component: Login },
  { path: "/account", component: Account },
  { path: "/dashboard", component: Dashboard },
  { path: "/teamtable", component: TeamTable },
  { path: "/chart", component: Chart },
];

const router = new VueRouter({
  mode: "history",
  routes,
});

new Vue({
  render: (h) => h(App),
  router,
  // store
}).$mount("#app");
