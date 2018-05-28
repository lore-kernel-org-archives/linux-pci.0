Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56112 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754051AbeE1Iyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 May 2018 04:54:38 -0400
Date: Mon, 28 May 2018 10:54:34 +0200
From: Simon Horman <horms@verge.net.au>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 0/6] PCI: rcar: Failpath fixes
Message-ID: <20180528085433.nl3thty2jk6y3e2n@verge.net.au>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
 <20180525164313.GA13284@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180525164313.GA13284@e107981-ln.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 25, 2018 at 05:43:13PM +0100, Lorenzo Pieralisi wrote:
> On Thu, May 24, 2018 at 04:36:18PM +0200, Marek Vasut wrote:
> > Multiple minor failpath fixes for the R-Car PCIe driver.
> > 
> > V4: Sync up the version numbers
> >     Rebase on top of Lorenzo's tree
> >     Add new patch fixing bug in the PHY code
> > 
> > Marek Vasut (6):
> >   PCI: rcar: Pull bus clock enable/disable from
> >     rcar_pcie_get_resources()
> >   PCI: rcar: Add missing irq_dispose_mapping() into failpath
> >   PCI: rcar: Teardown MSI setup if rcar_pcie_enable() fails
> >   PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
> >   PCI: rcar: Remove IRQ mappings in rcar_pcie_enable_msi failpath
> >   PCI: rcar: Shut the PHY down in failpath
> > 
> >  drivers/pci/host/pcie-rcar.c | 82 +++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 66 insertions(+), 16 deletions(-)
> 
> Marek,
> 
> I have applied patches [1-5] to pci/rcar for v4.18, I could not
> apply patch 6 since it is missing Simon's ACK (please have a look
> at what I queued to check it is OK).

Sorry for the delay. You should have that now.

If not, for the entire series:

Acked-by: Simon Horman <horms+renesas@verge.net.au>


> 
> Bjorn will be merging the branch into -next shortly, I do not know if
> there is room for adding additional patches on top of it, as I mentioned
> on linux-pci I will be offline for two weeks so it is possible that
> what's in pci/rcar at present will be what gets into v4.18, apologies,
> that's all I can do.
