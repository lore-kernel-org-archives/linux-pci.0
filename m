Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbdL1XBP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Dec 2017 18:01:15 -0500
Date: Thu, 28 Dec 2017 17:01:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/9] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20171228230111.GB19819@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <4b2b67ad54e14ee5e1f83af65e9932ce408e82ec.1513620412.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4b2b67ad54e14ee5e1f83af65e9932ce408e82ec.1513620412.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 18, 2017 at 07:16:06PM +0100, Cyrille Pitchen wrote:
> This patch adds support to the Cadence PCIe controller in host mode.
> 
> The "cadence/" entry in drivers/pci/Makefile is placed after the
> "endpoint/" entry so when the next patch introduces a EPC driver for the
> Cadence PCIe controller, drivers/pci/cadence/pcie-cadence-ep.o will be
> linked after drivers/pci/endpoint/*.o objects, otherwise the built-in
> pci-cadence-ep driver would be probed before the PCI endpoint libraries
> would have been initialized, which would result in a kernel crash.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>

> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 7284a7f6ad1e..a66ddb347798 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -54,5 +54,6 @@ obj-y += host/
>  obj-y += switch/
>  
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> +obj-$(CONFIG_PCI_CADENCE)	+= cadence/
>  # PCI dwc controller drivers
>  obj-y				+= dwc/

I don't like the fact that the cadence/ rule looks different than the
dwc/ rule for no obvious reason.  With some work, the dwc/ rule could
maybe be made to look like:

  obj-$(CONFIG_PCIE_DW)                 += dwc/

I *think* that should actually be pretty easy.  Everything in
drivers/pci/dwc/Kconfig selects PCIE_DW if set, either via
PCIE_DW_HOST or PCIE_DW_EP.

> diff --git a/drivers/pci/cadence/Kconfig b/drivers/pci/cadence/Kconfig
> new file mode 100644
> index 000000000000..0d15b40861e9
> --- /dev/null
> +++ b/drivers/pci/cadence/Kconfig
> @@ -0,0 +1,24 @@
> +menuconfig PCI_CADENCE
> +	bool "Cadence PCI controllers support"
> +	depends on PCI && HAS_IOMEM
> +	help
> +	  Say Y here if you want to support some Cadence PCI controller.
> +
> +	  When in doubt, say N.
> +
> +if PCI_CADENCE
> +
> +config PCIE_CADENCE
> +	bool
> +
> +config PCIE_CADENCE_HOST
> +	bool "Cadence PCIe host controller"
> +	depends on OF
> +	select IRQ_DOMAIN
> +	select PCIE_CADENCE
> +	help
> +	  Say Y here if you want to support the Cadence PCIe controller in host
> +	  mode. This PCIe controller may be embedded into many different vendors
> +	  SoCs.
> +
> +endif # PCI_CADENCE

Can you just use the same strategy as pci/dwc/Kconfig does, i.e., omit
the top-level PCI_CADENCE symbol?  If we don't need it for dwc, with
its dozen drivers, we probably don't need it for the one or two
Cadence drivers.

Bjorn
