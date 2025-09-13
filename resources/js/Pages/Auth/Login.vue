<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { ref } from 'vue';

defineProps({
    canResetPassword: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const isLoading = ref(false);

const submit = () => {
    isLoading.value = true;
    form.post(route('login'), {
        onFinish: () => {
            isLoading.value = false;
            form.reset('password');
        },
    });
};
</script>

<template>
    <GuestLayout :is-register="false">
        <Head title="Iniciar Sesión" />

        <div v-if="status" class="alert alert-success">
            {{ status }}
        </div>

        <div class="auth-card login">
            <h1 class="auth-title">Sign In</h1>
            
            <form @submit.prevent="submit" class="form-group">
                <div class="form-field">
                    <TextInput
                        id="email"
                        v-model="form.email"
                        type="email"
                        class="form-control"
                        placeholder="Email"
                        required
                        autofocus
                        autocomplete="username"
                    />
                    <div v-if="form.errors.email" class="error-message">{{ form.errors.email }}</div>
                </div>

                <div class="form-field">
                    <TextInput
                        id="password"
                        v-model="form.password"
                        type="password"
                        class="form-control"
                        placeholder="Password"
                        required
                        autocomplete="current-password"
                    />
                    <div v-if="form.errors.password" class="error-message">{{ form.errors.password }}</div>
                </div>

                <div class="form-field-checkbox">
                    <label class="checkbox-container">
                        <input
                            v-model="form.remember"
                            type="checkbox"
                            name="remember"
                        />
                        <span class="checkmark"></span>
                        <span class="checkbox-text">Remember me</span>
                    </label>
                </div>

                <button 
                    type="submit"
                    class="btn btn-primary"
                    :disabled="form.processing || isLoading"
                    :class="{ 'loading': isLoading }"
                >
                    <span v-if="isLoading" class="spinner"></span>
                    <span v-else>Sign In</span>
                </button>

                <div class="form-links">
                    <p>
                        Don't have an account? 
                        <Link :href="route('register')" class="auth-link">
                            Sign up here
                        </Link>
                    </p>
                    <p v-if="canResetPassword">
                        <Link :href="route('password.request')" class="auth-link">
                            Forgot your password?
                        </Link>
                    </p>
                </div>
            </form>
        </div>
    </GuestLayout>
</template>

<style scoped>
/* Alert Styles */
.alert {
    padding: 0.75rem 1rem;
    margin-bottom: 1.5rem;
    border-radius: 8px;
    border-left: 4px solid;
}

.alert-success {
    background-color: #d4edda;
    border-color: #28a745;
    color: #155724;
}

/* Auth Card */
.auth-card {
    width: 100%;
}

.auth-title {
    font-size: 2rem;
    font-weight: 700;
    text-align: center;
    margin-bottom: 2rem;
    color: #2d3748;
    letter-spacing: -0.025em;
}

/* Form Styles */
.form-group {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.form-field {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.form-control {
    width: 100%;
    padding: 0.875rem 1rem;
    border: 2px solid #e2e8f0;
    border-radius: 10px;
    font-size: 1rem;
    transition: all 0.2s ease;
    background: #ffffff;
    outline: none;
}

.form-control:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    transform: translateY(-1px);
}

.form-control::placeholder {
    color: #a0aec0;
}

/* Checkbox Styles */
.form-field-checkbox {
    margin: 0.5rem 0;
}

.checkbox-container {
    display: flex;
    align-items: center;
    cursor: pointer;
    user-select: none;
}

.checkbox-container input {
    position: absolute;
    opacity: 0;
    cursor: pointer;
    height: 0;
    width: 0;
}

.checkmark {
    height: 18px;
    width: 18px;
    background-color: #ffffff;
    border: 2px solid #e2e8f0;
    border-radius: 4px;
    margin-right: 0.75rem;
    position: relative;
    transition: all 0.2s ease;
}

.checkbox-container:hover input ~ .checkmark {
    border-color: #667eea;
}

.checkbox-container input:checked ~ .checkmark {
    background-color: #667eea;
    border-color: #667eea;
}

.checkmark:after {
    content: "";
    position: absolute;
    display: none;
    left: 5px;
    top: 2px;
    width: 4px;
    height: 8px;
    border: solid white;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
}

.checkbox-container input:checked ~ .checkmark:after {
    display: block;
}

.checkbox-text {
    font-size: 0.9rem;
    color: #4a5568;
}

/* Button Styles */
.btn {
    padding: 0.875rem 2rem;
    border: none;
    border-radius: 10px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
    outline: none;
    min-height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.btn-primary:hover:not(:disabled) {
    background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
    transform: translateY(-2px);
}

.btn-primary:active:not(:disabled) {
    transform: translateY(0);
    box-shadow: 0 2px 10px rgba(102, 126, 234, 0.3);
}

.btn:disabled {
    opacity: 0.7;
    cursor: not-allowed;
    transform: none !important;
}

/* Loading Spinner */
.spinner {
    width: 20px;
    height: 20px;
    border: 2px solid rgba(255, 255, 255, 0.3);
    border-radius: 50%;
    border-top-color: white;
    animation: spin 1s ease-in-out infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

/* Form Links */
.form-links {
    text-align: center;
    margin-top: 1rem;
}

.form-links p {
    margin: 0.5rem 0;
    font-size: 0.9rem;
    color: #4a5568;
}

.auth-link {
    color: #667eea;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s ease;
}

.auth-link:hover {
    color: #5a67d8;
    text-decoration: underline;
}

/* Error Messages */
.error-message {
    color: #e53e3e;
    font-size: 0.875rem;
    margin-top: 0.25rem;
}

/* Responsive */
@media (max-width: 480px) {
    .auth-title {
        font-size: 1.75rem;
    }
    
    .form-control {
        padding: 0.75rem;
    }
    
    .btn {
        padding: 0.75rem 1.5rem;
    }
}
</style>
