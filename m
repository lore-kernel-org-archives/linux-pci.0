Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51482 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946825AbcHRNBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Aug 2016 09:01:14 -0400
Date: Thu, 18 Aug 2016 07:52:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc: Rajat Jain <rajatja@google.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
	"Busch, Keith" <keith.busch@intel.com>,
	"Tarazona-Duarte, Luis Antonio"
	<luis.antonio.tarazona-duarte@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH v1] PCI: pciehp: Fix presence detect change interrupt
 handling
Message-ID: <20160818125254.GF27353@localhost>
References: <92EBB4272BF81E4089A7126EC1E7B284665970B5@IRSMSX101.ger.corp.intel.com>
 <20160817171225.GA27353@localhost>
 <CACK8Z6H2G1cA6W+7timaKdeK2wuPNQfdLeZQCx=C8VkBESUOfQ@mail.gmail.com>
 <20160817181459.GB27353@localhost>
 <92EBB4272BF81E4089A7126EC1E7B28466597350@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28466597350@IRSMSX101.ger.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 17, 2016 at 10:37:13PM +0000, Patel, Mayurkumar wrote:
> > On Wed, Aug 17, 2016 at 10:54:12AM -0700, Rajat Jain wrote:

> > > We need to do something about that *in addition * to the
> > > above patch to cover the
> > > whole story. However I think there still will be a room for some
> > > interrupt misses because we are
> > > collecting the interrupts in intr_loc, and theoretically we could be
> > > in a situation where in the pcie_isr, the
> > >
> > > do {
> > >     ...
> > > } while(detected)
> > >
> > > loop gets a removal->insertion->removal all while in the same
> > > invocation of pcie_isr().
> > > If this happens, the intr_loc will have recorded a single insertion
> > > and a single removal, and
> > > the final result will depend on the order in which we decide to
> > > process the events in intr_loc.
> > 
> > I don't quite understand how that "do { .. } while (detected)" loop
> > works or why it's done that way.  Collecting interrupt status bits in
> > an ISR is obviously a very common task; it seems like there should be
> > a standard, idiomatic way of doing it, but I don't know it.
> > 
> > > Or, may be we can make the calls to pciehp_queue_interrupt_event()
> > > before clearing the
> > > RW1C in the slot status register (in the loop)?
> > 
> > Yeah, it seems like we should read PCI_EXP_SLTSTA once, queue up any
> > events related to it, then clear the relevant SLTSTA bits.
> > 
> 
> Do you mean to remove the do {...} while loop and just
> read PCI_EXP_SLTSTA once in ISR , queue the work and clear interrupts?

I don't know if removing the loop is the right thing or not.  We need
to understand why the loop is there in the first place and make sure
removing it wouldn't break things.

But I do think that in the resulting code, the connection between

  (1) the events we learn from the interrupt and
  (2) the queued work items

needs to be crystal clear.  Right now it's a bit muddy because of
things like the case you fixed: a work item that goes back and looks
at PCI_EXP_SLTSTA after it's been cleared and the hardware may have
already set bits for new events.

Bjorn
