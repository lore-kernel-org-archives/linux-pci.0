Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49419 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757332AbbIUS4I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2015 14:56:08 -0400
Date: Mon, 21 Sep 2015 14:56:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Roland Weber <r-o-l@web.de>
cc: linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
In-Reply-To: <trinity-6fe55839-fa6d-4fe3-81cc-32af1961ceac-1442775309104@3capp-webde-bs04>
Message-ID: <Pine.LNX.4.44L0.1509211435230.1713-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 20 Sep 2015, Roland Weber wrote:

> Hi Alan, hi all,
> 
> in my previous mail, I wrote:
> > With "make menuconfig", I haven't been able to switch off the
> > setting, because CONFIG_PM_SLEEP and something else forces it on
> 
> For the records, there are no menu entries for CONFIG_PM_SLEEP
> and CONFIG_HIBERNATE_CALLBACKS. Those are enabled implicitly.
> I had to disable "Linux guest support" within section
> "Processor types and features" to switch off CONFIG_PM.
> 
> I've now compiled two 4.2 kernels with extra debug output:
> -f: CONFIG_PM enabled, the kernel freezes on unbind
> -g: CONFIG_PM disabled, the kernel does not freeze
> I also compiled two other 4.2 kernels where I replaced the
> alloc_workqueue with alloc_ordered_workqueue. That undoes
> the change from 3.17 to 3.18 which unearthed the problem.
> However, those two kernels behave no differently from the
> two above. Apparently, there have been other changes since
> 3.18 which also result in the revised order of initialization.
> I don't plan to pursue that legacy route any longer.
> 
> I've put ehci_info statements in ehci_suspend and ehci_resume,
> but there's no output from them. See below for details. Next,
> I'll try to remove the usb_enable_autosuspend(hdev) calls.
> 
> cheers and thanks,
>   Roland
> 
> = kernel -f, the one which freezes =

Did you turn off the computer before booting these kernels (i.e., a
"cold" boot) or did you reboot when the machine was already running (a
"warm" boot)?

It may make a difference.  I'm beginning to suspect the problem is
caused by the BIOS.  Have you checked to see if any BIOS updates are
available?

Here's a significant part of the -f kernel log:

> [    1.012653] pci 0000:00:02.0: Video device with shadowed ROM
> [    2.613000] pci 0000:00:1d.0: EHCI: BIOS handoff failed (BIOS bug?) 01010001
> [    2.613126] PCI: CLS 64 bytes, default 64

Here's the corresponding part of the -g kernel log:

> [    1.017430] pci 0000:00:02.0: Video device with shadowed ROM
> [    1.017971] PCI: CLS 64 bytes, default 64

See the difference?  A similarly relevant difference shows up in the
"registers" file.  For the -f kernel:

> /sys/kernel/debug/usb/ehci/0000:00:1d.0/registers now contains:
> bus pci, device 0000:00:1d.0
> EHCI Host Controller
> EHCI 1.00, rh state suspended
> ownership 01000001 linux

and for the -g kernel:

> /sys/kernel/debug/usb/ehci/0000:00:1d.0/registers now contains:
> bus pci, device 0000:00:1d.0
> EHCI Host Controller
> EHCI 1.00, rh state running
> ownership 00000001

The difference in "rh state" is caused by the CONFIG_PM change.  But
the difference in the ownership values is a direct consequence of the
BIOS's behavior.

If there is no BIOS update for you to install, or if it still doesn't
work, there are a few other thing you can try.  Under a kernel with 
CONFIG_PM enabled, before unbinding the driver try doing:

	echo on >/sys/bus/pci/devices/0000:00:1d.0/usb3/power/control

That alone might cause the system to freeze, but if it doesn't then 
there's a good chance the unbind and shutdown won't either.

Here's another experiment.  At the start of ehci_halt(), before the
spin_lock_irq(), add this:

	if (ehci->rh_state == EHCI_RH_SUSPENDED) {
		ehci_writel(ehci, CMD_RUN, &ehci->regs->command);
		msleep(10);
	}

This may end up doing about the same thing as the previous test.  Let's 
see.

Alan Stern

