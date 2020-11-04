<template>
  <div>
    <form novalidate class="md-layout form-login" @submit.prevent="validateUser">
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
                <span class="md-error" v-if="!$v.form.email.required"
                  >The email is required</span
                >
                <span class="md-error" v-else-if="!$v.form.email"
                  >Invalid email</span
                >
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
          <router-link class="espace" to="/register"
            >No account yet ? Sign up</router-link
          >
          <md-button
            type="submit"
            class="md-raised md-primary"
            :disabled="sending"
            >Sign in</md-button
          >
        </md-card-actions>
      </md-card>
    </form>
    <md-snackbar :md-active.sync="unauthorized"
      >The email or password is incorrect</md-snackbar
    >
  </div>
</template>

<script>
import { validationMixin } from "vuelidate";
import { required, email } from "vuelidate/lib/validators";

export default {
  name: "User",
  mixins: [validationMixin],
  data: () => ({
    unauthorized: false,
    form: {
      email: null,
      password: null,
    },
    sending: false,
    token: null,
  }),
  validations: {
    form: {
      email: {
        required,
        email,
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
      this.form.email = null;
      this.form.password = null;
    },
    login: function() {
      this.sending = true;
      let email = this.form.email;
      let password = this.form.password;
      this.$store
        .dispatch("login", { email, password })
        .then(() => this.$router.push("/dashboard"))
        .catch((error) => {
          console.log(error)
          this.unauthorized = true;
        });
      this.sending = false;
      this.clearForm();

    },
    validateUser() {
      this.$v.$touch();
      if (!this.$v.$invalid) {
        this.login();
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.form-login {
  padding-top: 8vw;
}

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
