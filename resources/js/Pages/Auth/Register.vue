<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { ref } from 'vue';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
});

const isLoading = ref(false);

const submit = () => {
    isLoading.value = true;
    form.post(route('register'), {
        onFinish: () => {
            isLoading.value = false;
            form.reset('password', 'password_confirmation');
        },
    });
};
</script>

<template>
    <GuestLayout :is-register="true">
        <Head title="Registrarse" />

        <div class="auth-card register">
            <h1 class="auth-title">Sign Up</h1>
            
            <form @submit.prevent="submit" class="form-group">
                <div class="form-field">
                    <TextInput
                        id="name"
                        v-model="form.name"
                        type="text"
                        class="form-control"
                        placeholder="Full Name"
                        required
                        autofocus
                        autocomplete="name"
                    />
                    <div v-if="form.errors.name" class="error-message">{{ form.errors.name }}</div>
                </div>

                <div class="form-field">
                    <TextInput
                        id="email"
                        v-model="form.email"
                        type="email"
                        class="form-control"
                        placeholder="Email"
                        required
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
                        autocomplete="new-password"
                    />
                    <div v-if="form.errors.password" class="error-message">{{ form.errors.password }}</div>
                </div>

                <div class="form-field">
                    <TextInput
                        id="password_confirmation"
                        v-model="form.password_confirmation"
                        type="password"
                        class="form-control"
                        placeholder="Confirm Password"
                        required
                        autocomplete="new-password"
                    />
                    <div v-if="form.errors.password_confirmation" class="error-message">{{ form.errors.password_confirmation }}</div>
                </div>

                <button 
                    type="submit"
                    class="btn btn-primary"
                    :disabled="form.processing || isLoading"
                >
                    <span v-if="isLoading" class="spinner"></span>
                    <span v-else>Sign Up</span>
                </button>

                <div class="form-links">
                    <p>
                        Already have an account? 
                        <Link :href="route('login')" class="auth-link">
                            Sign in here
                        </Link>
                    </p>
                </div>
            </form>
        </div>
    </GuestLayout>
</template>

<style scoped>
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
    border-color: #f093fb;
    box-shadow: 0 0 0 3px rgba(240, 147, 251, 0.1);
    transform: translateY(-1px);
}

.form-control::placeholder {
    color: #a0aec0;
}

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
    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    color: white;
    box-shadow: 0 4px 15px rgba(240, 147, 251, 0.3);
}

.btn-primary:hover:not(:disabled) {
    background: linear-gradient(135deg, #e879f9 0%, #ef4444 100%);
    box-shadow: 0 6px 20px rgba(240, 147, 251, 0.4);
    transform: translateY(-2px);
}

.btn:disabled {
    opacity: 0.7;
    cursor: not-allowed;
    transform: none !important;
}

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
    color: #f093fb;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s ease;
}

.auth-link:hover {
    color: #e879f9;
    text-decoration: underline;
}

.error-message {
    color: #e53e3e;
    font-size: 0.875rem;
    margin-top: 0.25rem;
}

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
