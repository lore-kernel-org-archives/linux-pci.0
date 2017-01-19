Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752889AbdASOiW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jan 2017 09:38:22 -0500
Date: Thu, 19 Jan 2017 08:38:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        darcari@redhat.com, mstowe@redhat.com, bhelgaas@google.com,
        lukas@wunner.de, keith.busch@intel.com,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH] pci: Only disable MSI/X and enable INTx if shutdown
 function has been called
Message-ID: <20170119143804.GB12124@bhelgaas-glaptop.roam.corp.google.com>
References: <1478627867-28795-1-git-send-email-prarit@redhat.com>
 <20161109170529.GJ14322@bhelgaas-glaptop.roam.corp.google.com>
 <58541AC6.90900@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58541AC6.90900@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 16, 2016 at 11:48:06AM -0500, Prarit Bhargava wrote:
> On 11/09/2016 12:05 PM, Bjorn Helgaas wrote:
> > Hi Prarit,
> > 
> > Is there a bugzilla or other archive of configuration/dmesg/other info
> > related to this problem?  I'd really like to connect this fix to a
> > problem report, and it would help me review the patch as well.
> 
> Bjorn, have you had a chance to look at this?
> 
> I had opened
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=187351

Hi Prarit,

Sorry, I've not had a chance to dig into this yet.  What I'd *like* to do
is figure out what the kexec/kdump/shutdown strategy really is and make
sure this is all coherent.  It seems like we've gone back and forth on this
a couple times because this or that is broken, but I don't really
understand why.

> > On Tue, Nov 08, 2016 at 12:57:47PM -0500, Prarit Bhargava wrote:
> >> Bjorn,
> >>
> >> We have seen this at Red Hat on various drivers: nouveau, ahci, mei_me, and
> >> pcieport (so far).  Google search for "unhandled irq 16" yields many results
> >> reporting similar behavior during shutdown indicating that this problem is
> >> widespread.  I can cause this to happen on a "stable" system by adding a 3
> >> second delay in pci_device_shutdown() which causes the number of spurious
> >> interrupts to exceed the 100000 limit and display the warning below for the
> >> primarily the nouveau driver, and occasionally for the other mentioned drivers.
> >>
> >> A patch for this was proposed and rejected here for being too risky:
> >>
> >> https://patchwork.kernel.org/patch/5990701/
> >>
> >> I also originally posted a patch to resolve this here:
> >>
> >> http://marc.info/?l=linux-pci&m=147705209308588&w=2
> >>
> >> and several other patch suggestions were made.  The problem with all of these
> >> solutions is that there is some risk associated with them (kdump, kvm, etc.)
> >> and they are papering over the real issue that the PCI shutdown should not
> >> blindly switch to INTx for all devices.
> >>
> >> I am reproposing the original suggested patch.  There is some risk associated
> >> with this but I don't think it is any more or any less than the other patches,
> >> and it seems like the other patches are only applying band-aids to the problem.
> >>
> >> [Aside: Lukas Wunner asked why does this always happen on IRQ 16 (even when the
> >> legacy device says IRQ 32 in lspci)?
> >>
> >> The PCI irq pins A, B, C, and D are routed according to the ACPI _PRT table for
> >> the device.  _In general_, I have noted a consistent pattern for PCI irq pins
> >> such that
> >>
> >> 	irq pin A is IRQ 0x10 (16)
> >> 	irq pin B is IRQ 0x11 (17)
> >> 	irq pin C is IRQ 0x12 (18)
> >> 	irq pin D is IRQ 0x13 (19)
> >>
> >> Since the device's IRQ is hooked up to pin A we're seeing the unhandled
> >> interrupt on IRQ 16.]
> >>
> >> I have tested this on various systems with KVM and kdump (and kdump on
> >> KVM) and didn't see any issues.
> >>
> >> NOTE: In my testing this resolves the problem with PCI based serial ports
> >> cutting off their output during shutdown.  Again, this can be tracked to the
> >> PCI shutdown path switching between MSI & INTx independently of the driver.
> >>
> >> ----8<----
> >>
> >> The following unhandled IRQ warning is seen during shutdown:
> >>
> >> irq 16: nobody cared (try booting with the "irqpoll" option)
> >> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
> >> Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/01/2016
> >>  0000000000000000 ffff88041f803e70 ffffffff81333bd5 ffff88041cb78200
> >>  ffff88041cb7829c ffff88041f803e98 ffffffff810d9465 ffff88041cb78200
> >>  0000000000000000 0000000000000028 ffff88041f803ed0 ffffffff810d97bf
> >> Call Trace:
> >>  <IRQ>  [<ffffffff81333bd5>] dump_stack+0x63/0x8e
> >>  [<ffffffff810d9465>] __report_bad_irq+0x35/0xd0
> >>  [<ffffffff810d97bf>] note_interrupt+0x20f/0x260
> >>  [<ffffffff810d6b35>] handle_irq_event_percpu+0x45/0x60
> >>  [<ffffffff810d6b7c>] handle_irq_event+0x2c/0x50
> >>  [<ffffffff810da31a>] handle_fasteoi_irq+0x8a/0x150
> >>  [<ffffffff8102edfb>] handle_irq+0xab/0x130
> >>  [<ffffffff81082391>] ? _local_bh_enable+0x21/0x50
> >>  [<ffffffff817064ad>] do_IRQ+0x4d/0xd0
> >>  [<ffffffff81704502>] common_interrupt+0x82/0x82
> >>  <EOI>  [<ffffffff815d0181>] ? cpuidle_enter_state+0xc1/0x280
> >>  [<ffffffff815d0174>] ? cpuidle_enter_state+0xb4/0x280
> >>  [<ffffffff815d0377>] cpuidle_enter+0x17/0x20
> >>  [<ffffffff810bf660>] cpu_startup_entry+0x220/0x3a0
> >>  [<ffffffff816f6da7>] rest_init+0x77/0x80
> >>  [<ffffffff81d8e147>] start_kernel+0x495/0x4a2
> >>  [<ffffffff81d8daa0>] ? set_init_arg+0x55/0x55
> >>  [<ffffffff81d8d120>] ? early_idt_handler_array+0x120/0x120
> >>  [<ffffffff81d8d5d6>] x86_64_start_reservations+0x2a/0x2c
> >>  [<ffffffff81d8d715>] x86_64_start_kernel+0x13d/0x14c
> >>
> >> pci_device_shutdown() is called on each PCI device, and does
> >>
> >>         if (drv && drv->shutdown)
> >>                 drv->shutdown(pci_dev);
> >>         pci_msi_shutdown(pci_dev);
> >>         pci_msix_shutdown(pci_dev);
> >>
> >> The pci_msi_shutdown() and pci_msix_shutdown() functions both call
> >> pci_intx_for_msi() which enables the INTx interrupt asynchronously of the
> >> driver.
> >>
> >> The problem is that the driver may not have a shutdown function and the
> >> device remains active.  The driver continues to operate the PCI device and the
> >> device interrupts to generate INTx.  The driver, however, has not registered a
> >> handler for INTx and the interrupt line remains set which leads to an unhandled
> >> IRQ warning.
> >>
> >> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> >> Cc: alex.williamson@redhat.com
> >> Cc: darcari@redhat.com
> >> Cc: mstowe@redhat.com
> >> Cc: bhelgaas@google.com
> >> Cc: lukas@wunner.de
> >> Cc: keith.busch@intel.com
> >> Cc: mika.westerberg@linux.intel.com
> >> ---
> >>  drivers/pci/pci-driver.c |    7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >> index 1ccce1cd6aca..87c35db5a564 100644
> >> --- a/drivers/pci/pci-driver.c
> >> +++ b/drivers/pci/pci-driver.c
> >> @@ -461,10 +461,11 @@ static void pci_device_shutdown(struct device *dev)
> >>  
> >>  	pm_runtime_resume(dev);
> >>  
> >> -	if (drv && drv->shutdown)
> >> +	if (drv && drv->shutdown) {
> >>  		drv->shutdown(pci_dev);
> >> -	pci_msi_shutdown(pci_dev);
> >> -	pci_msix_shutdown(pci_dev);
> >> +		pci_msi_shutdown(pci_dev);
> >> +		pci_msix_shutdown(pci_dev);
> >> +	}
> >>  
> >>  	/*
> >>  	 * If this is a kexec reboot, turn off Bus Master bit on the
> >> -- 
> >> 1.7.9.3
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
