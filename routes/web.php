<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\TaskController;

Route::get('/', function () {
    return redirect()->route('login');
});

Route::get('/dashboard', [App\Http\Controllers\DashboardController::class, 'index'])->middleware(['auth', 'verified'])->name('dashboard');

Route::post('/dashboard/tasks', [App\Http\Controllers\DashboardController::class, 'storeTask'])->middleware(['auth', 'verified'])->name('dashboard.tasks.store');

Route::post('/tasks/{task}/update-status', [App\Http\Controllers\DashboardController::class, 'updateTaskStatus'])->middleware(['auth', 'verified'])->name('tasks.update-status');

Route::delete('/tasks/{task}', [App\Http\Controllers\DashboardController::class, 'deleteTask'])->middleware(['auth', 'verified'])->name('tasks.delete');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::get('tasks/filter', [TaskController::class, 'filter'])->name('tasks.filter');

require __DIR__.'/auth.php';
