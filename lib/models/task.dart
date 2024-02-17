enum TaskStatus { start, paused, end, running }

enum TaskPhase { pomodoro, shortBreak, longBreak }

class Task {
  int timeElapsed = 0;
  int longBreakElapsed = 0;
  int shortBreakElapsed = 0;
  TaskStatus status = TaskStatus.start;
  TaskPhase phase = TaskPhase.pomodoro;

  phaseIndex() {
    switch (phase) {
      case TaskPhase.pomodoro:
        return 0;
      case TaskPhase.shortBreak:
        return 1;
      case TaskPhase.longBreak:
        return 2;
      default:
    }
  }

  setPhase(int index) {
    switch (index) {
      case 0:
        phase = TaskPhase.pomodoro;
        break;
      case 1:
        phase = TaskPhase.shortBreak;
        break;
      case 2:
        phase = TaskPhase.longBreak;
        break;
      default:
    }
  }

  statusString() {
    switch (status) {
      case TaskStatus.start:
        return "Start";
      case TaskStatus.paused:
        return "Paused";
      case TaskStatus.end:
        return "Ended";
      case TaskStatus.running:
        return "Pause";
    }
  }

  elapsedTimeForPhase() {
    switch (phase) {
      case TaskPhase.pomodoro:
        return timeElapsed;
      case TaskPhase.shortBreak:
        return shortBreakElapsed;
      case TaskPhase.longBreak:
        return longBreakElapsed;
      default:
        return timeElapsed;
    }
  }

  updateElapsedTimeForPhase(int time) {
    switch (phase) {
      case TaskPhase.pomodoro:
        timeElapsed = time;
        break;
      case TaskPhase.shortBreak:
        shortBreakElapsed = time;
        break;
      case TaskPhase.longBreak:
        longBreakElapsed = time;
        break;
      default:
        timeElapsed = time;
        break;
    }
  }

  changeStatus() {
    switch (status) {
      case TaskStatus.start:
        status = TaskStatus.running;
        break;
      case TaskStatus.running:
        status = TaskStatus.paused;
        break;
      case TaskStatus.paused:
        status = TaskStatus.running;
        break;
      default:
        status = TaskStatus.start;
    }
  }
}
