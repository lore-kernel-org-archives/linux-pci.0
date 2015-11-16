Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50525 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbbKPPOm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Nov 2015 10:14:42 -0500
Message-ID: <5649F2D9.7070902@arm.com>
Date: Mon, 16 Nov 2015 15:14:33 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michals@xilinx.com, sorenb@xilinx.com, bhelgaas@google.com,
	arnd@arndb.de, tinamdar@apm.com, treding@nvidia.com,
	rjui@broadcom.com, Minghuan.Lian@freescale.com,
	m-karicheri2@ti.com, hauke@hauke-m.de, dhdang@apm.com,
	sbranden@broadcom.com
CC: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v8] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
References: <1447223619-30945-1-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1447223619-30945-1-git-send-email-bharatku@xilinx.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/11/15 06:33, Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Added logic to allocate contiguous hwirq in nwl_irq_domain_alloc function.
> Moved MSI functionality to separate functions.
> Changed error return values.
> ---
>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 ++
>  drivers/pci/host/Kconfig                           |   16 +-
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-xilinx-nwl.c                 | 1062 ++++++++++++++++++++
>  4 files changed, 1144 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
> 

[...]

> +static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
> +{
> +	struct platform_device *pdev = to_platform_device(pcie->dev);
> +	struct nwl_msi *msi = &pcie->msi;
> +	unsigned long base;
> +	int ret;
> +
> +	mutex_init(&msi->lock);
> +
> +	/* Check for msii_present bit */
> +	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
> +	if (!ret) {
> +		dev_err(pcie->dev, "MSI not present\n");
> +		ret = -EIO;
> +		goto err;
> +	}
> +
> +	/* Enable MSII */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, I_MSII_CONTROL) |
> +			  MSII_ENABLE, I_MSII_CONTROL);
> +
> +	/* Enable MSII status */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, I_MSII_CONTROL) |
> +			  MSII_STATUS_ENABLE, I_MSII_CONTROL);
> +
> +	/* setup AFI/FPCI range */
> +	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> +	base = virt_to_phys((void *)msi->pages);
> +	nwl_bridge_writel(pcie, lower_32_bits(base), I_MSII_BASE_LO);
> +	nwl_bridge_writel(pcie, upper_32_bits(base), I_MSII_BASE_HI);

BTW, you still haven't answered my question as to why you need to waste
a page of memory here, and why putting a device address doesn't work.

As this is (to the best of my knowledge) the only driver doing so, I'd
really like you to explain the rational behind this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
