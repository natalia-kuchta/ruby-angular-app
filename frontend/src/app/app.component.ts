import {Component, OnInit} from '@angular/core';
import {RouterOutlet} from '@angular/router';
import {FormsModule} from '@angular/forms';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, FormsModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent implements OnInit {
  state: string = 'loading...';
  items: Array<{ id: number, name: string, completed: boolean }> = []
  newTaskName: string = '';

  async fetchTasks() {
    this.state = 'loading...'

    fetch('http://localhost:3000/tasks')
      .then(response => response.json())
      .then(data => {
        this.items = data;
        this.state = 'ready'
      })
  }

  ngOnInit(): void {
    this.fetchTasks()
  }

  async delete(id: number): Promise<void> {
    console.log(id);

    fetch (`http://localhost:3000/tasks/${id}`, {
      method:'delete'
    }).then(() => {
      this.fetchTasks()
    })
  }

  async create(): Promise<void> {
    console.log(this.newTaskName);
    console.log(JSON.stringify({
      name: this.newTaskName,
      completed: false
    }));

    fetch (`http://localhost:3000/tasks`, {
      method:'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        name: this.newTaskName,
        completed: false
      })
    }).then(() => {
      this.fetchTasks()
      this.newTaskName = '';
    })
  }
}
