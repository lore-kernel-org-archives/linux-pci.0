Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43534 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbcGYOrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jul 2016 10:47:07 -0400
Date: Mon, 25 Jul 2016 09:47:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Make sure PCI MSIs are activated early
Message-ID: <20160725144702.GA12484@localhost>
References: <1468426713-31431-1-git-send-email-marc.zyngier@arm.com>
 <20160722220440.GC32142@localhost>
 <alpine.DEB.2.11.1607250928370.5629@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.11.1607250928370.5629@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 25, 2016 at 09:45:13AM +0200, Thomas Gleixner wrote:
> On Fri, 22 Jul 2016, Bjorn Helgaas wrote:
> > On Wed, Jul 13, 2016 at 05:18:33PM +0100, Marc Zyngier wrote:
> > > and it turns out that end-points are allowed to latch the content
> > > of the MSI configuration registers as soon as MSIs are enabled.
> > > In Bharat's case, the end-point ends up using whatever was there
> > > already, which is not what you want.
> > > 
> > > In order to make things converge, we introduce a new MSI domain
> > > flag (MSI_FLAG_ACTIVATE_EARLY) that is unconditionally set for
> > > PCI/MSI. When set, this flag forces the programming of the end-point
> > > as soon as the MSIs are allocated.
> > > 
> > > A consequence of this is that we have an extra activate in
> > > irq_startup, but that should be without much consequence.
> > > 
> > > Reported-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > Tested-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Thomas, let me know if you'd like me to take this.  It looks like the
> > real smarts here are in kernel/irq, so I assume you'll take it unless
> > I hear otherwise.
> 
> I'll take it. Though I have second thoughts about the whole issue.
> 
> We deliberately made the allocation sequence of interrupts in a way that we
> can easily rollback in case of failure.
> 
> We achieved that by activating the interrupts only at request time and not
> somewhere in the middle of the allocation sequence. That makes the whole
> hierarchical allocation more robust and avoids complex rollbacks.
> 
> Now that new flag is basically torpedoing that approach.
> 
> What I really wonder is why that is only an issue with that particular xilinx
> hardware/IP block. I'm aware that up to PCI 2.3 the mask bit for MSI
> interrupts is optional or in really old versions not even specified. So only
> if that mask bit is missing the above described issue can happen.
> 
> If not, then we might have a general issue that we don't mask the entry before
> we call pci_msi_set_enable().

Good question.  I haven't followed this thread in detail, so my ack
meant "I'm OK with this if you are," not "I've reviewed this and
think it's great."

I thought the original issue [1] was that PCI_MSI_FLAGS_ENABLE was being
written before PCI_MSI_ADDRESS_LO.  That doesn't sound like a good
idea to me.

I don't understand the whole flow.  Here's what I've gleaned so far:

  pci_enable_msi_range
    msi_capability_init
      pci_msi_setup_msi_irqs
        domain = pci_msi_get_domain(dev)
        if (domain)
          # this seems like the problem case
          pci_msi_domain_alloc_irqs(domain, dev, nvec)
            msi_domain_alloc_irqs
              ...
        else
          # this case apparently works fine
          arch_setup_msi_irqs
            for_each_pci_msi_entry(entry, dev)
              arch_setup_msi_irq
                chip->setup_irq
                  xilinx_pcie_msi_setup_irq  # xilinx_pcie_msi_chip.setup_irq
                    pci_write_msi_msg
                      __pci_write_msi_msg
                        pci_write_config_dword(PCI_MSI_ADDRESS_LO)
      pci_msi_set_enable(dev, 1)
        pci_write_config_word(PCI_MSI_FLAGS, PCI_MSI_FLAGS_ENABLE)

I assume the problem is that in the MSI domain case, we don't call the
chip->setup_irq method until later.  I gave up trying to figure out
where that happens.  Is it something like the following?

  request_irq
    request_threaded_irq
      __setup_irq
        ...
          ?? chip->setup_irq ??

That does seem like a problem.  Maybe it would be better to delay
setting PCI_MSI_FLAGS_ENABLE until after the MSI address & data bits
have been set?

[1] http://lkml.kernel.org/r/8520D5D51A55D047800579B094147198258B80DE@XAP-PVEXMBX01.xlnx.xilinx.com
