Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, Peter Wu <peter@lekensteyn.nl>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>, Dave Airlie <airlied@gmail.com>, Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
Date: Sat, 28 May 2016 14:29:06 +0200
Message-ID: <1576190.gfFb6HhZV6@vostro.rjw.lan>
In-Reply-To: <20160526110308.GX1789@lahna.fi.intel.com>
References: <20160524162833.GA30762@localhost> <20160526104557.GA6816@wunner.de> <20160526110308.GX1789@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, May 26, 2016 02:03:08 PM Mika Westerberg wrote:
> On Thu, May 26, 2016 at 12:45:57PM +0200, Lukas Wunner wrote:
> > > The PCI PM specification version 1.2 says this in chapter 4.2 (page 37):
> > > 
> > >   There is a minimum time requirement of 50 ms which must be provided by
> > >   system software between when the bus is switched from B2 to B0 and
> > >   when a function on the bus is accessed to allow time for the clock to
> > >   start up and the bus to settle.
> > 
> > But why do we wait 50 ms when *suspending*, i.e. going from B0 to B2?
> 
> I guess because PCI requires delays of 10ms for both directions D0 <->
> D3hot (see pci_raw_set_power_state()).
> 
> > (Assuming B2 is the state when the bridge goes to D3hot, which I'm not
> > sure of. The spec says that the bus state may optionally be B3 if the
> > bridge is in D3hot.)
> 
> B3 is the state where the bus goes when it's power is removed so I would
> expect that to require also the 50ms even though the spec does not
> explicitly say so.
> 
> > > Not sure how much of that still applies to modern hardware.
> > 
> > Could you ask hardware engineers at Intel what the bus state is on
> > modern chipsets (say, ILK or newer) and Thunderbolt ports to clarify
> > this?
> 
> I can try but it is not always easy to find the right person in company
> as big as Intel.

Well, even if you find someone to tell you that, what about non-Intel?

Are we going to ever know a value that's going to work for everybody unless
that value is clearly stated in the spec?

Thanks,
Rafael
