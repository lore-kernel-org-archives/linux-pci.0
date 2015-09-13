Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:63878 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbbIMPpM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 13 Sep 2015 11:45:12 -0400
MIME-Version: 1.0
Message-ID: <trinity-7f2ca9f3-c478-4d8d-9bb9-7656c1fc6333-1442159105440@3capp-webde-bs07>
From: "Roland Weber" <r-o-l@web.de>
To: linux-usb@vger.kernel.org
Cc: "Mathias Nyman" <mathias.nyman@intel.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Sep 2015 17:45:05 +0200
In-Reply-To: <Pine.LNX.4.44L0.1509121341080.13622-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1509121341080.13622-100000@netrider.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan, hi all,

> > I can also produce the freeze on 3.17, with some extra steps:
> 
> Okay, that's worth knowing.
> 
> > (after boot there's just the ehci-pci bus with no device)
> > - unbind ehci-pci
> > - bind ehci-pci
> 
> During both the unbind and the bind, the debugging lines you added to
> ehci-hcd.c should show up.  Do they?

I'm afraid my statement wasn't entirely accurate. I was using a
precompiled kernel 3.17.8 (not 3.17 plain) without my debugging lines.
>From the regular kernel debug output, I get:

(first unbind)
ehci-pci 0000:00:1d.0: remove, state 4
usb usb1: USB disconnect, device number 1
ehci-pci 0000:00:1d.0: USB bus 1 deregistered

(bind)
ehci-pci 0000:00:1d.0: EHCI Host Controller
ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:1d.0: debug port 2
ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
ehci-pci 0000:00:1d.0: irq 23, io mem 0x90918000
ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 3.17.8-031708-generic ehci_hcd
usb usb1: SerialNumber 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
usb 1-1: new high-speed USB device number 2 using ehci-pci
usb 1-1: New USB device found, idVendor=8087, idProduct=07e6
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected

(second unbind)
ehci-pci 0000:00:1d.0: remove, state 4
usb usb1: USB disconnect, device number 1
usb 1-1: USB disconnect, device number 2
(freeze)


I compiled a kernel 3.17(.0) with my additional debug lines...
and this one does NOT freeze! The output is:

(first unbind)
ehci-pci 0000:00:1d.0: remove, state 4
ehci-pci 0000:00:1d.0: roothub graceful disconnect
usb usb1: USB disconnect, device number 1
ehci-pci 0000:00:1d.0: shutdown urb ffff880072bf4300 ep1in-intr
usb_remove_hcd: calling stop
ehci-pci 0000:00:1d.0: stop
ehci_silence_controller: entry
ehci_halt: entry
ehci_halt: after spin_lock_irq
ehci_halt: about to readl prematurely
ehci_halt: premature readl returned 10001
ehci_halt: after first ehci_writel
ehci_halt: before ehci_readl
ehci_halt: after ehci_readl, before ehci_writel
ehci_halt: after second ehci_writel
ehci_halt: after spin_unlock_irq
ehci_halt: after_synchronize_irq, before ehci_handshake
ehci_silence_controller: after ehci_silence_controller
ehci-pci 0000:00:1d.0: reset command 0010002 (park)=0 ithresh=1 period=1024 Reset HALT
ehci-pci 0000:00:1d.0: ehci_stop completed status 1000 Halt
usb_remove_hcd: returned from stop
usb_remove_hcd: after del_timer_sync
ehci-pci 0000:00:1d.0: USB bus 1 deregistered

(bind)
ehci-pci 0000:00:1d.0: EHCI Host Controller
ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:1d.0: debug port 2
ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
ehci-pci 0000:00:1d.0: reset hcs_params 0x200008 dbg=2 cc=0 pcc=0 ordered !ppc ports=8
ehci-pci 0000:00:1d.0: reset hcc_params 36881 caching frame 1024 64 bit addr
ehci_halt: entry
ehci_halt: after spin_lock_irq
ehci_halt: about to readl prematurely
ehci_halt: premature readl returned 80000
ehci_halt: after first ehci_writel
ehci_halt: before ehci_readl
ehci_halt: after ehci_readl, before ehci_writel
ehci_halt: after second ehci_writel
ehci_halt: after spin_unlock_irq
ehci_halt: after_synchronize_irq, before ehci_handshake
ehci-pci 0000:00:1d.0: reset command 0010002 (park)=0 ithresh=1 period=1024 Reset HALT
ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
ehci-pci 0000:00:1d.0: supports USB remote wakeup
ehci-pci 0000:00:1d.0: irq 23, io mem 0x90918000
ehci-pci 0000:00:1d.0: init command 0010001 (park)=0 ithresh=1 period=1024 RUN
ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 3.17.0-w ehci_hcd
usb usb1: SerialNumber 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ehci-pci 0000:00:1d.0: GetStatus port:1 status 001803 0 ACK POWER sig=j CSC CONNECT
ehci-pci 0000:00:1d.0: port 1 reset complete, port enabled
ehci-pci 0000:00:1d.0: GetStatus port:1 status 001005 0 ACK POWER sig=se0 PE CONNECT
usb 1-1: new high-speed USB device number 2 using ehci-pci
ehci-pci 0000:00:1d.0: port 1 reset complete, port enabled
ehci-pci 0000:00:1d.0: GetStatus port:1 status 001005 0 ACK POWER sig=se0 PE CO
N
usb 1-1: New USB device found, idVendor=8087, idProduct=07e6
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1: ep 81: reserve intr @ 8+64 (1.0+256) [1/0 us] mask 0001
usb 1-1: link qh256-0001/ffff88007516dcc0 start 1 [1/0 us]

(second unbind)
ehci-pci 0000:00:1d.0: remove, state 1
ehci-pci 0000:00:1d.0: roothub graceful disconnect
usb usb1: USB disconnect, device number 1
usb 1-1: USB disconnect, device number 2
usb 1-1: unlink qh256-0001/ffff88007516dcc0 start 1 [1/0 us]
ehci-pci 0000:00:1d.0: shutdown urb ffff88007516dc00 ep1in-intr
usb_remove_hcd: calling stop
ehci-pci 0000:00:1d.0: stop
ehci_silence_controller: entry
ehci_halt: entry
ehci_halt: after spin_lock_irq
ehci_halt: about to readl prematurely
ehci_halt: premature readl returned 10001
ehci_halt: after first ehci_writel
ehci_halt: before ehci_readl
ehci_halt: after ehci_readl, before ehci_writel
ehci_halt: after second ehci_writel
ehci_halt: after spin_unlock_irq
ehci_halt: after_synchronize_irq, before ehci_handshake
ehci_silence_controller: after ehci_silence_controller
ehci_stop: after ehci_silence_controller
ehci-pci 0000:00:1d.0: reset command 0010002 (park)=0 ithresh=1 period=1024 Reset HALT
ehci-pci 0000:00:1d.0: ehci_stop completed status 1000 Halt
usb_remove_hcd: returned from stop
usb_remove_hcd: after del_timer_sync
ehci-pci 0000:00:1d.0: USB bus 1 deregistered


I cannot yet tell whether the difference between freeze and non-freeze
is due to code changes, or because I used a different kernel config.
(It brings down compilation times from 3h to 2h.)

So next I'll compile 3.17.8 with my config.

cheers and thanks,
  Roland
