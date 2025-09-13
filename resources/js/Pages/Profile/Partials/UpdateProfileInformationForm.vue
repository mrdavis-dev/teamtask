<script setup>
import { Link, useForm, usePage } from '@inertiajs/vue3';

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const user = usePage().props.auth.user;

const form = useForm({
    name: user.name,
    email: user.email,
});
</script>

<template>
    <div class="form-container">
        <form @submit.prevent="form.patch(route('profile.update'))" class="profile-form">
            <div class="form-group">
                <label for="name" class="form-label">Name</label>
                <input
                    id="name"
                    type="text"
                    class="form-input"
                    v-model="form.name"
                    required
                    autofocus
                    autocomplete="name"
                />
                <div v-if="form.errors.name" class="form-error">{{ form.errors.name }}</div>
            </div>

            <div class="form-group">
                <label for="email" class="form-label">Email</label>
                <input
                    id="email"
                    type="email"
                    class="form-input"
                    v-model="form.email"
                    required
                    autocomplete="username"
                />
                <div v-if="form.errors.email" class="form-error">{{ form.errors.email }}</div>
            </div>

            <div v-if="mustVerifyEmail && user.email_verified_at === null" class="verification-notice">
                <p class="verification-text">
                    Your email address is unverified.
                    <Link
                        :href="route('verification.send')"
                        method="post"
                        as="button"
                        class="verification-link"
                    >
                        Click here to re-send the verification email.
                    </Link>
                </p>

                <div v-show="status === 'verification-link-sent'" class="verification-success">
                    A new verification link has been sent to your email address.
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" :disabled="form.processing" class="save-button">
                    {{ form.processing ? 'Saving...' : 'Save' }}
                </button>

                <div v-show="form.recentlySuccessful" class="success-message">
                    Saved.
                </div>
            </div>
        </form>
    </div>
</template>

<style scoped>
.form-container {
    padding: 2rem;
}

.profile-form {
    max-width: 500px;
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 500;
    color: #374151;
    font-size: 0.875rem;
}

.form-input {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    font-size: 1rem;
    transition: all 0.2s ease-in-out;
    background-color: #ffffff;
}

.form-input:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.form-input:disabled {
    background-color: #f9fafb;
    color: #6b7280;
}

.form-error {
    margin-top: 0.5rem;
    color: #dc2626;
    font-size: 0.875rem;
}

.verification-notice {
    margin-bottom: 1.5rem;
    padding: 1rem;
    background-color: #fef3c7;
    border: 1px solid #f59e0b;
    border-radius: 8px;
}

.verification-text {
    color: #92400e;
    margin: 0;
}

.verification-link {
    color: #1d4ed8;
    text-decoration: underline;
    background: none;
    border: none;
    cursor: pointer;
    font-size: inherit;
}

.verification-link:hover {
    color: #1e40af;
}

.verification-success {
    margin-top: 0.5rem;
    color: #166534;
    font-size: 0.875rem;
}

.form-actions {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.save-button {
    padding: 0.75rem 1.5rem;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: #ffffff;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}

.save-button:hover:not(:disabled) {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
}

.save-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
    transform: none;
}

.success-message {
    color: #059669;
    font-size: 0.875rem;
    font-weight: 500;
}
</style>
