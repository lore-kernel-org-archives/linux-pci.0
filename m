Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:49794 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191AbbILK5M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 12 Sep 2015 06:57:12 -0400
MIME-Version: 1.0
Message-ID: <trinity-a551d763-5359-4caa-9985-2b89ecf7161d-1442055427110@3capp-webde-bs34>
From: "Roland Weber" <r-o-l@web.de>
To: "Alan Stern" <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org
Cc: "Mathias Nyman" <mathias.nyman@intel.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2015 12:57:07 +0200
In-Reply-To: <Pine.LNX.4.44L0.1509101544130.1422-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1509101544130.1422-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

I'm sending a "Reply to all" on this mail. Should I continue to keep
Mathias and Bjorn on copy and cross-posting to linux-pci@ (I'm not
yet subscribed there, so that post probably won't get through anyway)?

> [Roland, what happens if you try unbinding xhci-hcd before ehci-hcd?  
> Note that unbinding xhci-hcd will cause your wireless keyboard & mouse
> to stop working, so you'll have to use a shell script or a network
> login to run the test.]

The outcome is the same, the system freezes on the readl.
See below for the transcript from a screen photo.

> I say this may be relevant because Roland found that ehci-hcd was
> unable to communicate over the USB bus if it tried to do so before
> xhci-hcd was probed.  This happens in the 3.17 or earlier kernel -- and
> that kernel doesn't suffer the freeze problem.

I can also produce the freeze on 3.17, with some extra steps:

(after boot there's just the ehci-pci bus with no device)
- unbind ehci-pci
- bind ehci-pci
(now the ehci-pci bus has the missing device)
- unbind ehci-pci

So the only reason why the older kernels didn't freeze is that
the device in question couldn't be initialized with the original
probe sequence. I'll try your blacklisting tip over the weekend.

Thanks and cheers,
  Roland

[transcript]

root@Nightwing# cat ./xhci-ehci-unbind
#!/bin/bash
echo 0000:00:14.0 > /sys/bus/pci/drivers/xhci_hcd/unbind
echo 0000:00:1d.0 > /sys/bus/pci/drivers/ehci-pci/unbind
root@Nightwing# echo 8 > /proc/sys/kernel/printk
root@Nightwing# ./xhci-ehci-unbind
[...] xhci_hcd 0000:00:14.0: remove, state 4
[...] xhci_hcd 0000:00:14.0: roothub graceful disconnect
[...] usb usb2: USB disconnect, device number 1
[...] usb_remove_hcd: calling stop
[...] usb_remove_hcd: returned from stop
[...] usb_remove_hcd: after del_timer_sync
[...] xhci_hcd 0000:00:14.0: USB bus 2 deregistered
[...] xhci_hcd 0000:00:14.0: remove, state 1
[...] xhci_hcd 0000:00:14.0: roothub graceful disconnect
[...] usb usb1: USB disconnect, device number 1
[...] usb 1-2: USB disconnect, device number 2
[...] usb 1-2.1: USB disconnect, device number 4
[...] xhci_hcd 0000:00:14.0: shutdown urb ffff8800727b3300 ep1in-intr
[...] usb 1-4: USB disconnect, device number 3
[...] xhci_hcd 0000:00:14.0: shutdown urb ffff8800725ac780 ep1in-intr
[...] usb_remove_hcd: calling stop
[...] usb_remove_hcd: returned from stop
[...] usb_remove_hcd: after del_timer_sync
[...] xhci_hcd 0000:00:14.0: USB bus 1 deregistered
[...] ehci-pci 0000:00:1d.0: remove, state 4
[...] ehci-pci 0000:00:1d.0: roothub graceful disconnect
[...] usb 3-1: USB disconnect, device number 2
[...] usb 3-1: ep 81: release intr @ 8+64 (1.0+256) [1/0 us] mask 0001
[...] usb_remove_hcd: calling stop
[...] ehci-pci 0000:00:1d.0: stop
[...] ehci_silence_controller: entry
[...] ehci_halt: entry
[...] ehci_halt: after spin_lock_irq
[...] ehci_halt: about to readl prematurely
[...] ehci_halt: premature readl returned 10000
[...] ehci_halt: after first ehci_writel
[...] ehci_halt: before ehci_readl
