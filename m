Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Thu, 26 May 2016 14:03:08 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Peter Wu <peter@lekensteyn.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
Message-ID: <20160526110308.GX1789@lahna.fi.intel.com>
References: <20160524162833.GA30762@localhost>
 <1464188696-25782-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160526101006.GA6744@wunner.de>
 <20160526102520.GV1789@lahna.fi.intel.com>
 <20160526104557.GA6816@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160526104557.GA6816@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 26, 2016 at 12:45:57PM +0200, Lukas Wunner wrote:
> > The PCI PM specification version 1.2 says this in chapter 4.2 (page 37):
> > 
> >   There is a minimum time requirement of 50 ms which must be provided by
> >   system software between when the bus is switched from B2 to B0 and
> >   when a function on the bus is accessed to allow time for the clock to
> >   start up and the bus to settle.
> 
> But why do we wait 50 ms when *suspending*, i.e. going from B0 to B2?

I guess because PCI requires delays of 10ms for both directions D0 <->
D3hot (see pci_raw_set_power_state()).

> (Assuming B2 is the state when the bridge goes to D3hot, which I'm not
> sure of. The spec says that the bus state may optionally be B3 if the
> bridge is in D3hot.)

B3 is the state where the bus goes when it's power is removed so I would
expect that to require also the 50ms even though the spec does not
explicitly say so.

> > Not sure how much of that still applies to modern hardware.
> 
> Could you ask hardware engineers at Intel what the bus state is on
> modern chipsets (say, ILK or newer) and Thunderbolt ports to clarify
> this?

I can try but it is not always easy to find the right person in company
as big as Intel.
