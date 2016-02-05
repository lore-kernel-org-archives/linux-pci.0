Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: helgaas@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Vineet.Gupta1@synopsys.com
Subject: Re: [PATCH v2] synopsys pcie rc generic platform driver update
Date: Fri, 05 Feb 2016 16:52:38 +0100
Message-ID: <28529739.iy3JIrIuiT@wuerfel>
In-Reply-To: <192173247b53783570af804512f5ed8b1f84bc5d.1454682656.git.jpinto@synopsys.com>
References: <192173247b53783570af804512f5ed8b1f84bc5d.1454682656.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 05 February 2016 14:35:28 Joao Pinto wrote:
> The patch work consisted of:
> - driver name was changed from pcie-synopsys to pcie-designware-pltfm
> - mdelay() replaced for msleep() in the new driver
> - Devicetree bindings for the new driver was updated (config space removed
> from ranges and new compatibility strings were introduced)
> - Unnecessary synopsys_pcie_irq_handler() was removed
> - Driver compatibility strings updated
> 
> Patch was done against host/pcie-synopsys branch.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
> Changes v1->v2:
> - Patch description was not correct
> 
>  .../bindings/pci/pcie-designware-pltfm.txt         |  37 +++
>  .../devicetree/bindings/pci/pcie-synopsys.txt      |  33 ---
>  drivers/pci/host/Kconfig                           |   8 +-
>  drivers/pci/host/Makefile                          |   2 +-
>  drivers/pci/host/pcie-designware-pltfm.c           | 239 ++++++++++++++++++++
>  drivers/pci/host/pcie-synopsys.c                   | 250 ---------------------
>  6 files changed, 281 insertions(+), 288 deletions(-)

When you rename a file, please use 'git format-patch -M' so we can see
the differences, otherwise it's very hard to review.

> +Required properties:
> +- compatible: set to "snps,pcie-dw-platform" or "snps,pcie-dw-ipk" or
> +"pcie-dw-haps-prototyping";

This is still not very helpful.

The first string is useless because it does not identify a particular
hardware, and for the other two it is not clear what they mean.

Can you make a list of the *specific*versions* of the hardware that
are supported by the driver?

What about "pcie-dw"? Is that allowed or required or disallowed as
a fallback?

> +- reg: base address and length of the pcie controller registers and
> +configuration address space.
> +- reg-names: Must be "config" for the PCIe configuration space.

The example now has two register ranges, so please document what strings
are required here, and what the order should be.

Maybe also explain what "csr" stands for.

> +- #address-cells: set to <3>.
> +- #size-cells: set to <2>.
> +- device_type: set to "pci".
> +- ranges: ranges for the PCI memory and I/O regions.
> +- interrupts: one interrupt source for MSI interrupts, followed by interrupt
> +	source for hardware related interrupts.
> +- #interrupt-cells: set to <1>.
> +- num-lanes: set to <1>.
> +
> +Example configuration:
> +
> +	pcie: pcie@0xdffff000 {
> +		compatible = "snps,pcie-dw-platform";
> +		reg = <0xdffff000 0x1000
> +		       0xd0000000 0x2000>;

Please write this as:

		reg = <0xdffff000 0x1000>,
		      <0xd0000000 0x2000>;

> +#include "pcie-designware.h"
> +
> +#define to_dw_pltfm_pcie(x)	container_of(x, struct dw_pltfm_pcie, pp)
> +
> +struct dw_pltfm_pcie {
> +	void __iomem		*mem_base; /* Memory Base to access Core's [RC]
> +					    * Config Space Layout
> +					    */
> +	struct pcie_port	pp;        /* RC Root Port specific structure -
> +					    * DWC_PCIE_RC stuff
> +					    */
> +};
> +
> +#define PCI_EQUAL_CONTROL_PHY		0x00000707
> +#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010

If these are defined by synopsys, then move them to the generic header
file, and change all other drivers that have similar macros to use the
same definitions.

> +/* PCIe Port Logic registers (memory-mapped) */
> +#define PLR_OFFSET 0x700
> +#define PCIE_PHY_DEBUG_R0 (PLR_OFFSET + 0x28) /* 0x728 */
> +#define PCIE_PHY_DEBUG_R1 (PLR_OFFSET + 0x2c) /* 0x72c */

Same here.

> +static irqreturn_t dw_pltfm_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	return dw_handle_msi_irq(pp);
> +}

Please explain more about how the MSI stuff is integrated into
the hardware. Is this always part of the PCIe block in all version,
or is it optional? In which version was it first added?

Also, how does the MSI block serialize against DMAs on the parent bus?
So far, nobody could explain this, so it might be good to have this
documented.

> +static void dw_pltfm_pcie_init_phy(struct pcie_port *pp)
> +{
> +	/* write Lane 0 Equalization Control fields register */
> +	writel(PCI_EQUAL_CONTROL_PHY, pp->dbi_base + 0x154);
> +}
> +
> +static int dw_pltfm_pcie_deassert_core_reset(struct pcie_port *pp)
> +{
> +	return 0;
> +}
> +
> +static void dw_pltfm_pcie_establish_link(struct pcie_port *pp)
> +{
> +	int retries;
> +
> +	/* wait for link to come up */
> +	for (retries = 0; retries < 10; retries++) {
> +		if (dw_pcie_link_up(pp)) {
> +			dev_info(pp->dev, "Link up\n");
> +			return;
> +		}
> +		msleep(100);
> +	}
> +
> +	dev_err(pp->dev, "Link fail\n");
> +}

Independent of what else we do, I think this needs to be moved
into the common part and all other implementations we have changed
to either use it directly or call it from their version.

	Arnd
