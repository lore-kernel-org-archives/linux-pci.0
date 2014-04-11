Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:56037 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754296AbaDKQc0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Apr 2014 12:32:26 -0400
Date: Fri, 11 Apr 2014 10:31:29 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Neil Greatorex <neil@fatboyfat.co.uk>, Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140411163129.GA20565@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
 <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
 <20140411122314.220614bf@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140411122314.220614bf@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 11, 2014 at 12:23:14PM +0200, Thomas Petazzoni wrote:

> On Thu, 10 Apr 2014 22:56:00 +0100 (BST), Neil Greatorex wrote:
> > > In any event, turning on the clock should almost certainly be
> > > accompanied by a phy reset sequence to get both link ends on the same
> > > page.
> > >
> > > Attached is a rough, untested patch along those lines.
> > >
> > 
> > I took your attached patch and extended it a bit to print out how long it 
> > took. The delays also need to be much longer for me. I also fixed a small 
> > typo you made where the bit wasn't being set again to bring the link back 
> > up. I've attached the diff to your patch, as well as the combined patch 
> > (hope that makes sense).
> 
> I managed to reproduce the problem of the PCIe device not being
> detected on Mirabox when earlyprintk is disabled.
> 
> However, the proposed patch doesn't seem to work:
> 
> mvebu-pcie pcie-controller.3: PCIe0.0: performing link reset
> mvebu-pcie pcie-controller.3: PCIe0.0: link went down after 100 tries
> mvebu-pcie pcie-controller.3: PCIe0.0: link came back up after 0 tries
> 
> It waits hundred times for the link to go down, but it never goes down,
> and then it doesn't wait at all to go up... because it never went down.

I wonder if bit 30 only disables link training, but doesn't force the
link down. There may be another bit that is required here.

Alternatively, are you seeing a different problem? If you apply the
hack to the socid does your symptom go away as well?

> Moreover, I am not entirely convinced that a PHY reset is needed here.
> In my tests, doing just a wait after setting the local dev number was
> sufficient. The fact is works with earlyprintk also indicates that we
> don't need to do any specific action with the PHY, just to wait a bit
> of time. I am worried that resetting the PHY might actually take more
> time than what is needed, and may have other consequences that we don't
> necessarily understand at this point.

I really disagree - clearly the fundamental problem is suspending one
side of the PEX link while the other remains operating. That isn't
specified to work and really shouldn't work.

If you suspend one side of the PEX you *MUST* reset the
link. Absolutely. No Doubt In My Mind.

Remember, PCI-E is a serial shared state protocol. The two sides must
remain in sync or a link reset is required to recover the shared
state. Halting one side obviously destroys this invariant.

I think in many cases the reset happens autonomously. The remote side
will force it to happen. This is what the debugging from Neil shows -
the link just resets at some inconvenient point. Now we know why.

The timing sensitivity also makes sense, if you suspend for a very
short time window the other side might not notice. If you suspend for
longer the other side will reset the link autonomously and your local
side will quickly notice the reset once it comes back.

If you suspend for a little bit the link might not retrain immediately
but the shared state can become corrupted (eg sequence number
mismatch) this will eventually trigger a reset, after the local PEX
has been operating again.

The LinkUp bit after resume is also clearly a lie - most likely the
PEX takes some time to detect the change in remote state to trigger a
link down. After all, it was suspended while the remote was busy
trying to recover.

The fundamental problem here is the clock driver. It should not be
gating PEX clocks so naively. A PEX suspend needs to be sequenced to
ensure the link is cleanly brought down before the PEX is put to
sleep. That way it can cleanly and unambiguously be started up when it
resumes. No risk of glitching/corrupting the far side with some kind
of crap on the serial bus.

In any event, the most important required patch here is one that fixes
socid. It must not turn off the PEX clock. Then we can talk about how
to fix pci-mvebu to work as a module...

Jason
