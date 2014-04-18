Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33345 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751034AbaDRNCr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Apr 2014 09:02:47 -0400
Date: Fri, 18 Apr 2014 15:02:44 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Neil Greatorex <neil@fatboyfat.co.uk>, Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140418150244.4b3d5229@skate>
In-Reply-To: <20140411163129.GA20565@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
	<20140410165733.GB23104@obsidianresearch.com>
	<20140410200153.46669e0c@skate>
	<20140410201201.GA12661@obsidianresearch.com>
	<alpine.DEB.2.10.1404102206090.28003@vroombuntu>
	<20140411122314.220614bf@skate>
	<20140411163129.GA20565@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Fri, 11 Apr 2014 10:31:29 -0600, Jason Gunthorpe wrote:

> > Moreover, I am not entirely convinced that a PHY reset is needed here.
> > In my tests, doing just a wait after setting the local dev number was
> > sufficient. The fact is works with earlyprintk also indicates that we
> > don't need to do any specific action with the PHY, just to wait a bit
> > of time. I am worried that resetting the PHY might actually take more
> > time than what is needed, and may have other consequences that we don't
> > necessarily understand at this point.
> 
> I really disagree - clearly the fundamental problem is suspending one
> side of the PEX link while the other remains operating. That isn't
> specified to work and really shouldn't work.
> 
> If you suspend one side of the PEX you *MUST* reset the
> link. Absolutely. No Doubt In My Mind.
> 
> Remember, PCI-E is a serial shared state protocol. The two sides must
> remain in sync or a link reset is required to recover the shared
> state. Halting one side obviously destroys this invariant.
> 
> I think in many cases the reset happens autonomously. The remote side
> will force it to happen. This is what the debugging from Neil shows -
> the link just resets at some inconvenient point. Now we know why.
> 
> The timing sensitivity also makes sense, if you suspend for a very
> short time window the other side might not notice. If you suspend for
> longer the other side will reset the link autonomously and your local
> side will quickly notice the reset once it comes back.
> 
> If you suspend for a little bit the link might not retrain immediately
> but the shared state can become corrupted (eg sequence number
> mismatch) this will eventually trigger a reset, after the local PEX
> has been operating again.
> 
> The LinkUp bit after resume is also clearly a lie - most likely the
> PEX takes some time to detect the change in remote state to trigger a
> link down. After all, it was suspended while the remote was busy
> trying to recover.

Ok, fair enough. However, Neil's patch (which is basically your patch
with longer delays) isn't working here, as I just reported in a
separate e-mail.

So we don't have a solution right now. Do you have another proposal to
try ?

> The fundamental problem here is the clock driver. It should not be
> gating PEX clocks so naively. A PEX suspend needs to be sequenced to
> ensure the link is cleanly brought down before the PEX is put to
> sleep. That way it can cleanly and unambiguously be started up when it
> resumes. No risk of glitching/corrupting the far side with some kind
> of crap on the serial bus.
> 
> In any event, the most important required patch here is one that fixes
> socid. It must not turn off the PEX clock. Then we can talk about how
> to fix pci-mvebu to work as a module...

I don't really understand this: all clocks are gated at boot time, so
regardless of mvebu-soc-id behavior, the PCIe driver should take care
of doing all the necessary initialization without making the
assumptions that the clocks were left turned on from the bootloader
time. This is needed if we want to support pci-mvebu as a module, so I
don't see why hacking mvebu-soc-id is going to solve this.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
