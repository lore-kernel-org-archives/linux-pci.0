Return-Path: <SRS0=PUMJ=7R=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=PUMJ=7R=intel.com=keith.busch@kernel.org>
Date: Tue, 15 Aug 2017 17:33:05 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Subject: Re: [PATCH] pciehp: Fix infinite interupt handler loop
Message-ID: <20170815213304.GJ7233@localhost.localdomain>
References: <1501571512-8362-1-git-send-email-keith.busch@intel.com>
 <20170814205948.GF32525@bhelgaas-glaptop.roam.corp.google.com>
 <20170814221123.GI7233@localhost.localdomain>
 <20170815204825.GL32525@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170815204825.GL32525@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 15, 2017 at 01:48:25PM -0700, Bjorn Helgaas wrote:
> On Mon, Aug 14, 2017 at 06:11:23PM -0400, Keith Busch wrote:
> > On Mon, Aug 14, 2017 at 03:59:48PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Aug 01, 2017 at 03:11:52AM -0400, Keith Busch wrote:
> > > > We've encountered a particular platform that under some circumstances
> > > > always has the power fault detected status raised. The pciehp irq handler
> > > > would loop forever because it thinks it is handling new events when in
> > > > fact the power fault is not new. This patch fixes that by masking off
> > > > the power fault status from new events if the driver hasn't seen the
> > > > power fault clear from the previous handling attempt.
> > > 
> > > Can you say which platform this is?  If this is a hardware defect,
> > > it'd be interesting to know where it happens.
> > > 
> > > But I'm not sure we handle PCI_EXP_SLTSTA correctly.  We basically
> > > have this:
> > > 
> > >   pciehp_isr()
> > >   {
> > >     pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
> > >     events = status & (<events we care about>);
> > >     pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
> > >     <queue event handling>
> > >   }
> > > 
> > > The write to PCI_EXP_SLTSTA clears PCI_EXP_SLTSTA_PFD because it's
> > > RW1C.  But we haven't done anything that would actually change the
> > > situation that caused a power fault, so I don't think it would be
> > > surprising if the hardware immediately reasserted it.
> > > 
> > > So maybe this continual assertion of power fault is really a software
> > > bug, not a hardware problem?
> > 
> > I *think* it's a software bug for the exact reason you provided, but I'm
> > sure it must be isolated to certain conditions with certain hardware. We'd
> > have heard about this regression during 4.9 if it was more wide-spread.
> 
> OK, I think this makes pretty good sense.
> 
> > > > Fixes: fad214b0aa72 ("PCI: pciehp: Process all hotplug events before
> > > > looking for new ones")
> 
> > This is on a PEX8733 bridge, and it reports power fault detected status as
> > long as the power fault exists. While we can write 1 to clear the event,
> > that just rearms the port to retrigger power fault detected status for as
> > long as the power controller detects its faulted. The status is cleared
> > for good only when the power fault no longer exists rather than when
> > it is acknowledged. The spec seems to support that view (Table (7-21:
> > Slot Status Register):
> > 
> >   Power Fault Detected – If a Power Controller that supports power fault
> >   detection is implemented, this bit is Set when the Power Controller
> >   detects a power fault at this slot.
> 
> Interesting: 5651c48cfafe ("PCI pciehp: fix power fault interrupt
> storm problem") turned off PCI_EXP_SLTCTL_PFDE in 2009 for basically
> the same problem.
>
> AFAICS, we *still* never turn PCI_EXP_SLTCTL_PFDE on, so in your case,
> you're probably taking an interrupt for some other reason, and
> coincidentally noticing that PCI_EXP_SLTSTA_PFD is set.

Yep, we always got into the infinite loop with pciehp_poll_mode=1.
They were using that param to work around a hw defect not sending
interrupts on slot command completion. The system was unbootlable with
that parameter since 4.9.

After getting the hw fixed and with polling disabled, we'd still get
into the same loop after a link status change interrupt.

> Maybe it's time to turn PCI_EXP_SLTCTL_PFDE back on along with your
> fix to prevent the loop?  It seems like kind of a hole that we will
> never notice power faults unless some other interrupt happens.  Or am
> I missing something?

That sounds right to me, and would appear to work fine with all the
devices I know about. I often see the power fault status logged in the
kernel along with a link down event, but that may be catching only a
subset of power fault events.

> I'd like to move your PCI_EXP_SLTSTA_PFD out on its own so there's
> room for a comment.  What do you think of the following?  I really
> don't think this is specific to a particular platform (other than
> maybe timing-wise), so I dropped that from the changelog too.

Thanks for the improvement. This is indeed more readable.

As always, thanks for the thoughtful feedback.
 
> commit 7612b3b28c0b900dcbcdf5e9b9747cc20a1e2455
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Tue Aug 1 03:11:52 2017 -0400
> 
>     PCI: pciehp: Report power fault only once until we clear it
>     
>     When a power fault occurs, the power controller sets Power Fault Detected
>     in the Slot Status register, and pciehp_isr() queues an INT_POWER_FAULT
>     event to handle it.
>     
>     It also clears Power Fault Detected, but since nothing has yet changed to
>     correct the power fault, the power controller will likely set it again
>     immediately, which may cause an infinite loop when pcie_isr() rechecks
>     Slot Status.
>     
>     Fix that by masking off Power Fault Detected from new events if the driver
>     hasn't seen the power fault clear from the previous handling attempt.
>     
>     Fixes: fad214b0aa72 ("PCI: pciehp: Process all hotplug events before looking for new ones")
>     Signed-off-by: Keith Busch <keith.busch@intel.com>
>     [bhelgaas: changelog, pull test out and add comment]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: Mayurkumar Patel <mayurkumar.patel@intel.com>
>     Cc: stable@vger.kernel.org      # 4.9+
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 026830a138ae..e5d5ce9e3010 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -586,6 +586,14 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
>  			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
>  			   PCI_EXP_SLTSTA_DLLSC);
> +
> +	/*
> +	 * If we've already reported a power fault, don't report it again
> +	 * until we've done something to handle it.
> +	 */
> +	if (ctrl->power_fault_detected)
> +		events &= ~PCI_EXP_SLTSTA_PFD;
> +
>  	if (!events)
>  		return IRQ_NONE;
>  
