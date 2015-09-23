Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37761 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755454AbbIWPH1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 11:07:27 -0400
Date: Wed, 23 Sep 2015 11:07:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Roland Weber <r-o-l@web.de>
cc: linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
In-Reply-To: <trinity-1e46bbda-8dfe-4ec4-95a2-bfb481c528de-1442957105043@3capp-webde-bs21>
Message-ID: <Pine.LNX.4.44L0.1509231058110.1670-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 22 Sep 2015, Roland Weber wrote:

> Hi Alan,
> 
> > Did you turn off the computer before booting these kernels (i.e., a
> > "cold" boot) or did you reboot when the machine was already running (a
> > "warm" boot)?
> 
> I didn't pay attention to that. Most likely, I prepared the debug session
> on 3.17.8, warm-booted into kernel-f, froze the machine, then cold-booted
> into kernel-g.
> Now I tried again, making sure to cold-boot into both kernels. The
> differences you noticed are gone, both -f and -g behave as listed for -g.
> See below for the full output. And -f still freezes, while -g does not.
> 
> > Here's the corresponding part of the -g kernel log:
> > 
> > > [    1.017430] pci 0000:00:02.0: Video device with shadowed ROM
> > > [    1.017971] PCI: CLS 64 bytes, default 64
> [...]
> > and for the -g kernel:
> > 
> > > /sys/kernel/debug/usb/ehci/0000:00:1d.0/registers now contains:
> > > bus pci, device 0000:00:1d.0
> > > EHCI Host Controller
> > > EHCI 1.00, rh state running
> > > ownership 00000001

Okay.  This value for ownership is still wrong, though.

> > Have you checked to see if any BIOS updates are available?
> 
> The machine is on v1.08, there have been two updates since:
> v1.13: 1. add Elan touchpad support
>        2. update EC to v1.5
> v1.10: 1. Add battery ID
> 
> But there's also a guy who reports that external USB drives are
> no longer detected during boot after he updated the BIOS to v1.10.
> http://community.acer.com/t5/E-and-M-Series/Acer-ES1-111M-doesn-t-detect-USB-Drives-at-boot-phase-anymore/td-p/364139
> 
> Frankly, I don't dare to upgrade the BIOS right now. I need the
> machine in working condition starting Friday next week, until
> around Christmas. I'll be teaching lectures once a week and bought
> the machine to drive the projector. Most of my spare time will be
> consumed by preparing the lectures for the next three months.
> If the machine stops booting from external USB devices, I couldn't
> reinstall it anymore, nor could I flash a fixed BIOS. I'll have
> to set up dual boot with Linux and FreeDOS before I can risk a
> BIOS upgrade. Currently, that doesn't fit into my time budget.

All right.  Maybe at some point in the future.  The thing is, I don't 
want to patch the kernel only to find that the problem has already been 
fixed in a newer BIOS.

> > there are a few other thing you can try.  Under a kernel with 
> > CONFIG_PM enabled, before unbinding the driver try doing:
> > 
> > 	echo on >/sys/bus/pci/devices/0000:00:1d.0/usb3/power/control
> > 
> > That alone might cause the system to freeze
> 
> It does. I tried with kernel-f and got two lines of output:
> usb usb3: usb auto-resume
> ehci-pci 0000:00:1d.0: resume root hub
> (freeze)
> 
> > Here's another experiment.  At the start of ehci_halt(), before the
> > spin_lock_irq(), add this:
> > 
> > 	if (ehci->rh_state == EHCI_RH_SUSPENDED) {
> // I added a printk here
> > 		ehci_writel(ehci, CMD_RUN, &ehci->regs->command);
> > 		msleep(10);
> > 	}
> > 
> > This may end up doing about the same thing as the previous test.
> 
> It does. The last few lines of the debug output are:
> ehci_halt: entry
> ehci_halt: EHCI_RH_SUSPENDED, running patch writel
> ehci_halt: about to readl prematurely
> (freeze)

The unavoidable conclusion is that your system doesn't work right when 
this root hub is suspended.  (I still think it's the BIOS's fault.)

Which suggests yet another test: Under a kernel with CONFIG_PM and
CONFIG_PM_SLEEP enabled, what happens when you suspend the system
(i.e., suspend-to-RAM) and then wake it up?  For this experiment, it
may help to add "no_console_suspend" to the boot command line.

Alan Stern

