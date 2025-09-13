<template>
  <div class="task-list">
    <h3>Tasks</h3>
    <div v-if="tasks.length === 0" class="no-tasks">
      <p>No tasks yet. Create your first task!</p>
    </div>
    <div v-else class="tasks-grid">
      <div 
        v-for="task in filteredTasks" 
        :key="task.id"
        class="task-card"
        :class="`status-${task.status}`"
      >
        <div class="task-header">
          <h4>{{ task.title }}</h4>
          <span class="task-status">{{ task.status }}</span>
        </div>
        <p class="task-description">{{ task.description }}</p>
        <div class="task-footer">
          <span class="assigned-user">
            Assigned to: {{ task.user.name }}
          </span>
          <div class="task-actions">
            <button 
              v-if="task.status === 'pendiente'"
              @click="updateTaskStatus(task.id, 'en progreso')"
              class="btn btn-sm btn-primary"
            >
              Start
            </button>
            <button 
              v-if="task.status === 'en progreso'"
              @click="updateTaskStatus(task.id, 'completada')"
              class="btn btn-sm btn-success"
            >
              Complete
            </button>
            <button 
              @click="deleteTask(task.id)"
              class="btn btn-sm btn-danger"
            >
              Delete
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { router } from '@inertiajs/vue3'

export default {
  name: 'TaskList',
  props: {
    tasks: {
      type: Array,
      default: () => []
    },
    filter: {
      type: String,
      default: 'all'
    }
  },
  computed: {
    filteredTasks() {
      if (this.filter === 'all') {
        return this.tasks;
      }
      return this.tasks.filter(task => task.status === this.filter);
    }
  },
  methods: {
    updateTaskStatus(taskId, status) {
      router.post(`/tasks/${taskId}/update-status`, {
        status: status
      }, {
        preserveScroll: true
      });
    },
    deleteTask(taskId) {
      if (confirm('Are you sure you want to delete this task?')) {
        router.delete(`/tasks/${taskId}`, {
          preserveScroll: true
        });
      }
    }
  }
}
</script>

<style scoped>
.task-list h3 {
  margin-bottom: 20px;
  color: #2c3e50;
  font-size: 1.5rem;
}

.no-tasks {
  text-align: center;
  padding: 40px;
  color: #7f8c8d;
  font-style: italic;
}

.tasks-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.task-card {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: transform 0.2s, box-shadow 0.2s;
}

.task-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

.task-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.task-header h4 {
  margin: 0;
  color: #2c3e50;
  font-size: 1.1rem;
}

.task-status {
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 500;
  text-transform: capitalize;
}

.status-pendiente .task-status {
  background-color: #fff3cd;
  color: #856404;
}

.status-en_progreso .task-status {
  background-color: #cce5ff;
  color: #0066cc;
}

.status-completada .task-status {
  background-color: #d4edda;
  color: #155724;
}

.task-description {
  color: #555;
  margin-bottom: 15px;
  line-height: 1.5;
}

.task-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 10px;
}

.assigned-user {
  font-size: 0.9rem;
  color: #666;
}

.task-actions {
  display: flex;
  gap: 8px;
}

.btn {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  font-size: 0.8rem;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-sm {
  padding: 4px 8px;
  font-size: 0.75rem;
}

.btn-primary {
  background-color: #007bff;
  color: white;
}

.btn-primary:hover {
  background-color: #0056b3;
}

.btn-success {
  background-color: #28a745;
  color: white;
}

.btn-success:hover {
  background-color: #1e7e34;
}

.btn-danger {
  background-color: #dc3545;
  color: white;
}

.btn-danger:hover {
  background-color: #c82333;
}
</style>