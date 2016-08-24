Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Wed, 24 Aug 2016 10:59:54 -0400
From: Keith Busch <keith.busch@intel.com>
To: Rajat Jain <rajatja@google.com>
Cc: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"Tarazona-Duarte, Luis Antonio" <luis.antonio.tarazona-duarte@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] PCI: pciehp: Fix presence detect change interrupt
 handling
Message-ID: <20160824145954.GB13337@localhost.localdomain>
References: <92EBB4272BF81E4089A7126EC1E7B284665970B5@IRSMSX101.ger.corp.intel.com>
 <20160817171225.GA27353@localhost>
 <CACK8Z6H2G1cA6W+7timaKdeK2wuPNQfdLeZQCx=C8VkBESUOfQ@mail.gmail.com>
 <20160817181459.GB27353@localhost>
 <92EBB4272BF81E4089A7126EC1E7B28466597350@IRSMSX101.ger.corp.intel.com>
 <20160818125254.GF27353@localhost>
 <92EBB4272BF81E4089A7126EC1E7B28466597AA3@IRSMSX101.ger.corp.intel.com>
 <CACK8Z6GM_zZKvBn4YanWzV_R8TGFErUJboMgvQD5FqUcopOQXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACK8Z6GM_zZKvBn4YanWzV_R8TGFErUJboMgvQD5FqUcopOQXg@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 04:47:44PM -0700, Rajat Jain wrote:
> On Thu, Aug 18, 2016 at 1:59 PM, Patel, Mayurkumar
> <mayurkumar.patel@intel.com> wrote:
> >
> > So does it mean that the port would continue providing MSI if there has been
> > any other events occurred apart from the event which is not cleared? If that
> > is the case then it's not sure why the loop is still needed.
> 
> I'd think that the loop is needed because we don't want to handle just
> one event on one interrupt. We want to handle as many events as we can
> (to keep the interrupt latency overhead low), that have happened
> during the ISR invocation. And hence the loop.

The Slot Status doesn't have to provide a single event at a time. But
even if it does, this isn't exactly a performance path that would be
hurt by having one interrupt per event, right?
