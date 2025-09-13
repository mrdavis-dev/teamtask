<script setup>
import Modal from '@/Components/Modal.vue';
import { useForm } from '@inertiajs/vue3';
import { nextTick, ref } from 'vue';

const confirmingUserDeletion = ref(false);
const passwordInput = ref(null);

const form = useForm({
    password: '',
});

const confirmUserDeletion = () => {
    confirmingUserDeletion.value = true;
    nextTick(() => passwordInput.value.focus());
};

const deleteUser = () => {
    form.delete(route('profile.destroy'), {
        preserveScroll: true,
        onSuccess: () => closeModal(),
        onError: () => passwordInput.value.focus(),
        onFinish: () => form.reset(),
    });
};

const closeModal = () => {
    confirmingUserDeletion.value = false;
    form.clearErrors();
    form.reset();
};
</script>

<template>
    <div class="form-container">
        <div class="danger-zone">
            <button @click="confirmUserDeletion" class="danger-button">
                Delete Account
            </button>
        </div>

        <Modal :show="confirmingUserDeletion" @close="closeModal">
            <div class="modal-content">
                <h2 class="modal-title">
                    Are you sure you want to delete your account?
                </h2>

                <p class="modal-description">
                    Once your account is deleted, all of its resources and data will be permanently deleted. 
                    Please enter your password to confirm you would like to permanently delete your account.
                </p>

                <div class="form-group">
                    <label for="password" class="sr-only">Password</label>
                    <input
                        id="password"
                        ref="passwordInput"
                        type="password"
                        class="form-input"
                        v-model="form.password"
                        placeholder="Password"
                        @keyup.enter="deleteUser"
                    />
                    <div v-if="form.errors.password" class="form-error">{{ form.errors.password }}</div>
                </div>

                <div class="modal-actions">
                    <button @click="closeModal" class="cancel-button">
                        Cancel
                    </button>
                    <button @click="deleteUser" :disabled="form.processing" class="confirm-delete-button">
                        {{ form.processing ? 'Deleting...' : 'Delete Account' }}
                    </button>
                </div>
            </div>
        </Modal>
    </div>
</template>

<style scoped>
.form-container {
    padding: 2rem;
}

.danger-zone {
    display: flex;
    justify-content: flex-start;
}

.danger-button {
    padding: 0.75rem 1.5rem;
    background-color: #dc2626;
    color: #ffffff;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}

.danger-button:hover {
    background-color: #b91c1c;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
}

.modal-content {
    padding: 2rem;
}

.modal-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1rem;
}

.modal-description {
    color: #6b7280;
    line-height: 1.5;
    margin-bottom: 1.5rem;
}

.form-group {
    margin-bottom: 1.5rem;
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
    border-color: #dc2626;
    box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
}

.form-error {
    margin-top: 0.5rem;
    color: #dc2626;
    font-size: 0.875rem;
}

.modal-actions {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
}

.cancel-button {
    padding: 0.75rem 1.5rem;
    background-color: #f3f4f6;
    color: #374151;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}

.cancel-button:hover {
    background-color: #e5e7eb;
}

.confirm-delete-button {
    padding: 0.75rem 1.5rem;
    background-color: #dc2626;
    color: #ffffff;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}

.confirm-delete-button:hover:not(:disabled) {
    background-color: #b91c1c;
}

.confirm-delete-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
}
</style>