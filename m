Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:60034 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754937AbbIMUzU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Sep 2015 16:55:20 -0400
Date: Sun, 13 Sep 2015 16:55:18 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Roland Weber <r-o-l@web.de>
cc: linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
In-Reply-To: <trinity-7f2ca9f3-c478-4d8d-9bb9-7656c1fc6333-1442159105440@3capp-webde-bs07>
Message-ID: <Pine.LNX.4.44L0.1509131649200.19943-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 13 Sep 2015, Roland Weber wrote:

> I compiled a kernel 3.17(.0) with my additional debug lines...
> and this one does NOT freeze! The output is:
> 
> (first unbind)
> ehci-pci 0000:00:1d.0: remove, state 4
> ehci-pci 0000:00:1d.0: roothub graceful disconnect
> usb usb1: USB disconnect, device number 1
> ehci-pci 0000:00:1d.0: shutdown urb ffff880072bf4300 ep1in-intr
> usb_remove_hcd: calling stop
> ehci-pci 0000:00:1d.0: stop
> ehci_silence_controller: entry
> ehci_halt: entry
> ehci_halt: after spin_lock_irq
> ehci_halt: about to readl prematurely
> ehci_halt: premature readl returned 10001

Note: 10001 instead of 10000, which is what you saw in the other 
kernel.  That could be highly relevant.

> I cannot yet tell whether the difference between freeze and non-freeze
> is due to code changes, or because I used a different kernel config.
> (It brings down compilation times from 3h to 2h.)
> 
> So next I'll compile 3.17.8 with my config.

On Sun, 13 Sep 2015, Roland Weber wrote:

> Actually, it made more sense to try other precompiled kernels.
> I can freeze the precompiled 3.17.0 with unbind/bind/unbind,
> but not the one I compiled myself. I'm currently compiling
> 3.17.0 with the exact config of the precompiled kernel, to
> rule out differences in the build environment as the cause.
> 
> Assuming that this kernel does freeze, I will start to 'bisect' the
> differences in the kernel configurations, based on the assumption
> that it might give us a clue about where the problem comes from.
> I expect this to take several days... please stop me if you've got
> a better lead.

At some point along the way, can you try adding some printk statements 
to ehci_suspend() and ehci_resume() in ehci-hcd.c?  I'd like to know if 
they get called during the bind/unbind procedure and are responsible 
for that 10001 vs. 10000 value.

Alan Stern

