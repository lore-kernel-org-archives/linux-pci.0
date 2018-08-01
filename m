Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35725 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbeHAMdG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 08:33:06 -0400
Message-ID: <1533120474.20186.9.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] Workaround for IMX7d PCI-e PLL lock failure
From: Lucas Stach <l.stach@pengutronix.de>
To: Trent Piepho <tpiepho@impinj.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Date: Wed, 01 Aug 2018 12:47:54 +0200
In-Reply-To: <20180718194424.8844-1-tpiepho@impinj.com>
References: <20180718194424.8844-1-tpiepho@impinj.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Trent,

Am Mittwoch, den 18.07.2018, 12:44 -0700 schrieb Trent Piepho:
> This is the workaround for the IMX7d Erratum e10728, failure of
> initialize PCIe PLL VCO oscillation resulting in PLL lock failure and
> failure of the PCI-e link to come up.
> 
> The registers used in the workaround are based on the latest patch in
> the NXP kernel, but many things around that have been changed.
> 
> This uses a new node of type fsl,imx-pcie-phy to get the PHY's
> registers.  The node is found via a phandle added to the PCI-e
> controller's node, rather than the incorrect way done in the NXP kernel.
> 
> There is no error if the phandle is not preset (since it's needed except
> for the imx7d workaround and no existing dtses have it), but if preset
> it is an error if something relating to it does not work.
> 
> ** Should the node be fsl,imx7d-pcie-phy?  snps,dw-pcie-phy?  
> 
> There is little to no documenation from NXP and Synopsis about this, so I'm
> unsure of the PHY's lineage.
> 
> The imx6 PCI-e driver does not use the generic phy layer to interact
> with the PHY.  It appears PHY related hardware, like clocks, regulators,
> and resets, are part of the fsl,imx6q-pcie node.  But again, the
> topology of this hardware is not documented very well.
> 
> Another approach would be to add the PHY registers as another bank in
> the PCI-e node.  This would match how the PHY reset, clock, etc.  are
> done.  However, the PHY is attached to a different AXI master than the
> PCI-e controller, so the register range really does not belong there.

I took some time pondering about the way this is done. There are some
small issues in the implementation (see my replies to the individual
patches), but the overall approach taken looks fine to me.

Regards,
Lucas
