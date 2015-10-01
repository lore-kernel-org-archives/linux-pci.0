Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52903 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbbJAJxv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 05:53:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	bhelgaas@google.com, tinamdar@apm.com, treding@nvidia.com,
	rjui@broadcom.com, Minghuan.Lian@freescale.com,
	m-karicheri2@ti.com, hauke@hauke-m.de, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v2] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL PCIe Host Controller
Date: Thu, 01 Oct 2015 11:52:58 +0200
Message-ID: <2677327.lnRZhqx5GI@wuerfel>
In-Reply-To: <1443689961-23909-1-git-send-email-bharatku@xilinx.com>
References: <1443689961-23909-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 01 October 2015 14:29:21 Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Removed unneccessary comments
> Modified setup_sspl implementation
> Added more details in binding Documentation
> ---
>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   49 +
>  drivers/pci/host/Kconfig                           |    9 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-xilinx-nwl.c                 | 1029 ++++++++++++++++++++
>  4 files changed, 1088 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> new file mode 100644
> index 0000000..ed87184
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> @@ -0,0 +1,49 @@
> +* Xilinx NWL PCIe Root Port Bridge DT description
> +
> +Required properties:
> +- compatible: Should contain "xlnx,nwl-pcie-2.11"
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- reg: Should contain Bridge, PCIe Controller registers location,
> +	configuration sapce, and length
> +- reg-names: Must include the following entries:
> +	"breg": bridge registers
> +	"pcireg": PCIe controller registers
> +	"cfg": configuration space region
> +- device_type: must be "pci"
> +- interrupts: Should contain NWL PCIe interrupt
> +- interrupt-names: Must include the following entries:
> +	"misc": interrupt asserted when miscellaneous is recieved
> +	"intx": interrupt that is asserted when an legacy interrupt is received
> +	"msi_1, msi_0": interrupt asserted when msi is recieved

The msi and intx interrupts don't really belong here: For intx, please
use an interrupt-map property as the other host drivers do.

For MSI, the usual answer is that there should be a separate device node
for the MSI controller, and an msi-parent property in the PCI host.

This lets you use the same code for hosts that have a GICv2m or GICv3
that comes with its own MSI controller.

> +/**
> + * struct nwl_pcie - PCIe port information
> + *
> + * @dev: Device pointer
> + * @breg_base: IO Mapped Bridge Register Base
> + * @pcireg_base: IO Mapped PCIe controller attributes
> + * @ecam_base: IO Mapped configuration space
> + * @phys_breg_base: Physical Bridge Register Base
> + * @phys_pcie_reg_base: Physical PCIe Controller Attributes
> + * @phys_ecam_base: Physical Configuration Base
> + * @breg_size: Bridge Register space
> + * @pcie_reg_size: PCIe controller attributes space
> + * @ecam_size: PCIe Configuration space
> + * @irq_intx: Legacy interrupt number
> + * @irq_misc: Misc interrupt number
> + * @ecam_value: ECAM value
> + * @last_busno: Last Bus number configured
> + * @link_up: Link status flag
> + * @enable_msi_fifo: Enable MSI FIFO mode
> + * @bus: PCI bus
> + * @msi: MSI interrupt info
> + */
> +struct nwl_pcie {
> +	struct device *dev;
> +	void __iomem *breg_base;
> +	void __iomem *pcireg_base;
> +	void __iomem *ecam_base;
> +	u32 phys_breg_base;
> +	u32 phys_pcie_reg_base;
> +	u32 phys_ecam_base;

These should probably be phys_addr_t.

> + * nwl_setup_sspl - Set Slot Power limit
> + *
> + * @pcie: PCIe port information
> + */
> +static int nwl_setup_sspl(struct nwl_pcie *pcie)
> +{
> +	unsigned int status;
> +	int retval = 0;
> +
> +	do {
> +		status = nwl_bridge_readl(pcie, TX_PCIE_MSG) & MSG_BUSY_BIT;
> +		if (!status) {
> +			/*
> +			 * Generate the TLP message for a single EP
> +			 * [TODO] Add a multi-endpoint code
> +			 */
> +			nwl_bridge_writel(pcie, 0x0,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_CNTL);
> +			nwl_bridge_writel(pcie, 0x0,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_SPEC_LO);
> +			nwl_bridge_writel(pcie, 0x0,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_SPEC_HI);
> +			nwl_bridge_writel(pcie, 0x0,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_DATA);
> +			/* Pattern to generate SSLP TLP */
> +			nwl_bridge_writel(pcie, PATTRN_SSLP_TLP,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_CNTL);
> +			nwl_bridge_writel(pcie, RANDOM_DIGIT,
> +					  TX_PCIE_MSG + TX_PCIE_MSG_DATA);
> +			nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> +					  TX_PCIE_MSG) | 0x1, TX_PCIE_MSG);
> +			status = 0;
> +			mdelay(2);

That is a really long delay. Can you use msleep(2) instead here?

> +
> +/* PCIe operations */
> +static struct pci_ops nwl_pcie_ops = {
> +	.read  = nwl_nwl_readl_config,
> +	.write = nwl_nwl_writel_config,
> +};

If the config space access is using ECAM, you should be able to use the
generic implementation for that. I don't know how far we got in splitting
that out, but it would be nice to not duplicate that here.

> +
> +static irqreturn_t nwl_pcie_leg_handler(int irq, void *data)
> +{
> +	struct nwl_pcie *pcie = (struct nwl_pcie *)data;
> +	u32 leg_stat;
> +
> +	/* Checking for legacy interrupts */
> +	leg_stat = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> +				MSGF_LEG_SR_MASKALL;
> +	if (!leg_stat)
> +		return IRQ_NONE;
> +
> +	if (leg_stat & MSGF_LEG_SR_INTA)
> +		dev_dbg(pcie->dev, "legacy interruptA\n");
> +
> +	if (leg_stat & MSGF_LEG_SR_INTB)
> +		dev_dbg(pcie->dev, "legacy interruptB\n");
> +
> +	if (leg_stat & MSGF_LEG_SR_INTC)
> +		dev_dbg(pcie->dev, "legacy interruptC\n");
> +
> +	if (leg_stat & MSGF_LEG_SR_INTD)
> +		dev_dbg(pcie->dev, "legacy interruptD\n");
> +
> +	return IRQ_HANDLED;
> +}

This does not appear to be an appropriate implementation. I suspect what
you need to do here is to model this as an irq_chip_generic, which
should be able to handle the status/mask/pending registers and
provide the irq domain that you will need for your DT irq-map
property.

	Arnd
