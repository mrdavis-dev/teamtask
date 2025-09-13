<script setup>
import { useForm } from '@inertiajs/vue3';
import { ref } from 'vue';

const passwordInput = ref(null);
const currentPasswordInput = ref(null);

const form = useForm({
    current_password: '',
    password: '',
    password_confirmation: '',
});

const updatePassword = () => {
    form.put(route('password.update'), {
        preserveScroll: true,
        onSuccess: () => form.reset(),
        onError: () => {
            if (form.errors.password) {
                form.reset('password', 'password_confirmation');
                passwordInput.value.focus();
            }
            if (form.errors.current_password) {
                form.reset('current_password');
                currentPasswordInput.value.focus();
            }
        },
    });
};
</script>

<template>
    <div class="form-container">
        <form @submit.prevent="updatePassword" class="password-form">
            <div class="form-group">
                <label for="current_password" class="form-label">Current Password</label>
                <input
                    id="current_password"
                    ref="currentPasswordInput"
                    type="password"
                    class="form-input"
                    v-model="form.current_password"
                    autocomplete="current-password"
                />
                <div v-if="form.errors.current_password" class="form-error">{{ form.errors.current_password }}</div>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">New Password</label>
                <input
                    id="password"
                    ref="passwordInput"
                    type="password"
                    class="form-input"
                    v-model="form.password"
                    autocomplete="new-password"
                />
                <div v-if="form.errors.password" class="form-error">{{ form.errors.password }}</div>
            </div>

            <div class="form-group">
                <label for="password_confirmation" class="form-label">Confirm Password</label>
                <input
                    id="password_confirmation"
                    type="password"
                    class="form-input"
                    v-model="form.password_confirmation"
                    autocomplete="new-password"
                />
                <div v-if="form.errors.password_confirmation" class="form-error">{{ form.errors.password_confirmation }}</div>
            </div>

            <div class="form-actions">
                <button type="submit" :disabled="form.processing" class="save-button">
                    {{ form.processing ? 'Updating...' : 'Save' }}
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

.password-form {
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

.form-error {
    margin-top: 0.5rem;
    color: #dc2626;
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