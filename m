Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965130AbeEYJft (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 May 2018 05:35:49 -0400
Date: Fri, 25 May 2018 10:35:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 0/6] PCI: rcar: Failpath fixes
Message-ID: <20180525093541.GB6507@e107981-ln.cambridge.arm.com>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Geert, Simon,

Can I retain your review tags on this series so that I can queue
the patches ? I already added them apart from the last patch that
is new, please let me know asap.

Thanks,
Lorenzo

On Thu, May 24, 2018 at 04:36:18PM +0200, Marek Vasut wrote:
> Multiple minor failpath fixes for the R-Car PCIe driver.
> 
> V4: Sync up the version numbers
>     Rebase on top of Lorenzo's tree
>     Add new patch fixing bug in the PHY code
> 
> Marek Vasut (6):
>   PCI: rcar: Pull bus clock enable/disable from
>     rcar_pcie_get_resources()
>   PCI: rcar: Add missing irq_dispose_mapping() into failpath
>   PCI: rcar: Teardown MSI setup if rcar_pcie_enable() fails
>   PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
>   PCI: rcar: Remove IRQ mappings in rcar_pcie_enable_msi failpath
>   PCI: rcar: Shut the PHY down in failpath
> 
>  drivers/pci/host/pcie-rcar.c | 82 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 66 insertions(+), 16 deletions(-)
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> 
> -- 
> 2.16.2
> 
