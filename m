Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:45676 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbaICShW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 14:37:22 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so17886520pab.17
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 11:37:19 -0700 (PDT)
Date: Wed, 3 Sep 2014 12:37:49 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de, Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 1/4] PCI: designware: start parsing bus-range
Message-ID: <20140903183749.GB26073@google.com>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
 <1406137961-14684-2-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406137961-14684-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 23, 2014 at 07:52:38PM +0200, Lucas Stach wrote:
> This allows to explicitly specify the covered bus
> numbers in the devicetree, which will come in handy
> once we see a SoC with more than one PCIe host
> controller instance.
> 
> Previously the driver relied on the behavior of
> pci_scan_root_bus() to fill in a range of 0x00-0xff
> if no valid range was found. We fall back to the
> same range if no valid DT entry was found to keep
> backwards compatibility, but now do it explicitly.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt |  3 +++
>  drivers/pci/host/pcie-designware.c                        | 13 ++++++++++++-
>  drivers/pci/host/pcie-designware.h                        |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index ed0d9b9fff2b..9f4faa8e8d00 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -23,3 +23,6 @@ Required properties:
>  
>  Optional properties:
>  - reset-gpio: gpio pin number of power good signal
> +- bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
> +  specify this property, to keep backwards compatibility a range of 0x00-0xff
> +  is assumed if not present)
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 52bd3a143563..b13a830c8b0f 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -425,7 +425,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	struct resource *cfg_res;
>  	u32 val, na, ns;
>  	const __be32 *addrp;
> -	int i, index;
> +	int i, index, ret;
>  
>  	/* Find the address cell size and the number of cells in order to get
>  	 * the untranslated address.
> @@ -500,6 +500,16 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> +	ret = of_pci_parse_bus_range(np, &pp->busn);
> +	if (ret < 0) {
> +		dev_dbg(pp->dev, "failed to parse bus-range property: %d, using default [0x00-0xff]\n",
> +			ret);
> +		pp->busn.name = np->name;
> +		pp->busn.start = 0;
> +		pp->busn.end = 0xff;
> +		pp->busn.flags = IORESOURCE_BUS;
> +	}
> +

I tweaked this to look like:

+       if (ret < 0) {
+               pp->busn.name = np->name;
+               pp->busn.start = 0;
+               pp->busn.end = 0xff;
+               pp->busn.flags = IORESOURCE_BUS;
+               dev_dbg(pp->dev, "failed to parse bus-range property: %d, using default %pR\n",
+                       ret, &pp->busn);

to avoid the repetition of 0x00 and 0xff.

Pratyush, I added your Reviewed-by to patches 1 and 2, which I missed before.

Bjorn
