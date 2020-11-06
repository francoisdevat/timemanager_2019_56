import Vue from "vue";
import Router from "vue-router";
import Register from "../../components/Register";
import Login from "../../components/Login";
import Account from "../../components/Account";
import Dashboard from "../../components/Dashboard";
import store from "../store/store";

Vue.use(Router);

const router = new Router({
  mode: "history",
  routes: [
    {
      path: "/",
      component: Dashboard,
      meta: {
        requiresAuth: true,
      },
    },
    {
      path: "/register",
      component: Register,
    },
    {
      path: "/login",
      component: Login,
    },
    {
      path: "/account",
      component: Account,
      meta: {
        requiresAuth: true,
      },
    },
    {
      path: "/dashboard",
      component: Dashboard,
      meta: {
        requiresAuth: true,
      },
    },
  ],
});

router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.requiresAuth)) {
    if (store.getters.isLoggedIn) {
      next();
      return;
    }
    next("/login");
  } else {
    next();
  }
});

export default router;
