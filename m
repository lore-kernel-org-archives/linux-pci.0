Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:33157 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936515AbcJXJoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2016 05:44:11 -0400
Date: Mon, 24 Oct 2016 11:44:45 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Myron Stowe <mstowe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFE PATCH] pci: Do not enable intx on MSI-capable devices on
 shutdown
Message-ID: <20161024094445.GA5144@wunner.de>
References: <1477052083-13815-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477052083-13815-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 21, 2016 at 08:14:43AM -0400, Prarit Bhargava wrote:
> The following unhandled IRQ warning is seen during shutdown:
> 
> irq 16: nobody cared (try booting with the "irqpoll" option)
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
> Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/01/2016
>  0000000000000000 ffff88041f803e70 ffffffff81333bd5 ffff88041cb78200
>  ffff88041cb7829c ffff88041f803e98 ffffffff810d9465 ffff88041cb78200
>  0000000000000000 0000000000000028 ffff88041f803ed0 ffffffff810d97bf
> Call Trace:
>  <IRQ>  [<ffffffff81333bd5>] dump_stack+0x63/0x8e
>  [<ffffffff810d9465>] __report_bad_irq+0x35/0xd0
>  [<ffffffff810d97bf>] note_interrupt+0x20f/0x260
>  [<ffffffff810d6b35>] handle_irq_event_percpu+0x45/0x60
>  [<ffffffff810d6b7c>] handle_irq_event+0x2c/0x50
>  [<ffffffff810da31a>] handle_fasteoi_irq+0x8a/0x150
>  [<ffffffff8102edfb>] handle_irq+0xab/0x130
>  [<ffffffff81082391>] ? _local_bh_enable+0x21/0x50
>  [<ffffffff817064ad>] do_IRQ+0x4d/0xd0
>  [<ffffffff81704502>] common_interrupt+0x82/0x82
>  <EOI>  [<ffffffff815d0181>] ? cpuidle_enter_state+0xc1/0x280
>  [<ffffffff815d0174>] ? cpuidle_enter_state+0xb4/0x280
>  [<ffffffff815d0377>] cpuidle_enter+0x17/0x20
>  [<ffffffff810bf660>] cpu_startup_entry+0x220/0x3a0
>  [<ffffffff816f6da7>] rest_init+0x77/0x80
>  [<ffffffff81d8e147>] start_kernel+0x495/0x4a2
>  [<ffffffff81d8daa0>] ? set_init_arg+0x55/0x55
>  [<ffffffff81d8d120>] ? early_idt_handler_array+0x120/0x120
>  [<ffffffff81d8d5d6>] x86_64_start_reservations+0x2a/0x2c
>  [<ffffffff81d8d715>] x86_64_start_kernel+0x13d/0x14c
> 
> pci_device_shutdown() is called on each PCI device, and does
> 
>         if (drv && drv->shutdown)
>                 drv->shutdown(pci_dev);
>         pci_msi_shutdown(pci_dev);
>         pci_msix_shutdown(pci_dev);
> 
> The pci_msi_shutdown() and pci_msix_shutdown() functions both call
> pci_intx_for_msi() which enables the intx interrupt independent of the driver.
> The driver still thinks it is using MSI/X and the result is the above stack
> trace.
> 
> We have seen this at Red Hat on various drivers: nouveau, ahci, and pcieport
> (so far).  Google search for "unhandled irq 16" yields many results reporting
> similar behavior during shutdown indicating that this problem is widespread.

I've occasionally seen this on an Ivy Bridge MacBook Pro as well,
also on IRQ 16.  It's been a major annoyance, so thanks for looking
into this.

Why is this always occurring on IRQ 16, not on any others?  On my
MacBook Pro IRQ 16 is used by a root port (00:1c.0, pcieport),
an Ethernet controller below that root port (02:00.0, tg3) and
a Thunderbolt hotplug bridge (06:03.0, pcieport).  I've never seen
these spurious interrupts on any other IRQ.

The patch looks good, I'm wondering though if it works correctly
with PCI devices passed through to a VM:  When the VM is shut down,
it won't enable INTx any longer.  Not sure if this can cause problems
for the host.

Thanks,

Lukas

> I can cause this to happen on a "stable" system by adding a 3 second delay in
> pci_device_shutdown() which causes the number of spurious interrupts to exceed
> the 100000 limit and display the warning above.  Also note that by adding the
> 3 second delay, NVIDIA devices with device ID 0x0FF* hit this problem 100% of
> the time.
> 
> darcari noticed that removing the pci_intx_for_msi() call resulted in a
> stable system.  After further discussions with Myron and Alex, Alex came up
> idea of keeping the intx disabled during shutdown implemented below.
> 
> ----8<----
> 
> The following unhandled IRQ warning is seen during shutdown:
> 
> irq 16: nobody cared (try booting with the "irqpoll" option)
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
> Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/01/2016
>  0000000000000000 ffff88041f803e70 ffffffff81333bd5 ffff88041cb78200
>  ffff88041cb7829c ffff88041f803e98 ffffffff810d9465 ffff88041cb78200
>  0000000000000000 0000000000000028 ffff88041f803ed0 ffffffff810d97bf
> Call Trace:
>  <IRQ>  [<ffffffff81333bd5>] dump_stack+0x63/0x8e
>  [<ffffffff810d9465>] __report_bad_irq+0x35/0xd0
>  [<ffffffff810d97bf>] note_interrupt+0x20f/0x260
>  [<ffffffff810d6b35>] handle_irq_event_percpu+0x45/0x60
>  [<ffffffff810d6b7c>] handle_irq_event+0x2c/0x50
>  [<ffffffff810da31a>] handle_fasteoi_irq+0x8a/0x150
>  [<ffffffff8102edfb>] handle_irq+0xab/0x130
>  [<ffffffff81082391>] ? _local_bh_enable+0x21/0x50
>  [<ffffffff817064ad>] do_IRQ+0x4d/0xd0
>  [<ffffffff81704502>] common_interrupt+0x82/0x82
>  <EOI>  [<ffffffff815d0181>] ? cpuidle_enter_state+0xc1/0x280
>  [<ffffffff815d0174>] ? cpuidle_enter_state+0xb4/0x280
>  [<ffffffff815d0377>] cpuidle_enter+0x17/0x20
>  [<ffffffff810bf660>] cpu_startup_entry+0x220/0x3a0
>  [<ffffffff816f6da7>] rest_init+0x77/0x80
>  [<ffffffff81d8e147>] start_kernel+0x495/0x4a2
>  [<ffffffff81d8daa0>] ? set_init_arg+0x55/0x55
>  [<ffffffff81d8d120>] ? early_idt_handler_array+0x120/0x120
>  [<ffffffff81d8d5d6>] x86_64_start_reservations+0x2a/0x2c
>  [<ffffffff81d8d715>] x86_64_start_kernel+0x13d/0x14c
> 
> This occurs because the pci_msi_shutdown() and pci_msix_shutdown() functions
> enable the legacy intx interrupt even though the device and driver were not
> configured for legacy intx.
> 
> This patch blocks the enabling of intx during system shutdown or reboot.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: David Arcari <darcari@redhat.com>
> Cc: Myron Stowe <mstowe@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/msi.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index bfdd0744b686..915cc29797f9 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -910,7 +910,8 @@ void pci_msi_shutdown(struct pci_dev *dev)
>  	desc = first_pci_msi_entry(dev);
>  
>  	pci_msi_set_enable(dev, 0);
> -	pci_intx_for_msi(dev, 1);
> +	if (system_state == SYSTEM_RUNNING || system_state == SYSTEM_BOOTING)
> +		pci_intx_for_msi(dev, 1);
>  	dev->msi_enabled = 0;
>  
>  	/* Return the device with MSI unmasked as initial states */
> @@ -1024,7 +1025,8 @@ void pci_msix_shutdown(struct pci_dev *dev)
>  	}
>  
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> -	pci_intx_for_msi(dev, 1);
> +	if (system_state == SYSTEM_RUNNING || system_state == SYSTEM_BOOTING)
> +		pci_intx_for_msi(dev, 1);
>  	dev->msix_enabled = 0;
>  	pcibios_alloc_irq(dev);
>  }
> -- 
> 1.7.9.3
