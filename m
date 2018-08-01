Return-Path: <SRS0=dvAb=KQ=bootlin.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=dvAb=KQ=bootlin.com=thomas.petazzoni@kernel.org>
Date: Wed, 1 Aug 2018 13:13:14 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org, Russell King
 <linux@arm.linux.org.uk>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Victor
 Gu <xigu@marvell.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Zachary Zhang <zhangzg@marvell.com>, Wilson
 Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Ray Jui
 <ray.jui@broadcom.com>, Ley Foon Tan <lftan@altera.com>, Simon Horman
 <horms@verge.net.au>
Subject: Re: [PATCH 1/3] PCI: Introduce PCI software bridge common logic
Message-ID: <20180801131314.360c9454@windsurf>
In-Reply-To: <20180801104957.1b01b847@windsurf>
References: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
	<20180629092231.32207-2-thomas.petazzoni@bootlin.com>
	<20180712195802.GC28466@bhelgaas-glaptop.roam.corp.google.com>
	<20180801104957.1b01b847@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Wed, 1 Aug 2018 10:49:57 +0200, Thomas Petazzoni wrote:

> > I wonder if there's a way to use a common helper function to do this.  
> 
> Yes, this small bit of logic is duplicated all over the place. I'll see
> if I can come up with some reasonable helpers for that.

Here is an attempt at doing this:

 - Introduce some helpers

   https://github.com/MISL-EBU-System-SW/mainline-public/commit/55543d2050d9aa3abe297569be830bde8680e1e9

 - Use them in drivers/pci/access.c

   https://github.com/MISL-EBU-System-SW/mainline-public/commit/ce6158d5c6a039e0cddf5ee6840dadeb46c5fc4b

 - Use them in PCI host controller drivers

   https://github.com/MISL-EBU-System-SW/mainline-public/commit/df4d0b5272ea3b4c3226c96466e5360c5a89253f

I'm not a big fan of the naming though. Let me know what you think, if
you think it's worth it, I'll submit the patches.

Note: the whole thing is compile-tested only for now.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
