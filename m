Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50298 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750980AbbINUgF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 16:36:05 -0400
Date: Mon, 14 Sep 2015 16:36:03 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Roland Weber <r-o-l@web.de>
cc: linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
In-Reply-To: <Pine.LNX.4.44L0.1509131649200.19943-100000@netrider.rowland.org>
Message-ID: <Pine.LNX.4.44L0.1509141624180.1277-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 13 Sep 2015, Alan Stern wrote:

> On Sun, 13 Sep 2015, Roland Weber wrote:
> 
> > I compiled a kernel 3.17(.0) with my additional debug lines...
> > and this one does NOT freeze! The output is:
> > 
> > (first unbind)
> > ehci-pci 0000:00:1d.0: remove, state 4
> > ehci-pci 0000:00:1d.0: roothub graceful disconnect
> > usb usb1: USB disconnect, device number 1
> > ehci-pci 0000:00:1d.0: shutdown urb ffff880072bf4300 ep1in-intr
> > usb_remove_hcd: calling stop
> > ehci-pci 0000:00:1d.0: stop
> > ehci_silence_controller: entry
> > ehci_halt: entry
> > ehci_halt: after spin_lock_irq
> > ehci_halt: about to readl prematurely
> > ehci_halt: premature readl returned 10001
> 
> Note: 10001 instead of 10000, which is what you saw in the other 
> kernel.  That could be highly relevant.

> At some point along the way, can you try adding some printk statements 
> to ehci_suspend() and ehci_resume() in ehci-hcd.c?  I'd like to know if 
> they get called during the bind/unbind procedure and are responsible 
> for that 10001 vs. 10000 value.

There's one other thing I'd like to see as well.  Before doing the 
unbind, save a copy of 
/sys/kernel/debug/usb/ehci/0000:00:1d.0/registers.  Do this for both 
types of kernel (one that gets 10000 for the readl value and one that 
gets 10001).  There ought to be some useful information in them.

Oh, and also let's see what 
/sys/bus/pci/devices/0000:00:1d.0/power/control and
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status contain.

Alan Stern

