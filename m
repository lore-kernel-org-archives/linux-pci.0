Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Mon, 30 May 2016 12:33:26 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	Peter Wu <peter@lekensteyn.nl>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
Message-ID: <20160530093326.GH1789@lahna.fi.intel.com>
References: <20160524162833.GA30762@localhost>
 <20160526104557.GA6816@wunner.de>
 <20160526110308.GX1789@lahna.fi.intel.com>
 <1576190.gfFb6HhZV6@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1576190.gfFb6HhZV6@vostro.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 28, 2016 at 02:29:06PM +0200, Rafael J. Wysocki wrote:
> On Thursday, May 26, 2016 02:03:08 PM Mika Westerberg wrote:
> > On Thu, May 26, 2016 at 12:45:57PM +0200, Lukas Wunner wrote:
> > > > The PCI PM specification version 1.2 says this in chapter 4.2 (page 37):
> > > > 
> > > >   There is a minimum time requirement of 50 ms which must be provided by
> > > >   system software between when the bus is switched from B2 to B0 and
> > > >   when a function on the bus is accessed to allow time for the clock to
> > > >   start up and the bus to settle.
> > > 
> > > But why do we wait 50 ms when *suspending*, i.e. going from B0 to B2?
> > 
> > I guess because PCI requires delays of 10ms for both directions D0 <->
> > D3hot (see pci_raw_set_power_state()).
> > 
> > > (Assuming B2 is the state when the bridge goes to D3hot, which I'm not
> > > sure of. The spec says that the bus state may optionally be B3 if the
> > > bridge is in D3hot.)
> > 
> > B3 is the state where the bus goes when it's power is removed so I would
> > expect that to require also the 50ms even though the spec does not
> > explicitly say so.
> > 
> > > > Not sure how much of that still applies to modern hardware.
> > > 
> > > Could you ask hardware engineers at Intel what the bus state is on
> > > modern chipsets (say, ILK or newer) and Thunderbolt ports to clarify
> > > this?
> > 
> > I can try but it is not always easy to find the right person in company
> > as big as Intel.
> 
> Well, even if you find someone to tell you that, what about non-Intel?

Indeed, I was hoping to find someone who knows more about PCIe in
general and it turns out I found one :-)

> Are we going to ever know a value that's going to work for everybody unless
> that value is clearly stated in the spec?

That is a good question and the person I managed to find tells me that
the values are already in the spec.

So there are really no B-states in PCIe. Closest thing is L-states which
are defined in the PCIe spec. The spec has two timing limitations:

 - After bringing the device to D0/L0 from D3hot/L1 there is a
   required 10ms delay after the write to PMCSR before any other config
   space access (5.3.1.4 in PCIe spec 3.1a).

 - After bringing the device out of reset, which is the path to D0/L0
   from D3cold, there is a required 100ms delay before accessing the
   device's config space (6.6.1 in PCIe spec 3.1a).

I also learned that both of these can be shortened with following
mechanisms:

 - PCIe readines notifications (6.23 in PCIe spec 3.1a)
 - ACPI _DSM method returning readines durations from  (4.6.9 in PCI
   firmware spec 3.2).

I think it is actually worth looking into the two mechanisms and try to
get Linux support them.
