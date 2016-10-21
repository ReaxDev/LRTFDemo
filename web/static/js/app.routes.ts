import {Routes, RouterModule} from '@angular/router';

import {Chat} from './chat';

export const routes: Routes = [
    {path: '', pathMatch: 'full', redirectTo: '/rooms/lobby'},
    {path: 'rooms/:room', component: Chat, pathMatch: 'full'},
];

export const routing = RouterModule.forRoot(routes);