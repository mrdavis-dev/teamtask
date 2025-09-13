<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import DeleteUserForm from './Partials/DeleteUserForm.vue';
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from './Partials/UpdateProfileInformationForm.vue';
import { Head } from '@inertiajs/vue3';

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});
</script>

<template>
    <Head title="Profile" />

    <AuthenticatedLayout>
        <div class="profile-container">
            <div class="profile-header">
                <h1 class="profile-title">Profile Settings</h1>
                <p class="profile-subtitle">Manage your account settings and preferences</p>
            </div>

            <div class="profile-content">
                <div class="profile-section">
                    <div class="section-header">
                        <h2 class="section-title">Profile Information</h2>
                        <p class="section-description">Update your account's profile information and email address.</p>
                    </div>
                    <UpdateProfileInformationForm
                        :must-verify-email="mustVerifyEmail"
                        :status="status"
                    />
                </div>

                <div class="profile-section">
                    <div class="section-header">
                        <h2 class="section-title">Update Password</h2>
                        <p class="section-description">Ensure your account is using a long, random password to stay secure.</p>
                    </div>
                    <UpdatePasswordForm />
                </div>

                <div class="profile-section danger-section">
                    <div class="section-header">
                        <h2 class="section-title">Delete Account</h2>
                        <p class="section-description">Once your account is deleted, all of its resources and data will be permanently deleted. Before deleting your account, please download any data or information that you wish to retain.</p>
                    </div>
                    <DeleteUserForm />
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.profile-container {
    max-width: 900px;
    margin: 0 auto;
    padding: 2rem;
    min-height: calc(100vh - 64px);
}

.profile-header {
    text-align: center;
    margin-bottom: 3rem;
}

.profile-title {
    font-size: 2.5rem;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 0.5rem;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.profile-subtitle {
    font-size: 1.1rem;
    color: #6b7280;
    max-width: 600px;
    margin: 0 auto;
}

.profile-content {
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

.profile-section {
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    overflow: hidden;
    border: 1px solid #e5e7eb;
}

.danger-section {
    border-color: #fecaca;
    background: #fef2f2;
}

.section-header {
    padding: 1.5rem 2rem;
    border-bottom: 1px solid #e5e7eb;
    background: #f9fafb;
}

.danger-section .section-header {
    background: #fef2f2;
    border-bottom-color: #fecaca;
}

.section-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 0.5rem;
}

.danger-section .section-title {
    color: #dc2626;
}

.section-description {
    color: #6b7280;
    line-height: 1.5;
    margin: 0;
}

.danger-section .section-description {
    color: #991b1b;
}

/* Responsive design */
@media (max-width: 768px) {
    .profile-container {
        padding: 1rem;
    }
    
    .profile-title {
        font-size: 2rem;
    }
    
    .section-header {
        padding: 1rem 1.5rem;
    }
}
</style>
