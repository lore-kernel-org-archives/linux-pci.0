Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57034 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752973AbcJKQXc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Oct 2016 12:23:32 -0400
Subject: Re: [PATCH 3/4] PCI: dra7xx: Add support to force RC to work in GEN1
 mode
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
References: <1476190715-16884-1-git-send-email-kishon@ti.com>
 <1476190715-16884-4-git-send-email-kishon@ti.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <cd8d9591-1f21-a44d-93e5-282acd992900@ti.com>
Date: Tue, 11 Oct 2016 21:49:55 +0530
MIME-Version: 1.0
In-Reply-To: <1476190715-16884-4-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 11 October 2016 06:28 PM, Kishon Vijay Abraham I wrote:
> PCIe in AM57x/DRA7x devices is by default
> configured to work in GEN2 mode.  However there
> may be situations when working in GEN1 mode is
> desired. One example is limitation i925 (PCIe GEN2
> mode not supported at junction temperatures < 0C).
> 
> Add support to force Root Complex to work in GEN1
> mode if so desired, but don't force GEN1 mode on
> any board just yet.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt |    1 +
>  drivers/pci/host/pci-dra7xx.c                    |   27 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 60e2516..a3d6ca3 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -25,6 +25,7 @@ PCIe Designware Controller
>  
>  Optional Property:
>   - gpios : Should be added if a gpio line is required to drive PERST# line
> + - ti,pcie-is-gen1 : Force the PCIe controller to work in GEN1 (2.5 GT/s).
>  
>  Example:
>  axi {
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 4ccba6d..2a669cb 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -63,11 +63,14 @@
>  #define	LINK_UP						BIT(16)
>  #define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
>  
> +#define EXP_CAP_ID_OFFSET				0x70
> +
>  struct dra7xx_pcie {
>  	struct pcie_port	pp;
>  	void __iomem		*base;		/* DT ti_conf */
>  	int			phy_count;	/* DT phy-names count */
>  	struct phy		**phy;
> +	bool			is_gen1;

I think it will be nice to reference the errata number as comments in
the code along with references to TI public documentation that explains
the said errata.

Or may be this can be added to the binding documentation. Somewhere 'git
grep' can find.

BTW, per Documentation/devicetree/bindings/submitting-patches.txt, the
binding documentation should be a separate patch.

Thanks,
Sekhar

