Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61866 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab2DPSHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 14:07:05 -0400
Received: by pbcun15 with SMTP id un15so6636501pbc.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 11:07:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F8BEB1D.9080903@fold.natur.cuni.cz>
References: <4F6A483D.50702@fold.natur.cuni.cz>
	<CAE9FiQVnErU-cska4gpinyj-LOup-U+3vsEG2z_-7h6kyREYtw@mail.gmail.com>
	<4F6A5A53.305@fold.natur.cuni.cz>
	<CAE9FiQXP7fO9OGN557jdofFFiFj96wL--ZA8X3UPEJ6o9JLvBw@mail.gmail.com>
	<4F8BEB1D.9080903@fold.natur.cuni.cz>
Date: Mon, 16 Apr 2012 11:07:04 -0700
Message-ID: <CAE9FiQXoX3J6P_9Tun_XbkK3egvSeBZxAtC13HacFDO0fwmZaA@mail.gmail.com>
Subject: Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
From: Yinghai Lu <yinghai@kernel.org>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2012 at 2:49 AM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Hi Yinghai,
>
> Yinghai Lu wrote:
>> On Wed, Mar 21, 2012 at 3:46 PM, Martin Mokrejs
>   I had some Ooopses with 3.4-rc2 but now I have tested 3.4-rc3. Still, linux
> does NOT realize that I have removed an ExpressCard from the slot. It realizes
> that only when I pluging the card back again. Actually, this is a case of a
> NEC chipset base USB3.0 card.
>
>  In contrast, kernel DOES recognize that I unplugged a FireWire card from the
> same slot.
>
>  This is a Dell Vostro 3550 laptop. Below is what syslog logged with my comment.
> Empty lines between the log entries are inserted whe I either inserted or removed
> a card. Probably a bit more will be in the attached dmesg file.
>
>
> INSERTING CARD
>
> Apr 16 11:26:08 vostro kernel: [  126.849689] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> Apr 16 11:26:08 vostro kernel: [  126.970840] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c00000-0xf6c01fff 64bit]
..
> Apr 16 11:26:08 vostro kernel: [  126.971030] xhci_hcd 0000:11:00.0: enabling device (0100 -> 0102)
> Apr 16 11:26:08 vostro kernel: [  126.971084] xhci_hcd 0000:11:00.0: xHCI Host Controller
> Apr 16 11:26:08 vostro kernel: [  126.971092] xhci_hcd 0000:11:00.0: new USB bus registered, assigned bus number 5
> Apr 16 11:26:08 vostro kernel: [  126.971400] xhci_hcd 0000:11:00.0: irq 19, io mem 0xf6c00000
...
>
> REMOVED CARD
>
> note (nothing happend)
>
> RE-INSERTED CARD
>
> Apr 16 11:28:42 vostro kernel: [  280.514490] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> Apr 16 11:28:42 vostro kernel: [  280.514766] xhci_hcd 0000:11:00.0: remove, state 4
> Apr 16 11:28:42 vostro kernel: [  280.514771] usb usb6: USB disconnect, device number 1
> Apr 16 11:28:42 vostro kernel: [  280.514900] xhci_hcd 0000:11:00.0: Host not halted after 16000 microseconds.
> Apr 16 11:28:42 vostro kernel: [  280.514903] xhci_hcd 0000:11:00.0: USB bus 6 deregistered
> Apr 16 11:28:42 vostro kernel: [  280.514908] xhci_hcd 0000:11:00.0: remove, state 4
> Apr 16 11:28:42 vostro kernel: [  280.514911] usb usb5: USB disconnect, device number 1
> Apr 16 11:28:42 vostro kernel: [  280.515071] xhci_hcd 0000:11:00.0: Host not halted after 16000 microseconds.
> Apr 16 11:28:42 vostro kernel: [  280.515170] xhci_hcd 0000:11:00.0: USB bus 5 deregistered

So get the interrupt for surprise removal only just after put the card back?

> Apr 16 11:28:42 vostro kernel: [  280.530950] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> Apr 16 11:28:42 vostro kernel: [  280.655913] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c00000-0xf6c01fff 64bit]
> Apr 16 11:28:42 vostro kernel: [  280.655957] pcieport 0000:00:1c.7: PCI bridge to [bus 11-16]
> Apr 16 11:28:42 vostro kernel: [  280.655960] pcieport 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
> Apr 16 11:28:42 vostro kernel: [  280.655965] pcieport 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
> Apr 16 11:28:42 vostro kernel: [  280.655969] pcieport 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
> Apr 16 11:28:42 vostro kernel: [  280.656108] xhci_hcd 0000:11:00.0: enabling device (0100 -> 0102)
...

>
> Now I took a DIFFERENT card: Axago ECF-X1 providing 2x 1394a
>
> INSERTED CARD
>
> Apr 16 11:29:51 vostro kernel: [  350.147852] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> Apr 16 11:29:51 vostro kernel: [  350.148133] xhci_hcd 0000:11:00.0: remove, state 4
> Apr 16 11:29:51 vostro kernel: [  350.148138] usb usb6: USB disconnect, device number 1
> Apr 16 11:29:51 vostro kernel: [  350.148311] xhci_hcd 0000:11:00.0: Host not halted after 16000 microseconds.
> Apr 16 11:29:51 vostro kernel: [  350.148316] xhci_hcd 0000:11:00.0: USB bus 6 deregistered
> Apr 16 11:29:51 vostro kernel: [  350.148322] xhci_hcd 0000:11:00.0: remove, state 4
> Apr 16 11:29:51 vostro kernel: [  350.148326] usb usb5: USB disconnect, device number 1
> Apr 16 11:29:51 vostro kernel: [  350.148519] xhci_hcd 0000:11:00.0: Host not halted after 16000 microseconds.
> Apr 16 11:29:51 vostro kernel: [  350.148612] xhci_hcd 0000:11:00.0: USB bus 5 deregistered

after you insert firewire card, it got surprise remove interrupt...

> Apr 16 11:29:51 vostro kernel: [  350.156812] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)

> Apr 16 11:29:52 vostro kernel: [  350.277415] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c00000-0xf6c007ff 64bit]
> Apr 16 11:29:52 vostro kernel: [  350.277442] pci 0000:11:00.0: BAR 2: assigned [io  0xc000-0xc0ff]
> Apr 16 11:29:52 vostro kernel: [  350.277458] pcieport 0000:00:1c.7: PCI bridge to [bus 11-16]
> Apr 16 11:29:52 vostro kernel: [  350.277473] pcieport 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
> Apr 16 11:29:52 vostro kernel: [  350.277478] pcieport 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
> Apr 16 11:29:52 vostro kernel: [  350.277482] pcieport 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
> Apr 16 11:29:52 vostro kernel: [  350.363314] firewire_ohci 0000:11:00.0: enabling device (0100 -> 0103)
> Apr 16 11:29:52 vostro kernel: [  350.437174] firewire_ohci 0000:11:00.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x11
> Apr 16 11:29:52 vostro kernel: [  350.936323] firewire_core 0000:11:00.0: created device fw0: GUID 0011066600000003, S400
>

please check boot with pciehp.pciehp_debug=1

also you could use tail -f /var/log/messages to get more timely outputs.

Thanks

Yinghai
