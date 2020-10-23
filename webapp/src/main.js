import Vue from "vue";
import App from "./App.vue";
import VueMaterial from "vue-material";
import "vue-material/dist/vue-material.min.css";
import "vue-material/dist/theme/default.css";
import VueRouter from "vue-router";
import Register from "./components/Register";
import HelloWorld from "./components/HelloWorld";
import WorkingTimes from "./components/WorkingTimes";
import WorkingTime from "./components/WorkingTime";
import VueMoment from "vue-moment";
import Login from "./components/Login";
import Account from "./components/Account";
import Dashboard from "./components/Dashboard";

Vue.use(VueMoment);
Vue.use(VueMaterial);
Vue.use(VueRouter);
Vue.config.productionTip = false;

const routes = [
  { path: "/", component: HelloWorld },
  { path: "/register", component: Register },
  { path: "/workingtimes", component: WorkingTimes },
  { path: "/workingtime", component: WorkingTime },
  { path: "/login", component: Login },
  { path: "/account", component: Account },
  { path: "/dashboard", component: Dashboard },
];

const router = new VueRouter({
  mode: "history",
  routes,
});

new Vue({
  render: (h) => h(App),
  router,
}).$mount("#app");
