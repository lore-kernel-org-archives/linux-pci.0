Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56627 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750923AbbIJUj6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 16:39:58 -0400
Date: Thu, 10 Sep 2015 16:39:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Roland Weber <r-o-l@web.de>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
In-Reply-To: <trinity-0fee572f-a3a9-4e96-92f5-b2f753a6bca1-1441909189824@3capp-webde-bs43>
Message-ID: <Pine.LNX.4.44L0.1509101544130.1422-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Mathias, Bjorn, and other PCI people:

I need help with a problem affecting certain Acer computers such as the
netbook model in $SUBJECT.  More information about the system in
question is available at

	https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1485057

In short, the problem is that the ehci-hcd driver causes the system to
hang at various times.  Roland has done a whole bunch of debugging and
narrowed one failure mode down to a particular line of source code in
the 4.2 kernel.

In drivers/usb/host/ehci-hcd.c, the ehci_halt() function looks like 
this:

	spin_lock_irq(&ehci->lock);

	/* disable any irqs left enabled by previous code */
	ehci_writel(ehci, 0, &ehci->regs->intr_enable);

	if (ehci_is_TDI(ehci) && !tdi_in_host_mode(ehci)) {
		spin_unlock_irq(&ehci->lock);
		return 0;
	}

	/*
	 * This routine gets called during probe before ehci->command
	 * has been initialized, so we can't rely on its value.
	 */
	ehci->command &= ~CMD_RUN;
	temp = ehci_readl(ehci, &ehci->regs->command);
	temp &= ~(CMD_RUN | CMD_IAAD);
	ehci_writel(ehci, temp, &ehci->regs->command);

	spin_unlock_irq(&ehci->lock);

[ehci_writel() and ehci_readl() are wrappers around the standard
readl()/writel() or readl_be()/writel_be() routines.  The choice of
endianness may be determined at build time (by Kconfig options) or at
run time (by hardware settings).  The routines are defined in ehci.h if
you want to see the details.]

By inserting printk() lines, Roland found that the first ehci_writel()
call works okay.  The condition in the "if" statement is false, so the
early return is not taken.  The ehci_readl() causes the system to
freeze, so the second ehci_writel() never gets executed.

Oddly, this same function gets called as part of the probe sequence, 
and it works fine then.  But it hangs later on when Roland tries to 
unbind ehci-hcd from the host controller device.  One important 
difference that may be relevant is that ehci-hcd gets probed before 
xhci-hcd, whereas the unbind occurs after xhci-hcd has been probed.

I say this may be relevant because Roland found that ehci-hcd was
unable to communicate over the USB bus if it tried to do so before
xhci-hcd was probed.  This happens in the 3.17 or earlier kernel -- and
that kernel doesn't suffer the freeze problem.  This suggests there is
some unwanted interaction or interference between the two drivers.

In fact, Roland traced the problem to a single line in commit
638139eb95d2.  That line made the USB hub work queue multi-threaded
rather than single-threaded, which accounts for the difference in
probing order but otherwise seems totally unrelated.

[Roland, what happens if you try unbinding xhci-hcd before ehci-hcd?  
Note that unbinding xhci-hcd will cause your wireless keyboard & mouse
to stop working, so you'll have to use a shell script or a network
login to run the test.]

Does anyone have any idea what could cause this simple readl() call to
freeze?


On Thu, 10 Sep 2015, Roland Weber wrote:

> Hi Alan,
> 
> > The only reason I can think of why it might hang is if some clock got 
> > turned off.  But I don't know of any clock which would have that 
> > effect, or which would get turned off before we reach this point.
> > 
> > I also don't understand why the ehci_readl() would freeze when the 
> > preceding ehci_writel() succeeded.  Can you try putting a copy of the 
> > ehci_readl() line just before the ehci_writel(), to see if it will work 
> > there?
> 
> Done:
>         printk(KERN_INFO "ehci_halt: about to readl prematurely\n");
>         temp = ehci_readl(ehci, &ehci->regs->command);
>         printk(KERN_INFO "ehci_halt: premature readl returned %x\n", temp);
> 
>         /* disable any irqs left enabled by previous code */
>         ehci_writel(ehci, 0, &ehci->regs->intr_enable);
>         printk(KERN_INFO "ehci_halt: after first ehci_writel\n");
> 
> It works there. Result:
> premature readl returned 10000

That's what it should be.

Alan Stern

