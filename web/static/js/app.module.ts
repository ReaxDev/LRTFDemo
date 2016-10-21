import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';
import {FormsModule}   from '@angular/forms';
import {routing} from './app.routes';
import {HttpModule} from '@angular/http';
import {Chat} from './chat';
import {NavBarComponent} from './navbar.component';
import { MaterializeModule } from 'angular2-materialize';
import "materialize-css";
import { SocketService } from './services/socket.service';
import {AppComponent} from './app/app.component';
import {DataService} from "./services/data.service";

@NgModule({
    imports: [
        BrowserModule,
        FormsModule,
        routing,
        HttpModule,
        MaterializeModule
    ],
    declarations: [
        AppComponent,
        Chat,
        NavBarComponent
    ],
    providers: [SocketService, DataService],
    bootstrap: [AppComponent]
})
export class AppModule {}