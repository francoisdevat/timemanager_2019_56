<template>
  <div>
    <form novalidate class="md-layout" @submit.prevent="validateUser">
      <md-card class="md-layout-item md-size-50 md-small-size-100 formulaire">
        <md-card-header>
          <div class="md-title">Gotham City Hall - Login</div>
        </md-card-header>

        <md-card-content>
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('email')">
                <label for="email">Email</label>
                <md-input
                  type="email"
                  name="email"
                  id="email"
                  autocomplete="email"
                  v-model="form.email"
                  :disabled="sending"
                />
              </md-field>
            </div>
          </div>

          <md-field :class="getValidationClass('password')">
            <label for="password">Password</label>
            <md-input
              name="password"
              id="password"
              type="password"
              v-model="form.password"
              :disabled="sending"
            />
            <span class="md-error" v-if="!$v.form.password.required"
              >The password is required</span
            >
            <span class="md-error" v-else-if="!$v.form.password.minlength"
              >Invalid password</span
            >
          </md-field>
        </md-card-content>

        <md-progress-bar md-mode="indeterminate" v-if="sending" />

        <md-card-actions>
          <router-link class="espace" to="/register">No account yet ? Sign up</router-link>
          <md-button
            type="submit"
            class="md-raised md-primary"
            :disabled="sending"
            >Sign in</md-button
          >
        </md-card-actions>
      </md-card>

      <md-snackbar :md-active.sync="userSaved"
        >The user {{ lastUser }} was saved with success!</md-snackbar
      >
    </form>
  </div>
</template>

<script>
import { validationMixin } from "vuelidate";
import { required } from "vuelidate/lib/validators";
import Axios from "axios";

export default {
  name: "User",
  mixins: [validationMixin],
  data: () => ({
    form: {
      username: null,
      password: null,
    },
    userSaved: false,
    sending: false,
    lastUser: null,
  }),
  validations: {
    form: {
      username: {
        required,
      },
      password: {
        required,
      },
    },
  },
  methods: {
    getValidationClass(fieldName) {
      const field = this.$v.form[fieldName];

      if (field) {
        return {
          "md-invalid": field.$invalid && field.$dirty,
        };
      }
    },
    clearForm() {
      this.$v.$reset();
      this.form.username = null;
      this.form.email = null;
    },
    saveUser() {
      this.sending = true;

      Axios.post("http://localhost:4000/api/users/", {
        user: {
          username: this.form.username,
          email: this.form.email,
        },
      })
        .then((response) => (this.lastUser = response.data))
        .catch((error) => {
          console.log(error);
        });
      // Instead of this timeout, here you can call your API
      window.setTimeout(() => {
        this.lastUser = `${this.form.username} ${this.form.email}`;
        this.userSaved = true;
        this.sending = false;
        this.clearForm();
      }, 1500);
    },
    validateUser() {
      this.$v.$touch();

      if (!this.$v.$invalid) {
        this.saveUser();
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.md-progress-bar {
  position: absolute;
  top: 0;
  right: 0;
  left: 0;
}
.formulaire {
  margin-left: auto;
  margin-right: auto;
}
.espace {
    margin-right: 20px;
}
</style>
