Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46147 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbcAYQWd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jan 2016 11:22:33 -0500
Date: Mon, 25 Jan 2016 10:22:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: aer: wait till the workqueue completes before
 free memory
Message-ID: <20160125162230.GA12114@localhost>
References: <20151217143243.GA9654@linutronix.de>
 <20160106232758.GE16231@localhost>
 <20160115183625.GG3781@linutronix.de>
 <20160121205717.GA21798@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160121205717.GA21798@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 21, 2016 at 02:57:17PM -0600, Bjorn Helgaas wrote:
> Hi Sebastian,
> 
> On Fri, Jan 15, 2016 at 07:36:25PM +0100, Sebastian Andrzej Siewior wrote:
> > I start a binary which should flash the FPGA and re-enumare the PCI-BUS
> > and find a new device. It works most of the time. With SLUB debug it
> > crashes on each iteration with something like this (compressed output):
> > 
> > | pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
> > | Unable to handle kernel paging request for data at address 0x27ef9e3e
> > | Faulting instruction address: 0x602f5328
> > | Oops: Kernel access of bad area, sig: 11 [#1]
> > | Workqueue: events aer_isr
> > | GPR24: dd6aa000 6b6b6b6b 605f8378 605f8360 d99b12c0 604fc674 606b1704 d99b12c0
> > | NIP [602f5328] pci_walk_bus+0xd4/0x104
> > 
> > Register 25 has the user-after magic. As it turns out, the old PCIe
> > device is leaving, generates an error before it left, aer_irq() is fired,
> > it schedules a work item. What happens now is that free_irq() is
> > invoked, all resources are gone *before* the aes_isr() work item is
> > completed.
> > So to fix this, I flush the workqueue to ensure that there is no more
> > work pending.
> > The wait_event() on wait_release should actually synchronized against
> > removal. However the condition (->prod_idx == ->cons_idx) is made true
> > before the function completes (aer_isr_one_error() is invoked right
> > after that) so it does not fulfill its purpose. Therefore I remove it.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> I propose to merge this patch unchanged, but with the following
> changelog.  I want to add a bit more detail about the concurrency
> problem and remove a bit of the specific detail about your FPGA:
> 
> 
> commit 9963c9487f733ef8fe3a06ce3398072a40f955bf
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Fri Jan 15 19:36:25 2016 +0100
> 
> PCI/AER: Flush workqueue on device remove to avoid use-after-free
> 
> A Root Port's AER structure (rpc) contains a queue of events.  aer_irq()
> enqueues AER status information and schedules aer_isr() to dequeue and
> process it.  When we remove a device, aer_remove() waits for the queue to
> be empty, then frees the rpc struct.
> 
> But aer_isr() references the rpc struct after dequeueing and possibly
> emptying the queue, which can cause a use-after-free error as in the
> following scenario with two threads, aer_isr() on the left and a
> concurrent aer_remove() on the right:
> 
>   Thread A                      Thread B
>   --------                      --------
>   aer_irq():
>     rpc->prod_idx++
> 				aer_remove():
> 				  wait_event(rpc->prod_idx == rpc->cons_idx)
> 				  # now blocked until queue becomes empty
>   aer_isr():                      # ...
>     rpc->cons_idx++               # unblocked because queue is now empty
>     ...                           kfree(rpc)
>     mutex_unlock(&rpc->rpc_mutex)
> 
> Wait until the last scheduled instance of aer_isr() has completed before
> freeing the rpc struct by using flush_work() in aer_remove().
> 
> I reproduced this use-after-free by flashing a device FPGA and
> re-enumerating the bus to find the new device.  With SLUB debug, this
> crashes with 0x6b bytes (POISON_FREE, the use-after-free magic number) in
> GPR25:
> 
>   pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
>   Unable to handle kernel paging request for data at address 0x27ef9e3e
>   Workqueue: events aer_isr
>   GPR24: dd6aa000 6b6b6b6b 605f8378 605f8360 d99b12c0 604fc674 606b1704 d99b12c0
>   NIP [602f5328] pci_walk_bus+0xd4/0x104
> 
> [bhelgaas: changelog]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to for-linus for v4.5 with stable tag, thanks!
