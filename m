Return-Path: <rajatja@google.com>
Return-Path: <rajatja@google.com>
MIME-Version: 1.0
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28466597AA3@IRSMSX101.ger.corp.intel.com>
References: <92EBB4272BF81E4089A7126EC1E7B284665970B5@IRSMSX101.ger.corp.intel.com>
 <20160817171225.GA27353@localhost> <CACK8Z6H2G1cA6W+7timaKdeK2wuPNQfdLeZQCx=C8VkBESUOfQ@mail.gmail.com>
 <20160817181459.GB27353@localhost> <92EBB4272BF81E4089A7126EC1E7B28466597350@IRSMSX101.ger.corp.intel.com>
 <20160818125254.GF27353@localhost> <92EBB4272BF81E4089A7126EC1E7B28466597AA3@IRSMSX101.ger.corp.intel.com>
From: Rajat Jain <rajatja@google.com>
Date: Tue, 23 Aug 2016 16:47:44 -0700
Message-ID: <CACK8Z6GM_zZKvBn4YanWzV_R8TGFErUJboMgvQD5FqUcopOQXg@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: pciehp: Fix presence detect change interrupt handling
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Busch, Keith" <keith.busch@intel.com>,
	"Tarazona-Duarte, Luis Antonio" <luis.antonio.tarazona-duarte@intel.com>, Rajat Jain <rajatxjain@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 1:59 PM, Patel, Mayurkumar
<mayurkumar.patel@intel.com> wrote:
>
>
>
> > On Wed, Aug 17, 2016 at 10:37:13PM +0000, Patel, Mayurkumar wrote:
> > > > On Wed, Aug 17, 2016 at 10:54:12AM -0700, Rajat Jain wrote:
> >
> > > > > We need to do something about that *in addition * to the
> > > > > above patch to cover the
> > > > > whole story. However I think there still will be a room for some
> > > > > interrupt misses because we are
> > > > > collecting the interrupts in intr_loc, and theoretically we could be
> > > > > in a situation where in the pcie_isr, the
> > > > >
> > > > > do {
> > > > >     ...
> > > > > } while(detected)
> > > > >
> > > > > loop gets a removal->insertion->removal all while in the same
> > > > > invocation of pcie_isr().
> > > > > If this happens, the intr_loc will have recorded a single insertion
> > > > > and a single removal, and
> > > > > the final result will depend on the order in which we decide to
> > > > > process the events in intr_loc.
> > > >
> > > > I don't quite understand how that "do { .. } while (detected)" loop
> > > > works or why it's done that way.  Collecting interrupt status bits in
> > > > an ISR is obviously a very common task; it seems like there should be
> > > > a standard, idiomatic way of doing it, but I don't know it.
> > > >
> > > > > Or, may be we can make the calls to pciehp_queue_interrupt_event()
> > > > > before clearing the
> > > > > RW1C in the slot status register (in the loop)?
> > > >
> > > > Yeah, it seems like we should read PCI_EXP_SLTSTA once, queue up any
> > > > events related to it, then clear the relevant SLTSTA bits.
> > > >
> > >
> > > Do you mean to remove the do {...} while loop and just
> > > read PCI_EXP_SLTSTA once in ISR , queue the work and clear interrupts?
> >
> > I don't know if removing the loop is the right thing or not.  We need
> > to understand why the loop is there in the first place and make sure
> > removing it wouldn't break things.
> >
>
>
> The pcie base spec. 3.0 says from chapter 6.7.3.1. Slot Events:
>
>         A Downstream Port with hot-plug capabilities monitors the slot it controls for the slot events listed
>         above. When one of these slot events is detected, the Port indicates that the event has occurred by
>         setting the status field associated with the event. At that point, the event is pending until software
>         clears the status field.
>         Once a slot event is pending on a particular slot, all subsequent events of that type are ignored on
>         that slot until the event is cleared. The Port must continue to monitor the slot for all other slot
>         event types and report them as they occur.
>
>
> So does it mean that the port would continue providing MSI if there has been
> any other events occurred apart from the event which is not cleared? If that
> is the case then it's not sure why the loop is still needed.

I'd think that the loop is needed because we don't want to handle just
one event on one interrupt. We want to handle as many events as we can
(to keep the interrupt latency overhead low), that have happened
during the ISR invocation. And hence the loop.

>
> Also with having a loop, pcie_isr() is reading the PCI_EXP_SLTSTA again and taking action just based on
> latest event happens. That may mean removal->insertion happens fast enough then
> removal could be overwritten by insertion and pciehp_get_adapter_status ()
> will return insertion only and we may miss the removal event to be processed for the loop.

Current. This is the problem that Bjorn highlighted above. I think the
current code works well when events of different kinds have happened
(due to the loop).

In case of similar kind of events (insertion / removal), I think there
are 2 problems: (1) we use the transient values of slot status which
may not be valid at that time. (2) because we ack the event before we
queue it up, it leaves chance for error. I think we'd need more
careful examination in order to fix these issues.

>
> If we don't clear the Slot event quick enough then according to spec. statement above
> that event could get ignored and SW may never get notified.
>
>
>
> > But I do think that in the resulting code, the connection between
> >
> >   (1) the events we learn from the interrupt and
> >   (2) the queued work items
> >
> > needs to be crystal clear.  Right now it's a bit muddy because of
> > things like the case you fixed: a work item that goes back and looks
> > at PCI_EXP_SLTSTA after it's been cleared and the hardware may have
> > already set bits for new events.
> >
>
> I have made a prototype patch in my follow up reply and tested ok on my existing setup
> on which I caught the previous issue although I cant say it will work on any HW.
> Clearing events after queuing events gave some problems and did not work properly on my
> existing HW where I test very fast insertion and removal events, in which
> case only "removal" event comes and "insertion" does not occur even if HW gets powered.
>
> > Bjorn
> Intel Deutschland GmbH
> Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
> Tel: +49 89 99 8853-0, www.intel.de
> Managing Directors: Christin Eisenschmid, Christian Lamprechter
> Chairperson of the Supervisory Board: Nicole Lau
> Registered Office: Munich
> Commercial Register: Amtsgericht Muenchen HRB 186928
>
