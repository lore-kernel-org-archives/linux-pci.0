Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50221 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754859AbbK0PdP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 Nov 2015 10:33:15 -0500
Message-ID: <565877B5.9060503@arm.com>
Date: Fri, 27 Nov 2015 15:33:09 +0000
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
Subject: Re: [PATCH v10] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
References: <1448636523-20503-1-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1448636523-20503-1-git-send-email-bharatku@xilinx.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/11/15 15:02, Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v10:
> -> Changed MSI address to PCIe controller base.
> -> Removed nwl_check_hwirq function, instead using bitmap_find_next_zero_area
>    API to do the same.
> ---
>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 ++
>  drivers/pci/host/Kconfig                           |   10 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-xilinx-nwl.c                 | 1068 ++++++++++++++++++++
>  4 files changed, 1147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> new file mode 100644
> index 0000000..d070344
> --- /dev/null
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c

[...]

> +#define MSI_ADDRESS				0xFD480000
> +

Really? Why do you bother having DT support then? You might as well
hardcode everything, while you're at it.

/me felling depressed now.

> +struct nwl_msi {			/* MSI information */
> +	struct irq_domain *msi_domain;
> +	unsigned long *bitmap;
> +	struct irq_domain *dev_domain;
> +	struct mutex lock;		/* protect bitmap variable */
> +	int irq_msi0;
> +	int irq_msi1;
> +};
> +
> +struct nwl_pcie {
> +	struct device *dev;
> +	void __iomem *breg_base;
> +	void __iomem *pcireg_base;
> +	void __iomem *ecam_base;
> +	u32 phys_breg_base;		/* Physical Bridge Register Base */
> +	u32 phys_pcie_reg_base;		/* Physical PCIe Controller Base */
> +	u32 phys_ecam_base;		/* Physical Configuration Base */

All these u32 should be phys_addr_t. Not all the world is 32bit,
fortunately.

> +	u32 breg_size;
> +	u32 pcie_reg_size;
> +	u32 ecam_size;
> +	int irq_intx;
> +	int irq_misc;
> +	u32 ecam_value;
> +	u8 last_busno;
> +	u8 root_busno;
> +	u8 link_up;
> +	struct nwl_msi msi;
> +	struct irq_domain *legacy_irq_domain;
> +};

[...]

> +static void nwl_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	phys_addr_t msi_addr = MSI_ADDRESS;

Fix this.

> +
> +	msg->address_lo = lower_32_bits(msi_addr);
> +	msg->address_hi = upper_32_bits(msi_addr);
> +	msg->data = data->hwirq;
> +}

[...]

> +static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
> +{
> +	struct platform_device *pdev = to_platform_device(pcie->dev);
> +	u32 breg_val, ecam_val, first_busno = 0;
> +	int err;
> +	int check_link_up = 0;
> +
> +	/* Check for BREG present bit */
> +	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
> +	if (!breg_val) {
> +		dev_err(pcie->dev, "BREG is not present\n");
> +		return breg_val;
> +	}
> +	/* Write bridge_off to breg base */
> +	nwl_bridge_writel(pcie, (u32)(pcie->phys_breg_base),
> +			  E_BREG_BASE_LO);
> +

I love the casting of a u32 to a u32. You have to program E_BREG_BASE_HI
as well, once you've fixed the data type.

> +	/* Enable BREG */
> +	nwl_bridge_writel(pcie, ~BREG_ENABLE_FORCE & BREG_ENABLE,
> +			  E_BREG_CONTROL);
> +
> +	/* Disable DMA channel registers */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX0) |
> +			  CFG_DMA_REG_BAR, BRCFG_PCIE_RX0);
> +
> +	/* Enable the bridge config interrupt */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_INTERRUPT) |
> +			  BRCFG_INTERRUPT_MASK, BRCFG_INTERRUPT);
> +	/* Enable Ingress subtractive decode translation */
> +	nwl_bridge_writel(pcie, SET_ISUB_CONTROL, I_ISUB_CONTROL);
> +
> +	/* Enable msg filtering details */
> +	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
> +			  BRCFG_PCIE_RX_MSG_FILTER);
> +	do {
> +		err = nwl_pcie_link_up(pcie, PHY_RDY_LINKUP);
> +		if (err != 1) {
> +			check_link_up++;
> +			if (check_link_up > LINKUP_ITER_CHECK)
> +				return -ENODEV;
> +			mdelay(1000);
> +		}
> +	} while (!err);
> +
> +	/* Check for ECAM present bit */
> +	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CAPABILITIES) & E_ECAM_PRESENT;
> +	if (!ecam_val) {
> +		dev_err(pcie->dev, "ECAM is not present\n");
> +		return ecam_val;
> +	}
> +
> +	/* Enable ECAM */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> +			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
> +	/* Write ecam_value on ecam_control */
> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> +			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
> +			  E_ECAM_CONTROL);
> +	/* Write phy_reg_base to ecam base */
> +	nwl_bridge_writel(pcie, (u32)pcie->phys_ecam_base, E_ECAM_BASE_LO);

Same here.

	M.
-- 
Jazz is not dead. It just smells funny...
