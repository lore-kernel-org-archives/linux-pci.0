Return-Path: <SRS0=dvAb=KQ=bootlin.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=dvAb=KQ=bootlin.com=thomas.petazzoni@kernel.org>
Date: Wed, 1 Aug 2018 11:54:30 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement
 <gregory.clement@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Victor
 Gu <xigu@marvell.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Zachary Zhang <zhangzg@marvell.com>, Wilson
 Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Ray Jui
 <ray.jui@broadcom.com>, Ley Foon Tan <lftan@altera.com>, Simon Horman
 <horms@verge.net.au>
Subject: Re: [PATCH 1/3] PCI: Introduce PCI software bridge common logic
Message-ID: <20180801115430.388c62ae@windsurf>
In-Reply-To: <20180801092119.GB30658@n2100.armlinux.org.uk>
References: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
	<20180629092231.32207-2-thomas.petazzoni@bootlin.com>
	<20180712195802.GC28466@bhelgaas-glaptop.roam.corp.google.com>
	<20180801104957.1b01b847@windsurf>
	<20180801092119.GB30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello Russell,

On Wed, 1 Aug 2018 10:21:19 +0100, Russell King - ARM Linux wrote:


>    All PCI devices must treat Configuration Space write operations
>    to reserved registers as no-ops; that is, the access must be
>    completed normally on the bus and the data discarded. Read
>    accesses to reserved or unimplemented registers must be completed
>    normally and a data value of 0 returned.
> 
> (eg) PCI status:
>    Reserved bits should be read-only and return zero when read.
>    A one bit is reset (if it is not read-only) whenever the register
>    is written, and the write data in the corresponding bit location
>    is a 1.
> 
> [which is why doing the read-modify-write action that some host
>  bridges that only support 32-bit accesses is dangerous - it leads
>  to various status bits being inadvertently reset.]

Speaking of this, the generic pci_generic_config_write32() function
indeed does this incorrectly, and prints a warning.

However, I just looked at the pci-thunder-pem code, and it seems to
correctly account for those W1C bits, by having an explicit list of
registers and their W1C bits (see thunder_pem_bridge_w1c_bits). This
isn't specific to the Thunder PCIe controller at all, and would benefit
from being made generic, no ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
