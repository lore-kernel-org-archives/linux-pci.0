Return-Path: <SRS0=8PhW=EU=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=8PhW=EU=intel.com=keith.busch@kernel.org>
Date: Thu, 25 Jan 2018 14:15:21 -0700
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Maik Broemme <mbroemme@libmpq.org>,
	Pawandeep Oza <poza@codeaurora.org>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCHv2 4/6] PCI/DPC: Print AER status in DPC event handling
Message-ID: <20180125211521.GB19484@localhost.localdomain>
References: <20180117052206.7703-1-keith.busch@intel.com>
 <20180117052206.7703-5-keith.busch@intel.com>
 <20180125195512.GL5317@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180125195512.GL5317@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 25, 2018 at 01:55:12PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 16, 2018 at 10:22:04PM -0700, Keith Busch wrote:
> >  
> >  	schedule_work(&dpc->work);
> >  
> > +	if (reason == 0)
> > +		dpc->info.severity = AER_NONFATAL;
> > +	else
> > +		dpc->info.severity = AER_CORRECTABLE;
> 
> This looks wrong because we call schedule_work() before we set
> dpc->info.severity.  I think that's racy because
> interrupt_event_handler() might read dpc->info.severity before
> dpc_irq() sets it.

You're right, my mistake.
 
> That raises the question of how we pass information from dpc_irq() to
> interrupt_event_handler().  I think interrupt_event_handler() is a
> work item because it removes devices and might need to sleep.  That
> makes sense.
>
> But we pass dpc->info and dpc->rp_pio_status from dpc_irq() to
> interrupt_event_handler() via the single struct dpc_dev.  That doesn't
> make sense in general because dpc_irq() may be invoked several times
> for each invocation of interrupt_event_handler().  I think the general
> purpose solution for passing information from interrupt context to
> process context would be a queue.
> 
> It looks like we side-step that issue by disabling interrupts in
> dpc_irq() and re-enabling them in interrupt_event_handler().  That
> probably does work, but it's strange and requires extra config
> accesses.  The fact that we clear PCI_EXP_DPC_STATUS_INTERRUPT at the
> end of interrupt_event_handler() should be enough -- sec 6.2.10.1 says
> we should only get a new MSI when the logical AND of things including
> PCI_EXP_DPC_STATUS_INTERRUPT transitions from FALSE to TRUE.

Yes, that's true. We could get the same interrupt for non-DPC related
events, and the interrupt config setting was something Alex proposed to
make sure we don't note the same events multiple times. Using these
config registers seems a bit overkill, though.
 
> I think all the log registers (Error Source ID and RP PIO Logs) are
> latched when DPC Trigger Status is set, so I think all the dmesg
> logging and dpc_process_rp_pio_error() stuff *could* be done in
> interrupt_event_handler().  Then it would be together with the
> PCI_EXP_DPC_STATUS write that clears DPC Trigger Status (and clears
> the latched log registers) and we wouldn't have the question about
> what belongs on dpc_irq() and what belongs in
> interrupt_event_handler().

That sounds great. If we defer all logging and containment handling
to the work-queue, that should even fix up the issues the interrupt
disable/enabling was trying to solve.

That doesn't even sound difficult to code. Let me send you a proposal
instead of this series, maybe by tomorrow.

> After we clear PCI_EXP_DPC_STATUS_TRIGGER, we're supposed to "honor
> timing requirements ... with respect to the first Configuration Read
> following a Conventional Reset" (PCIe r4.0, sec 7.9.15.4).  Where does
> that happen?

That is referring to reading the downstream port, and that is not
handled by the DPC driver. The expectation is that the link is down on a
DPC event, and the Link Up is handled by the pciehp driver, which
should be honoring those timing requirements.
