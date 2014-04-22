Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:45445 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932983AbaDVReq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Apr 2014 13:34:46 -0400
Date: Tue, 22 Apr 2014 11:34:06 -0600
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
Message-ID: <20140422173406.GC23955@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
 <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
 <20140411122314.220614bf@skate>
 <20140411163129.GA20565@obsidianresearch.com>
 <20140418150244.4b3d5229@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140418150244.4b3d5229@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 18, 2014 at 03:02:44PM +0200, Thomas Petazzoni wrote:

> > The LinkUp bit after resume is also clearly a lie - most likely the
> > PEX takes some time to detect the change in remote state to trigger a
> > link down. After all, it was suspended while the remote was busy
> > trying to recover.
> 
> Ok, fair enough. However, Neil's patch (which is basically your patch
> with longer delays) isn't working here, as I just reported in a
> separate e-mail.
> 
> So we don't have a solution right now. Do you have another proposal to
> try ?

Do you have time to see if we can isolate the difference on your
system?

> > The fundamental problem here is the clock driver. It should not be
> > gating PEX clocks so naively. A PEX suspend needs to be sequenced to
> > ensure the link is cleanly brought down before the PEX is put to
> > sleep. That way it can cleanly and unambiguously be started up when it
> > resumes. No risk of glitching/corrupting the far side with some kind
> > of crap on the serial bus.
> > 
> > In any event, the most important required patch here is one that fixes
> > socid. It must not turn off the PEX clock. Then we can talk about how
> > to fix pci-mvebu to work as a module...
 
> I don't really understand this: all clocks are gated at boot time, so
> regardless of mvebu-soc-id behavior, the PCIe driver should take care
> of doing all the necessary initialization without making the
> assumptions that the clocks were left turned on from the bootloader

The current mvebu-soc-id makes it impossible to do a clean hand off of
the boot loader PEX setup to the PEX driver. I think that is a
problem. Certainly if we fix it non-modular PEX will start working
reliably.

Keep in mind the current driver cannot startup a PEX without
bootloader support. It does not clear the set-at-reset
Conf_TrainingDisable bit, and it doesn't wait for a link to come up
after doing so.

> time. This is needed if we want to support pci-mvebu as a module, so I
> don't see why hacking mvebu-soc-id is going to solve this.

I agree we should try to figure the modular case out, but it looks to
me that suspending the PEX is a bigger job that just gating the
clock..

The automatic gating of the PEX clocks should be more clever. If there
are no DT elements that reference the clock it can be disabled,
otherwise we should probably leave it enabled and rely on the PEX
driver to do power management once it gets loaded.

So broadly, my thinking is the following largely orthogonal items:
 1) PEX's that are setup by the bootloader must be cleanly handed off
    to the driver. The clocks must never gate.
 2) The driver should learn to turn on a PEX from either the
    Conf_TrainingDisable=1 state or the clock gated state
 3) PEX clocks that are never used in DT can be safely shutoff,
    otherwise they must remain on
 4) The PEX driver can learn to properly suspend the PEX for power
    savings, via the normal Linux power management stuff.

What do you think?

Jason
