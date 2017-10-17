Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937589AbdJQTXF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 15:23:05 -0400
Date: Tue, 17 Oct 2017 14:23:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        nsekhar@ti.com
Subject: Re: [PATCH 3/4] PCI: dwc: dra7xx: Add support for SoC specific
 compatible strings
Message-ID: <20171017192302.GK5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20171010101606.15951-1-kishon@ti.com>
 <20171010101606.15951-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171010101606.15951-4-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

s/PCI: dwc: dra7xx: Add support for SoC specific compatible strings/
  PCI: dra7xx: Add dra726 and dra746 compatible strings/
  
I think including "dwc" makes sense for things that involve the DW
core, but this is really dra7xx-specific.  And I think the *support*
for SoC-specific strings was already there; it looks like this patch
simply adds some of those strings.

On Tue, Oct 10, 2017 at 03:46:05PM +0530, Kishon Vijay Abraham I wrote:
> dra74x/dra76x and dra72x has separate compatible strings. Add support
> for these compatible strings in pci-dra7xx driver.

s/has separate/have separate/

> This is a preparatory patch for adding 2-lane mode support and
> dra74/dra72 should add it's own driver data for 2-lane mode
> configuration.

s/it's/its/

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 362607f727ee..78a87a8f1362 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -542,6 +542,22 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>  		.compatible = "ti,dra7-pcie-ep",
>  		.data = &dra7xx_pcie_ep_of_data,
>  	},
> +	{
> +		.compatible = "ti,dra746-pcie-rc",
> +		.data = &dra7xx_pcie_rc_of_data,
> +	},
> +	{
> +		.compatible = "ti,dra746-pcie-ep",
> +		.data = &dra7xx_pcie_ep_of_data,
> +	},
> +	{
> +		.compatible = "ti,dra726-pcie-rc",
> +		.data = &dra7xx_pcie_rc_of_data,
> +	},
> +	{
> +		.compatible = "ti,dra726-pcie-ep",
> +		.data = &dra7xx_pcie_ep_of_data,
> +	},
>  	{},
>  };
>  
> -- 
> 2.11.0
> 
