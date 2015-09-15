Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56036 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751722AbbIOOT4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 10:19:56 -0400
Date: Tue, 15 Sep 2015 10:19:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Roland Weber <r-o-l@web.de>
cc: linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
In-Reply-To: <trinity-22d19320-d992-458f-a911-d05c6c60a012-1442276254269@3capp-webde-bs08>
Message-ID: <Pine.LNX.4.44L0.1509151010160.1420-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 15 Sep 2015, Roland Weber wrote:

> Hi Alan,
> 
> > > ehci_halt: premature readl returned 10001
> > 
> > Note: 10001 instead of 10000, which is what you saw in the other 
> > kernel.  That could be highly relevant.
> 
> Really? And I thought that was the least significant bit...

It is the least significant bit in the register, but it is the bit that
indicates whether or not the controller is running, which makes it one
of the most important.  :-)

> I had a lucky guess among the 2000+ lines of diff output with
> which I started: CONFIG_PM_RUNTIME makes the difference.
> If it's on, the kernel can freeze.

Aha, good.  I was heading in the same general direction.

> I'll have to add the debug output you asked for tomorrow,
> didn't expect to succeed so soon.
> 
> Should I put the statements into the 3.17 kernel, or should I
> try to compile a 4.2 without CONFIG_PM_RUNTIME instead? And
> would you like the output of a freezing or non-freezing kernel
> first? I'll only be able to try out one tomorrow, the rest
> will follow a day or two later.

As long as the 4.2 kernel can do what you want, you may as well use it.  
However, note that CONFIG_PM_RUNTIME doesn't exist any more in 4.2; it 
is now covered by CONFIG_PM.

Assuming things work out as expected, try this: In core/hub.c, remove 
the calls to usb_enable_autosuspend(hdev) in hub_probe() and leave 
CONFIG_PM enabled.

Alan Stern

