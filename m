Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43850 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbcAFX2F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 18:28:05 -0500
Date: Wed, 6 Jan 2016 17:27:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: aer: wait till the workqueue completes before free
 memory
Message-ID: <20160106232758.GE16231@localhost>
References: <20151217143243.GA9654@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151217143243.GA9654@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sebastian,

On Thu, Dec 17, 2015 at 03:32:43PM +0100, Sebastian Andrzej Siewior wrote:
> I start a binary which should flash the FPGA and re-enumare the PCI-BUS
> and find a new device. It works most of the time. With SLUB debug it
> crashes on each iteration with something like this (compressed output):
> 
> | pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
> | Unable to handle kernel paging request for data at address 0x27ef9e3e
> | Faulting instruction address: 0x602f5328
> | Oops: Kernel access of bad area, sig: 11 [#1]
> | Workqueue: events aer_isr
> | GPR24: dd6aa000 6b6b6b6b 605f8378 605f8360 d99b12c0 604fc674 606b1704 d99b12c0
> | NIP [602f5328] pci_walk_bus+0xd4/0x104
> 
> Register 25 has the user-after magic. As it turns out, the old PCIe
> device is leaving, generates an error before it left, aer_irq() is fired,
> it schedules a work item. What happens now is that free_irq() is
> invoked, all resources are gone *before* the aes_isr() work item is
> completed.
> So to fix this, I flush the workqueue to ensure that there is no more
> work pending.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Bjorn, this could deserve a stable tag. However it seems to have been
> like that even in v2.6.20.
> 
>  drivers/pci/pcie/aer/aerdrv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 0bf82a20a0fb..7acd27348098 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -282,8 +282,10 @@ static void aer_remove(struct pcie_device *dev)
>  
>  	if (rpc) {
>  		/* If register interrupt service, it must be free. */
> -		if (rpc->isr)
> +		if (rpc->isr) {
>  			free_irq(dev->irq, dev);
> +			flush_work(&rpc->dpc_handler);
> +		}
>  
>  		wait_event(rpc->wait_release, rpc->prod_idx == rpc->cons_idx);

Your change looks reasonable.  But I'm curious about the wait_event()
just below it.  That *looks* like it's intended to do the same thing
as your flush_work().

Can you explain why the wait_event() isn't working?  If we add the
flush_work(), can we remove the wait_event() stuff?

Bjorn
