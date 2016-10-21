import {Component, OnInit, AfterViewChecked, ElementRef} from '@angular/core';
import {ActivatedRoute} from "@angular/router";
import {DataService} from "../services/data.service";
import {SocketService} from "../services/socket.service";
import {ViewChild} from "@angular/core";

@Component({
    selector: 'chat',
    styles: [require('./chat.component.css')],
    template: require('./chat.component.html')
})
export default class ChatComponent implements OnInit, AfterViewChecked {
    @ViewChild('messagesContainer') private messagesContainer: ElementRef;

    public room: string;
    public message: string;
    public messages: [string];
    public channelId: string;

    constructor(private route: ActivatedRoute, private dataService: DataService, private socketService: SocketService) {
        this.messages = [];

        this.route.params.subscribe((params) => {
            this.room = params.room;
            let channelId: string = `rooms:${this.room}`;
            this.channelId = channelId;

            this.socketService
                .joinChannel(channelId)
                .subscribe(() => {
                    this.socketService.sendGetMessages(channelId);
                });


            this.dataService.getRoom(channelId).messages.subscribe((value) => {
                this.message = "";
                if (value instanceof Array) {
                    this.messages = value;
                } else {
                    this.messages.push(value);
                }
            });
        })
    }

    ngOnInit() {
        this.scrollToBottom();
    }

    ngAfterViewChecked() {
        this.scrollToBottom();
    }

    scrollToBottom(): void {
        try {
            this.messagesContainer.nativeElement.scrollTop = this.messagesContainer.nativeElement.scrollHeight;
        } catch(err) { }
    }

    sendMessage(message) {
        this.socketService.sendMessage(this.channelId, "new_msg", message).subscribe();
    }
}