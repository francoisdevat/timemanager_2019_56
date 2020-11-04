<template>
  <div>
    <form novalidate class="md-layout" @submit.prevent="validateUser">
      <md-card class="md-layout-item md-size-50 md-small-size-100 formulaire">
        <md-card-header>
          <div class="md-title">Gotham City Hall - Register</div>
        </md-card-header>

        <md-card-content>
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('firstname')">
                <label for="first-name">First name</label>
                <md-input
                  name="firstname"
                  id="firstname"
                  v-model="form.firstname"
                  :disabled="sending"
                />
                <span class="md-error" v-if="!$v.form.firstname.required"
                  >The first name is required</span
                >
                <span class="md-error" v-else-if="!$v.form.firstname.minlength"
                  >Invalid firstname</span
                >
              </md-field>
            </div>
          </div>
          <md-field :class="getValidationClass('lastname')">
            <label for="last-name">Last name</label>
            <md-input
              name="lastname"
              id="lastname"
              v-model="form.lastname"
              :disabled="sending"
            />
            <span class="md-error" v-if="!$v.form.lastname.required"
              >The last name is required</span
            >
            <span class="md-error" v-else-if="!$v.form.lastname.minlength"
              >Invalid lastname</span
            >
          </md-field>
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
            <span class="md-error" v-else-if="!$v.form.email.email"
              >Invalid email</span
            >
          </md-field>
          <md-field :class="getValidationClass('password')">
            <label for="password">Password</label>
            <md-input
              type="password"
              name="password"
              id="password"
              v-model="form.password"
              :disabled="sending"
            />
            <span class="md-error" v-if="!$v.form.password.required"
              >The password is required</span
            >
            <span class="md-error" v-else-if="!$v.form.password.password"
              >Invalid password</span
            >
          </md-field>
        </md-card-content>

        <md-progress-bar md-mode="indeterminate" v-if="sending" />

        <md-card-actions>
          <router-link class="espace" to="/login"
            >Already a member ? Go sign in !</router-link
          >
          <md-button
            type="submit"
            class="md-raised md-primary"
            :disabled="sending"
            >Sign up</md-button
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
import { required, email } from "vuelidate/lib/validators";

export default {
  name: "Register",
  mixins: [validationMixin],
  data: () => ({
    form: {
      email: null,
      firstname: null,
      lastname: null,
      password: null,
    },
    userSaved: false,
    sending: false,
    lastUser: null,
  }),
  validations: {
    form: {
      email: {
        required,
        email,
      },
      firstname: {
        required,
      },
      lastname: {
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
      this.form.firstname = null;
      this.form.lastname = null;
      this.form.password = null;
      this.form.email = null;
    },
    saveUser() {
      this.sending = true;
      this.$store
        .dispatch("register", {
          email: this.form.email,
          firstname: this.form.firstname,
          lastname: this.form.lastname,
          password: this.form.password,
          status: true,
          right_id: "",
          team_id: "",
        })
        .then(() => {
          this.lastUser = `${this.form.firstname} ${this.form.lastname}`;
          this.userSaved = true;
        })
        .catch((error) => {
          console.log(error);
          // snackbar error
        });
      this.sending = false;
      this.clearForm();
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
