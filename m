Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:52037 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865AbaDJWHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Apr 2014 18:07:31 -0400
Date: Thu, 10 Apr 2014 16:06:50 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Neil Greatorex <neil@fatboyfat.co.uk>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140410220650.GA10540@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
 <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 10, 2014 at 10:56:00PM +0100, Neil Greatorex wrote:

> >diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
> >index f3b325f..e0a032f 100644
> >+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
> >@@ -107,7 +107,7 @@ static int __init mvebu_soc_id_init(void)
> >       iounmap(pci_base);
> >
> >res_ioremap:
> >-       clk_disable_unprepare(clk);
> >+//     clk_disable_unprepare(clk);
> >
> >clk_err:
> >       of_node_put(child);
> >
> 
> That patch has fixed it for me. The PCIe card seems to be now be
> always properly detected.

Okay, that makes lots of sense to me at least.

Gregory: I have this vauge recollection it was discussed when you
wrote the mvebu_soc_id_init patch to use a __clk_is_enabled but got
shot down? Clearly this needs to be fixed.

> >In any event, turning on the clock should almost certainly be
> >accompanied by a phy reset sequence to get both link ends on the same
> >page.
> >
> >Attached is a rough, untested patch along those lines.
> >
> 
> I took your attached patch and extended it a bit to print out how
> long it took. The delays also need to be much longer for me. I also
> fixed a small typo you made where the bit wasn't being set again to
> bring the link back up. I've attached the diff to your patch, as
> well as the combined patch (hope that makes sense).

Just to be clear you tried this alone without the above?

Thanks for fixing the patch, I think it also confirms the theory.

IMHO, both approaches are required.

The first prevents messing up the PEX as was left by the bootloader

The second allows the driver to startup a PEX that wasn't enabled by
the bootloader, and recover from clock gating in the kernel (eg the
modular case)

Both seem valuable..

Ideally I'd like to see the clk driver turn off the PEX PHY when it
gates the clock, but I have no great idea how to accomplish that sort
of cross register space adventure...

Thomas, if we can figure out how to properly do __clk_is_enabled I
can probably send a proper patch?

Thanks,
Jason
