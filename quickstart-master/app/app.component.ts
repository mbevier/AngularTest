import { Component } from '@angular/core';
export class Hero {
  id: number;
  name: string;
}
@Component({
  selector: 'my-app',
  template: `<h1>Hello {{name}}</h1>`,
})


export class AppComponent  {

name = 'Angular';
title = 'Tour of Heroes';
hero: Hero = {
  id: 1,
  name: 'Windstorm' };
}
