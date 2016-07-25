Return-Path: <tglx@linutronix.de>
Return-Path: <tglx@linutronix.de>
Date: Mon, 25 Jul 2016 09:45:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
    Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Make sure PCI MSIs are activated early
In-Reply-To: <20160722220440.GC32142@localhost>
Message-ID: <alpine.DEB.2.11.1607250928370.5629@nanos>
References: <1468426713-31431-1-git-send-email-marc.zyngier@arm.com> <20160722220440.GC32142@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Fri, 22 Jul 2016, Bjorn Helgaas wrote:
> On Wed, Jul 13, 2016 at 05:18:33PM +0100, Marc Zyngier wrote:
> > and it turns out that end-points are allowed to latch the content
> > of the MSI configuration registers as soon as MSIs are enabled.
> > In Bharat's case, the end-point ends up using whatever was there
> > already, which is not what you want.
> > 
> > In order to make things converge, we introduce a new MSI domain
> > flag (MSI_FLAG_ACTIVATE_EARLY) that is unconditionally set for
> > PCI/MSI. When set, this flag forces the programming of the end-point
> > as soon as the MSIs are allocated.
> > 
> > A consequence of this is that we have an extra activate in
> > irq_startup, but that should be without much consequence.
> > 
> > Reported-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > Tested-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thomas, let me know if you'd like me to take this.  It looks like the
> real smarts here are in kernel/irq, so I assume you'll take it unless
> I hear otherwise.

I'll take it. Though I have second thoughts about the whole issue.

We deliberately made the allocation sequence of interrupts in a way that we
can easily rollback in case of failure.

We achieved that by activating the interrupts only at request time and not
somewhere in the middle of the allocation sequence. That makes the whole
hierarchical allocation more robust and avoids complex rollbacks.

Now that new flag is basically torpedoing that approach.

What I really wonder is why that is only an issue with that particular xilinx
hardware/IP block. I'm aware that up to PCI 2.3 the mask bit for MSI
interrupts is optional or in really old versions not even specified. So only
if that mask bit is missing the above described issue can happen.

If not, then we might have a general issue that we don't mask the entry before
we call pci_msi_set_enable().

Thoughts?

	tglx
