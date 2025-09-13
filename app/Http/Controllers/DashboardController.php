<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\User;
use App\Models\Task;

class DashboardController extends Controller
{
    public function index()
    {
        return Inertia::render('Dashboard', [
            'users' => User::all(),
            'tasks' => Task::with('user')->get()
        ]);
    }

    public function storeTask(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'required|string',
            'user_id' => 'required|exists:users,id',
            'due_date' => 'required|date'
        ]);

        Task::create([
            'title' => $request->name,
            'description' => $request->description,
            'user_id' => $request->user_id,
            'status' => 'pendiente',
            'due_date' => $request->due_date
        ]);

        return redirect()->route('dashboard')->with('success', 'Task created successfully!');
    }

    public function updateTaskStatus(Request $request, Task $task)
    {
        $request->validate([
            'status' => 'required|in:pendiente,en progreso,completada'
        ]);

        $task->update(['status' => $request->status]);

        return redirect()->route('dashboard')->with('success', 'Task status updated successfully!');
    }

    public function deleteTask(Task $task)
    {
        $task->delete();

        return redirect()->route('dashboard')->with('success', 'Task deleted successfully!');
    }
}