Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44390 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932700AbeB1P2Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 10:28:16 -0500
Date: Wed, 28 Feb 2018 15:27:57 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Omri Itach <omrii@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Igal Liberman <igall@marvell.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Hanna Hawa <hannah@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/2] PCI: armada8k: Fix clock resource by adding a
 register clock
Message-ID: <20180228152756.GV9418@n2100.armlinux.org.uk>
References: <20180228144704.12947-1-gregory.clement@bootlin.com>
 <20180228144704.12947-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228144704.12947-3-gregory.clement@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 03:47:04PM +0100, Gregory CLEMENT wrote:
> @@ -229,6 +230,15 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (IS_ERR(pcie->clk_reg) && PTR_ERR(pcie->clk_reg) == -EPROBE_DEFER) {

You do realise this is needlessly complex.

Pointer errors are unique, so:

	if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER)) {

will do the same thing but without the complexity.  Transforming the
constant rather than the variable is also a good habbit to get into -
the compiler can optimise transforms to constants, but can't with
variables, so comparisons involving things like endian conversion
should always be done by transforming the constant not the variable.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
