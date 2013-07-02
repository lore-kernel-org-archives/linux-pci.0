Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41396 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab3GBIDc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2013 04:03:32 -0400
Date: Tue, 2 Jul 2013 10:03:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Sean Cross <xobs@kosagi.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] PCI: Add driver for i.MX6 PCI Express
Message-ID: <20130702080327.GD516@pengutronix.de>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
 <1372662947-27160-4-git-send-email-xobs@kosagi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372662947-27160-4-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 01, 2013 at 07:15:46AM +0000, Sean Cross wrote:
> This adds a PCI Express port driver for the on-chip PCI Express port
> present on the i.MX6 SoC.  It is based on the PCI Express driver available
> in the Freescale BSP.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---
>  .../devicetree/bindings/pci/imx6q-pcie.txt         |   20 +
>  arch/arm/mach-imx/Kconfig                          |    1 +
>  drivers/pci/pcie/Kconfig                           |   10 +
>  drivers/pci/pcie/Makefile                          |    2 +
>  drivers/pci/pcie/pcie-imx.c                        | 1049 ++++++++++++++++++++
>  5 files changed, 1082 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/imx6q-pcie.txt
>  create mode 100644 drivers/pci/pcie/pcie-imx.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/imx6q-pcie.txt
> new file mode 100644
> index 0000000..2dc9eae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/imx6q-pcie.txt
> @@ -0,0 +1,20 @@
> +* Freescale i.MX6Q PCI Express bridge
> +
> +Example (i.MX6Q)
> +	pcie: pcie@01ffc000 {
> +		compatible = "fsl,imx6q-pcie";
> +		reg = <0x01ffc000 0x4000>,
> +		      <0x01000000 0x100000>,
> +		      <0x01100000 0xe00000>,
> +		      <0x01f00000 0xfc000>;
> +		interrupts = <0 122 0x04>;
> +		clocks = <&clks 186>, <&clks 189>, <&clks 196>,
> +			 <&clks 198>, <&clks 144>;
> +		clock-names = "sata_ref", "pcie_ref_125m", "lvds1_sel",
> +			      "lvds1", "pcie_axi";
> +		power-enable = <&gpio7 12 0>;
> +		pcie-reset = <&gpio3 29 0>;
> +		wake-up = <&gpio3 22 0>;
> +		disable-endpoint = <&gpio2 16 0>;
> +	};
> +
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index ba44328..cad4e5a 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -811,6 +811,7 @@ config SOC_IMX6Q
>  	select PL310_ERRATA_588369 if CACHE_PL310
>  	select PL310_ERRATA_727915 if CACHE_PL310
>  	select PL310_ERRATA_769419 if CACHE_PL310
> +	select MIGHT_HAVE_PCI
>  	select PM_OPP if PM
>  
>  	help
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 569f82f..d1d70db 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -83,3 +83,13 @@ endchoice
>  config PCIE_PME
>  	def_bool y
>  	depends on PCIEPORTBUS && PM_RUNTIME
> +
> +#
> +# Platform driver for i.MX6
> +#
> +config PCIE_IMX
> +        bool "Support for i.MX6"
> +        depends on SOC_IMX6Q
> +        help
> +          Enable support for the 1x PCI Express bus on the Freescale i.MX6
> +        depends on PCIEPORTBUS && PM_RUNTIME
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 00c62df..5393d21 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -14,3 +14,5 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>  obj-$(CONFIG_PCIEAER)		+= aer/
>  
>  obj-$(CONFIG_PCIE_PME) += pme.o
> +
> +obj-$(CONFIG_PCIE_IMX)		+= pcie-imx.o
> diff --git a/drivers/pci/pcie/pcie-imx.c b/drivers/pci/pcie/pcie-imx.c
> new file mode 100644
> index 0000000..664679e
> --- /dev/null
> +++ b/drivers/pci/pcie/pcie-imx.c
> @@ -0,0 +1,1049 @@
> +/*
> + * drivers/pci/pcie/pcie-imx.c
> + *
> + * PCIe host controller driver for IMX6 SOCs
> + *
> + * Copyright (C) 2012 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * Code originally taken from Freescale linux-2.6.35 BSP.
> + *
> + * Other bits taken from arch/arm/mach-dove/pcie.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/rfkill.h>
> +
> +#include <asm/sizes.h>
> +#include <asm/io.h>
> +
> +
> +/* IOMUXC */
> +#define IOMUXC_GPR0                     (0x00)
> +#define IOMUXC_GPR1                     (0x04)
> +#define IOMUXC_GPR2                     (0x08)
> +#define IOMUXC_GPR3                     (0x0C)
> +#define IOMUXC_GPR4                     (0x10)
> +#define IOMUXC_GPR5                     (0x14)
> +#define IOMUXC_GPR6                     (0x18)
> +#define IOMUXC_GPR7                     (0x1C)
> +#define IOMUXC_GPR8                     (0x20)
> +#define IOMUXC_GPR9                     (0x24)
> +#define IOMUXC_GPR10                    (0x28)
> +#define IOMUXC_GPR11                    (0x2C)
> +#define IOMUXC_GPR12                    (0x30)
> +#define IOMUXC_GPR13                    (0x34)

These are already defined in include/linux/mfd/syscon/imx6q-iomuxc-gpr.h

> +
> +
> +/* Register Definitions */
> +#define PRT_LOG_R_BaseAddress 0x700
> +
> +/* Register DEBUG_R0 */
> +/* Debug Register 0 */
> +#define DEBUG_R0 (PRT_LOG_R_BaseAddress + 0x28)
> +#define DEBUG_R0_RegisterSize 32
> +#define DEBUG_R0_RegisterResetValue 0x0
> +#define DEBUG_R0_RegisterResetMask 0xFFFFFFFF
> +/* End of Register Definition for DEBUG_R0 */
> +
> +/* Register DEBUG_R1 */
> +/* Debug Register 1 */
> +#define DEBUG_R1 (PRT_LOG_R_BaseAddress + 0x2c)
> +#define DEBUG_R1_RegisterSize 32
> +#define DEBUG_R1_RegisterResetValue 0x0
> +#define DEBUG_R1_RegisterResetMask 0xFFFFFFFF
> +/* End of Register Definition for DEBUG_R1 */
> +
> +#define ATU_R_BaseAddress 0x900
> +#define PCIE_PL_iATUVR (ATU_R_BaseAddress + 0x0)
> +#define PCIE_PL_iATURC1 (ATU_R_BaseAddress + 0x4)
> +#define PCIE_PL_iATURC2 (ATU_R_BaseAddress + 0x8)
> +#define PCIE_PL_iATURLBA (ATU_R_BaseAddress + 0xC)
> +#define PCIE_PL_iATURUBA (ATU_R_BaseAddress + 0x10)
> +#define PCIE_PL_iATURLA (ATU_R_BaseAddress + 0x14)
> +#define PCIE_PL_iATURLTA (ATU_R_BaseAddress + 0x18)
> +#define PCIE_PL_iATURUTA (ATU_R_BaseAddress + 0x1C)

PleaseGetRidOfThisCamelCase.

> +
> +/* GPR1: iomuxc_gpr1_pcie_ref_clk_en(iomuxc_gpr1[16]) */
> +#define iomuxc_gpr1_pcie_ref_clk_en		(1 << 16)
> +/* GPR1: iomuxc_gpr1_test_powerdown(iomuxc_gpr1_18) */
> +#define iomuxc_gpr1_test_powerdown		(1 << 18)

Defines should use uppercase letters. Besides, we already have these in
include/linux/mfd/syscon/imx6q-iomuxc-gpr.h. If there's something
missing add them there not in your driver.

> +
> +/* GPR12: iomuxc_gpr12_los_level(iomuxc_gpr12[8:4]) */
> +#define iomuxc_gpr12_los_level			(0x1F << 4)
> +/* GPR12: iomuxc_gpr12_app_ltssm_enable(iomuxc_gpr12[10]) */
> +#define iomuxc_gpr12_app_ltssm_enable		(1 << 10)
> +/* GPR12: iomuxc_gpr12_device_type(iomuxc_gpr12[15:12]) */
> +#define iomuxc_gpr12_device_type		(0xF << 12)
> +
> +/* GPR8: iomuxc_gpr8_tx_deemph_gen1(iomuxc_gpr8[5:0]) */
> +#define iomuxc_gpr8_tx_deemph_gen1		(0x3F << 0)
> +/* GPR8: iomuxc_gpr8_tx_deemph_gen2_3p5db(iomuxc_gpr8[11:6]) */
> +#define iomuxc_gpr8_tx_deemph_gen2_3p5db	(0x3F << 6)
> +/* GPR8: iomuxc_gpr8_tx_deemph_gen2_6db(iomuxc_gpr8[17:12]) */
> +#define iomuxc_gpr8_tx_deemph_gen2_6db		(0x3F << 12)
> +/* GPR8: iomuxc_gpr8_tx_swing_full(iomuxc_gpr8[24:18]) */
> +#define iomuxc_gpr8_tx_swing_full		(0x7F << 18)
> +/* GPR8: iomuxc_gpr8_tx_swing_low(iomuxc_gpr8[31:25]) */
> +#define iomuxc_gpr8_tx_swing_low		(0x7F << 25)
> +
> +/* Registers of PHY */
> +/* Register PHY_STS_R */
> +/* PHY Status Register */
> +#define PHY_STS_R (PRT_LOG_R_BaseAddress + 0x110)
> +
> +/* Register PHY_CTRL_R */
> +/* PHY Control Register */
> +#define PHY_CTRL_R (PRT_LOG_R_BaseAddress + 0x114)
> +
> +#define SSP_CR_SUP_DIG_MPLL_OVRD_IN_LO 0x0011
> +/* FIELD: RES_ACK_IN_OVRD [15:15]
> +// FIELD: RES_ACK_IN [14:14]
> +// FIELD: RES_REQ_IN_OVRD [13:13]
> +// FIELD: RES_REQ_IN [12:12]
> +// FIELD: RTUNE_REQ_OVRD [11:11]
> +// FIELD: RTUNE_REQ [10:10]
> +// FIELD: MPLL_MULTIPLIER_OVRD [9:9]
> +// FIELD: MPLL_MULTIPLIER [8:2]
> +// FIELD: MPLL_EN_OVRD [1:1]
> +// FIELD: MPLL_EN [0:0]

If you would use defines instead of comments these would actually be
useful.

> +*/
> +
> +#define SSP_CR_SUP_DIG_ATEOVRD 0x0010
> +/* FIELD: ateovrd_en [2:2]
> +// FIELD: ref_usb2_en [1:1]
> +// FIELD: ref_clkdiv2 [0:0]
> +*/
> +
> +#define SSP_CR_LANE0_DIG_RX_OVRD_IN_LO 0x1005
> +/* FIELD: RX_LOS_EN_OVRD [13:13]
> +// FIELD: RX_LOS_EN [12:12]
> +// FIELD: RX_TERM_EN_OVRD [11:11]
> +// FIELD: RX_TERM_EN [10:10]
> +// FIELD: RX_BIT_SHIFT_OVRD [9:9]
> +// FIELD: RX_BIT_SHIFT [8:8]
> +// FIELD: RX_ALIGN_EN_OVRD [7:7]
> +// FIELD: RX_ALIGN_EN [6:6]
> +// FIELD: RX_DATA_EN_OVRD [5:5]
> +// FIELD: RX_DATA_EN [4:4]
> +// FIELD: RX_PLL_EN_OVRD [3:3]
> +// FIELD: RX_PLL_EN [2:2]
> +// FIELD: RX_INVERT_OVRD [1:1]
> +// FIELD: RX_INVERT [0:0]
> +*/
> +
> +#define SSP_CR_LANE0_DIG_RX_ASIC_OUT 0x100D
> +/* FIELD: LOS [2:2]
> +// FIELD: PLL_STATE [1:1]
> +// FIELD: VALID [0:0]
> +*/
> +
> +/* control bus bit definition */
> +#define PCIE_CR_CTL_DATA_LOC 0
> +#define PCIE_CR_CTL_CAP_ADR_LOC 16
> +#define PCIE_CR_CTL_CAP_DAT_LOC 17
> +#define PCIE_CR_CTL_WR_LOC 18
> +#define PCIE_CR_CTL_RD_LOC 19
> +#define PCIE_CR_STAT_DATA_LOC 0
> +#define PCIE_CR_STAT_ACK_LOC 16
> +
> +/* End of Register Definitions */
> +
> +#define  PCIE_CONF_BUS(b)		(((b) & 0xFF) << 16)
> +#define  PCIE_CONF_DEV(d)		(((d) & 0x1F) << 11)
> +#define  PCIE_CONF_FUNC(f)		(((f) & 0x7) << 8)
> +#define  PCIE_CONF_REG(r)		((r) & ~0x3)
> +
> +
> +/* Taken from PCI specs */
> +enum {
> +	MemRdWr = 0,
> +	MemRdLk = 1,
> +	IORdWr = 2,
> +	CfgRdWr0 = 4,
> +	CfgRdWr1 = 5
> +};
> +
> +
> +struct imx_pcie_port {
> +	struct device		*dev;
> +	u8			index;
> +	u8			root_bus_nr;
> +	int			interrupt;
> +
> +	struct resource		*dbi;
> +	struct resource		*io;
> +	struct resource 	*mem;
> +	struct resource 	*root;
> +
> +	struct regmap		*iomuxc_gpr;
> +
> +	void __iomem		*root_base;
> +	void __iomem		*dbi_base;
> +	void __iomem		*io_base;
> +	void __iomem		*mem_base;
> +	spinlock_t		conf_lock;
> +
> +	char			io_space_name[16];
> +	char			mem_space_name[16];
> +
> +	struct list_head	next;
> +
> +	struct clk		*lvds1_sel;
> +	struct clk		*lvds1;
> +	struct clk		*pcie_ref_125m;
> +	struct clk		*pcie_axi;
> +	struct clk		*sata_ref;
> +
> +        unsigned int		pcie_pwr_en;
> +        unsigned int		pcie_rst;
> +        unsigned int		pcie_wake_up;

Whitespace damage here.

> +
> +	struct rfkill		*rfkill;
> +};
> +
> +static const struct of_device_id pcie_of_match[] = {
> +	{
> +		.compatible	= "fsl,imx6q-pcie",
> +		.data		= NULL,

No need to set .data to NULL.

> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pcie_of_match);
> +
> +static struct list_head pcie_port_list;
> +static struct hw_pci imx_pcie;
> +
> +static int pcie_phy_cr_read(void __iomem *dbi_base, int addr, int *data);
> +static int pcie_phy_cr_write(void __iomem *dbi_base, int addr, int data);
> +
> +
> +/* IMX PCIE GPR configure routines */
> +static void imx_pcie_clrset(struct imx_pcie_port *pp,
> +			    u32 mask, u32 val, u32 reg)
> +{
> +	u32 tmp;
> +	regmap_read(pp->iomuxc_gpr, reg, &tmp);
> +	tmp &= ~mask;
> +	tmp |= (val & mask);
> +	regmap_write(pp->iomuxc_gpr, reg, tmp);
> +}

This duplicates regmap_update_bits without the locking.

> +
> +static void change_field(int *in, int start, int end, int val)
> +{
> +	int mask;
> +	mask = ((0xFFFFFFFF << start) ^ (0xFFFFFFFF << (end + 1))) & 0xFFFFFFFF;
> +	*in = (*in & ~mask) | (val << start);
> +}
> +
> +
> +static struct imx_pcie_port *controller_to_port(int index)
> +{
> +	struct imx_pcie_port *pp;
> +
> +	if (index >= imx_pcie.nr_controllers) {
> +		pr_err("%d exceeded number of controllers %d\n",
> +			index, imx_pcie.nr_controllers);
> +		return NULL;
> +	}
> +
> +	list_for_each_entry(pp, &pcie_port_list, next) {
> +		if (pp->index == index)
> +			return pp;
> +	}
> +	return NULL;
> +}
> +
> +static struct imx_pcie_port *bus_to_port(int bus)
> +{
> +	int i;
> +	int rbus;
> +	struct imx_pcie_port *pp;
> +
> +	for (i = imx_pcie.nr_controllers - 1 ; i >= 0; i--) {
> +		pp = controller_to_port(i);
> +		rbus = pp->root_bus_nr;
> +		if (rbus != -1 && rbus <= bus)
> +			break;
> +	}
> +
> +	return i >= 0 ? pp : NULL;
> +}

There's certainly something wrong here if you have to iterate over lists
to find your own private data. struct pci_sys_data has a private_data
field exactly for this purpose.

> +
> +static int __init imx_pcie_setup(int nr, struct pci_sys_data *sys)
> +{
> +	struct imx_pcie_port *pp;
> +	int ret;
> +
> +	pp = controller_to_port(nr);
> +	if (!pp) {
> +		pr_err("unable to find port %d\n", nr);
> +		return 0;
> +	}
> +
> +	pp->root_bus_nr = sys->busnr;
> +
> +	/*
> +	 * IORESOURCE_MEM
> +	 */
> +	snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
> +			"PCIe %d MEM", pp->index);
> +
> +	pp->mem_space_name[sizeof(pp->mem_space_name) - 1] = 0;
> +	pp->mem->name = pp->mem_space_name;
> +	pp->mem->flags = IORESOURCE_MEM;
> +	ret = request_resource(&iomem_resource, pp->mem);
> +	if (ret)
> +		dev_err(pp->dev, "Request PCIe Memory resource failed\n");
> +	pci_add_resource_offset(&sys->resources, pp->mem, sys->mem_offset);
> +
> +
> +	snprintf(pp->io_space_name, sizeof(pp->io_space_name),
> +		 "PCIe %d I/O", pp->index);
> +	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
> +	pp->io->name = pp->io_space_name;
> +	pp->io->flags = IORESOURCE_IO;
> +
> +	ret = request_resource(&iomem_resource, pp->io);
> +	if (ret)
> +		dev_err(pp->dev, "Request PCIe IO resource failed\n");
> +	pci_add_resource_offset(&sys->resources, pp->io, sys->io_offset);
> +
> +	/*
> +	 * IORESOURCE_IO
> +	 */
> +	ret = pci_ioremap_io(PCIBIOS_MIN_IO, pp->io->start);
> +	if (ret)
> +		dev_err(pp->dev, "Request PCIe IO resource failed\n");
> +
> +	return 1;
> +}
> +
> +static int imx_pcie_link_up(struct platform_device *pdev)
> +{
> +	struct imx_pcie_port *pp = platform_get_drvdata(pdev);
> +	int iterations = 200;
> +	u32 rc, ltssm, rx_valid, temp;
> +
> +	rc = 0;
> +	for (iterations = 200; iterations > 0 && !rc; iterations--) {
> +		/* link is debug bit 36, debug register 1 starts at bit 32 */
> +		rc = readl(pp->dbi_base + DEBUG_R1) & (0x1 << (36 - 32)) ;
> +		usleep_range(2000, 3000);
> +
> +		/* From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
> +		 * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
> +		 * If (MAC/LTSSM.state == Recovery.RcvrLock)
> +		 * && (PHY/rx_valid==0) then pulse PHY/rx_reset. Transition
> +		 * to gen2 is stuck
> +		 */

Sorry, what? Do others understand what the problem is? Can we clarify
this?

> +		pcie_phy_cr_read(pp->dbi_base, SSP_CR_LANE0_DIG_RX_ASIC_OUT, &rx_valid);
> +		ltssm = readl(pp->dbi_base + DEBUG_R0) & 0x3F;
> +		if ((ltssm == 0x0D) && ((rx_valid & 0x01) == 0)) {
> +			dev_err(&pdev->dev,
> +				"transition to gen2 is stuck, reset PHY!\n");
> +			pcie_phy_cr_read(pp->dbi_base, SSP_CR_LANE0_DIG_RX_OVRD_IN_LO, &temp);
> +			change_field(&temp, 3, 3, 0x1);
> +			change_field(&temp, 5, 5, 0x1);

I wonder how complicated one can write temp |= (1 << 3) | (1 << 5).
Please get rid of this change_field function.

> +			pcie_phy_cr_write(pp->dbi_base, SSP_CR_LANE0_DIG_RX_OVRD_IN_LO,
> +					0x0028);
> +			usleep_range(2000, 3000);
> +			pcie_phy_cr_read(pp->dbi_base, SSP_CR_LANE0_DIG_RX_OVRD_IN_LO, &temp);
> +			change_field(&temp, 3, 3, 0x0);
> +			change_field(&temp, 5, 5, 0x0);
> +			pcie_phy_cr_write(pp->dbi_base, SSP_CR_LANE0_DIG_RX_OVRD_IN_LO,
> +					0x0000);
> +		}
> +
> +	}
> +
> +	if (!rc) {
> +		if (iterations <= 0) {
> +			dev_err(&pdev->dev,
> +				"link up failed, DEBUG_R0:0x%08x, DEBUG_R1:0x%08x  RX_VALID:0x%x!\n",
> +				readl(pp->dbi_base + DEBUG_R0),
> +				readl(pp->dbi_base + DEBUG_R1),
> +				rx_valid);
> +			return -ETIMEDOUT;
> +		}
> +		return -ENODEV;

I wonder under which circumstances you can reach this -ENODEV.

> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_pcie_regions_setup(struct platform_device *pdev,
> +					struct imx_pcie_port *pp)
> +{
> +	void __iomem *dbi_base = pp->dbi_base;
> +	/*
> +	 * i.MX6 defines 16MB in the AXI address map for PCIe.
> +	 *
> +	 * That address space excepted the pcie registers is
> +	 * split and defined into different regions by iATU,
> +	 * with sizes and offsets as follows:
> +	 *
> +	 * 0x0100_0000 --- 0x010F_FFFF 1MB IORESOURCE_IO
> +	 * 0x0110_0000 --- 0x01EF_FFFF 14MB IORESOURCE_MEM
> +	 * 0x01F0_0000 --- 0x01FF_FFFF 1MB Cfg + Registers
> +	 */
> +
> +	/* CMD reg:I/O space, MEM space, and Bus Master Enable */
> +	writel(readl(dbi_base + PCI_COMMAND)
> +			| PCI_COMMAND_IO
> +			| PCI_COMMAND_MEMORY
> +			| PCI_COMMAND_MASTER,
> +			dbi_base + PCI_COMMAND);
> +
> +	/* Set the CLASS_REV of RC CFG header to PCI_CLASS_BRIDGE_PCI */
> +	writel(readl(dbi_base + PCI_CLASS_REVISION)
> +			| (PCI_CLASS_BRIDGE_PCI << 16),
> +			dbi_base + PCI_CLASS_REVISION);
> +
> +	/*
> +	 * region0 outbound used to access target cfg
> +	 */
> +	writel(0, dbi_base + PCIE_PL_iATUVR);
> +	writel(pp->root->start, dbi_base + PCIE_PL_iATURLBA);
> +	writel(pp->dbi->end, dbi_base + PCIE_PL_iATURLA);
> +	writel(0, dbi_base + PCIE_PL_iATURUBA);
> +
> +	writel(0, dbi_base + PCIE_PL_iATURLTA);
> +	writel(0, dbi_base + PCIE_PL_iATURUTA);
> +	writel(CfgRdWr0, dbi_base + PCIE_PL_iATURC1);
> +	writel((1<<31), dbi_base + PCIE_PL_iATURC2);
> +
> +	return 0;
> +}
> +
> +
> +static int imx_pcie_valid_config(struct imx_pcie_port *pp,
> +				struct pci_bus *bus, int devfn)
> +{
> +	if (bus->number >= 2)
> +		return 0;
> +
> +	if (devfn != 0)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +
> +static u32 get_bus_address(struct imx_pcie_port *pp,
> +			   struct pci_bus *bus, u32 devfn, int where)
> +{
> +	u32 va_address;
> +	if (bus->number == 0) {
> +		va_address = (u32)pp->dbi_base + (where & ~0x3);
> +	}
> +	else {

The 'else' is supposed to be on the same line as the '}'

> +		va_address = (u32)pp->root_base +
> +					(PCIE_CONF_BUS(bus->number - 1) +
> +					PCIE_CONF_DEV(PCI_SLOT(devfn)) +
> +					PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
> +					PCIE_CONF_REG(where));
> +	}
> +	return va_address;
> +}
> +
> +static int imx_pcie_read_config(struct pci_bus *bus, u32 devfn, int where,
> +			int size, u32 *val)
> +{
> +	struct imx_pcie_port *pp = bus_to_port(bus->number);
> +	u32 va_address;
> +
> +	if (!pp) {
> +		BUG();
> +		return -EINVAL;
> +	}
> +
> +	if (imx_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	va_address = get_bus_address(pp, bus, devfn, where);
> +
> +	*val = readl((u32 *)va_address);
> +
> +	if (size == 1)
> +		*val = (*val >> (8 * (where & 3))) & 0xFF;
> +	else if (size == 2)
> +		*val = (*val >> (8 * (where & 3))) & 0xFFFF;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int imx_pcie_write_config(struct pci_bus *bus, u32 devfn,
> +			int where, int size, u32 val)
> +{
> +	struct imx_pcie_port *pp = bus_to_port(bus->number);
> +	u32 va_address = 0, mask = 0, tmp = 0;
> +	int ret = PCIBIOS_SUCCESSFUL;
> +
> +	if (!pp) {
> +		BUG();
> +		return -EINVAL;
> +	}
> +
> +	if (imx_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	va_address = get_bus_address(pp, bus, devfn, where);
> +
> +	if (size == 4) {
> +		writel(val, (u32 *)va_address);
> +		goto exit;
> +	}
> +
> +	if (size == 2)
> +		mask = ~(0xFFFF << ((where & 0x3) * 8));
> +	else if (size == 1)
> +		mask = ~(0xFF << ((where & 0x3) * 8));
> +	else
> +		ret = PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	tmp = readl((u32 *)va_address) & mask;
> +	tmp |= val << ((where & 0x3) * 8);
> +	writel(tmp, (u32 *)va_address);
> +exit:
> +
> +	return ret;
> +}
> +
> +
> +
> +static struct pci_ops imx_pcie_ops = {
> +	.read = imx_pcie_read_config,
> +	.write = imx_pcie_write_config,
> +};
> +
> +static struct pci_bus __init *
> +imx_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> +{
> +	struct imx_pcie_port *pp = controller_to_port(nr);
> +	if (nr > 1)
> +		return NULL;
> +        pp->root_bus_nr = sys->busnr;
> +
> +        return pci_scan_root_bus(NULL, sys->busnr, &imx_pcie_ops, sys,
> +                                 &sys->resources);

Whitespace damage here.

> +}
> +
> +static int __init imx_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	struct imx_pcie_port *pp = controller_to_port(0);
> +	return pp->interrupt;
> +}
> +
> +static struct hw_pci imx_pci __initdata = {
> +	.nr_controllers	= 1,
> +	.setup		= imx_pcie_setup,
> +	.scan		= imx_pcie_scan_bus,
> +	.map_irq	= imx_pcie_map_irq,
> +};
> +
> +/* PHY CR bus acess routines */
> +static int pcie_phy_cr_ack_polling(void __iomem *dbi_base, int max_iterations, int exp_val)
> +{
> +	u32 temp_rd_data, wait_counter = 0;
> +
> +	do {
> +		temp_rd_data = readl(dbi_base + PHY_STS_R);
> +		temp_rd_data = (temp_rd_data >> PCIE_CR_STAT_ACK_LOC) & 0x1;
> +		wait_counter++;
> +	} while ((wait_counter < max_iterations) && (temp_rd_data != exp_val));
> +
> +	if (temp_rd_data != exp_val)
> +		return 0 ;
> +	return 1 ;
> +}
> +
> +static int pcie_phy_cr_cap_addr(void __iomem *dbi_base, int addr)
> +{
> +	u32 temp_wr_data;
> +
> +	/* write addr */
> +	temp_wr_data = addr << PCIE_CR_CTL_DATA_LOC ;
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* capture addr */
> +	temp_wr_data |= (0x1 << PCIE_CR_CTL_CAP_ADR_LOC);
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* wait for ack */
> +	if (!pcie_phy_cr_ack_polling(dbi_base, 100, 1))
> +		return 0;
> +
> +	/* deassert cap addr */
> +	temp_wr_data = addr << PCIE_CR_CTL_DATA_LOC;
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* wait for ack de-assetion */
> +	if (!pcie_phy_cr_ack_polling(dbi_base, 100, 0))
> +		return 0 ;
> +
> +	return 1 ;

Remove the whitespace before the semicolons, also elsewhere in this
patch.

> +}
> +
> +static int pcie_phy_cr_read(void __iomem *dbi_base, int addr , int *data)
> +{
> +	u32 temp_rd_data, temp_wr_data;
> +
> +	/*  write addr */
> +	/* cap addr */
> +	if (!pcie_phy_cr_cap_addr(dbi_base, addr))
> +		return 0;
> +
> +	/* assert rd signal */
> +	temp_wr_data = 0x1 << PCIE_CR_CTL_RD_LOC;
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* wait for ack */
> +	if (!pcie_phy_cr_ack_polling(dbi_base, 100, 1))
> +		return 0;
> +
> +	/* after got ack return data */
> +	temp_rd_data = readl(dbi_base + PHY_STS_R);
> +	*data = (temp_rd_data & (0xffff << PCIE_CR_STAT_DATA_LOC)) ;
> +
> +	/* deassert rd signal */
> +	temp_wr_data = 0x0;
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* wait for ack de-assetion */

s/assetion/assertion/

This typo is multiple times in this patch.

> +	if (!pcie_phy_cr_ack_polling(dbi_base, 100, 0))
> +		return 0 ;
> +
> +	return 1 ;
> +
> +}
> +
> +static int pcie_phy_cr_write(void __iomem *dbi_base, int addr, int data)
> +{
> +	u32 temp_wr_data;
> +
> +	/* write addr */
> +	/* cap addr */
> +	if (!pcie_phy_cr_cap_addr(dbi_base, addr))
> +		return 0 ;
> +
> +	temp_wr_data = data << PCIE_CR_CTL_DATA_LOC;
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* capture data */
> +	temp_wr_data |= (0x1 << PCIE_CR_CTL_CAP_DAT_LOC);
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* wait for ack */
> +	if (!pcie_phy_cr_ack_polling(dbi_base, 100, 1))
> +		return 0 ;
> +
> +	/* deassert cap data */
> +	temp_wr_data = data << PCIE_CR_CTL_DATA_LOC;
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* wait for ack de-assetion */
> +	if (!pcie_phy_cr_ack_polling(dbi_base, 100, 0))
> +		return 0;
> +
> +	/* assert wr signal */
> +	temp_wr_data = 0x1 << PCIE_CR_CTL_WR_LOC;
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* wait for ack */
> +	if (!pcie_phy_cr_ack_polling(dbi_base, 100, 1))
> +		return 0;
> +
> +	/* deassert wr signal */
> +	temp_wr_data = data << PCIE_CR_CTL_DATA_LOC;
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	/* wait for ack de-assetion */
> +	if (!pcie_phy_cr_ack_polling(dbi_base, 100, 0))
> +		return 0;
> +
> +	temp_wr_data = 0x0 ;
> +	writel(temp_wr_data, dbi_base + PHY_CTRL_R);
> +
> +	return 1;
> +}
> +
> +static int imx_pcie_enable_controller(struct platform_device *pdev)
> +{
> +	struct imx_pcie_port *pp = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	/* Enable PCIE power */
> +	gpio_set_value(pp->pcie_pwr_en, 1);
> +
> +	imx_pcie_clrset(pp, iomuxc_gpr1_test_powerdown, 0 << 18, IOMUXC_GPR1);
> +	imx_pcie_clrset(pp, iomuxc_gpr1_pcie_ref_clk_en, 1 << 16, IOMUXC_GPR1);
> +
> +	/* Enable clocks */
> +	ret = clk_set_parent(pp->lvds1_sel, pp->sata_ref);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to set lvds1 parent: %d\n", ret);
> +		return -EINVAL;
> +	}

This should be done in architecture code I think.

> +
> +	ret = clk_prepare_enable(pp->pcie_ref_125m);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to enable pcie_ref_125m: %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_prepare_enable(pp->lvds1);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to enable lvds1: %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_prepare_enable(pp->pcie_axi);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to enable pcie_axi: %d\n", ret);
> +		return -EINVAL;
> +	}

This function does not disable the already enabled clocks in the error
path. Please fix.

> +
> +
> +	return 0;
> +}
> +
> +static void card_reset(struct platform_device *pdev)
> +{
> +	struct imx_pcie_port *pp = platform_get_drvdata(pdev);
> +
> +	imx_pcie_clrset(pp, iomuxc_gpr1_test_powerdown, 1 << 18, IOMUXC_GPR1);
> +	imx_pcie_clrset(pp, iomuxc_gpr12_app_ltssm_enable, 1 << 10, IOMUXC_GPR12);
> +	imx_pcie_clrset(pp, iomuxc_gpr1_pcie_ref_clk_en, 0 << 16, IOMUXC_GPR1);
> +
> +	gpio_set_value(pp->pcie_rst, 0);
> +	msleep(100);
> +	gpio_set_value(pp->pcie_rst, 1);
> +}
> +
> +static int __init add_pcie_port(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx_pcie_port *pp = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = imx_pcie_link_up(pdev);
> +	if (ret) {
> +		dev_info(dev, "IMX PCIe port: link down!\n");
> +		/* Release the clocks, and disable the power */
> +
> +		clk_disable(pp->pcie_axi);
> +		clk_put(pp->pcie_axi);
> +
> +		clk_disable(pp->lvds1);
> +		clk_put(pp->lvds1);
> +
> +		clk_put(pp->pcie_ref_125m);
> +		clk_put(pp->sata_ref);

You clk_put the clocks in the error path of the probe function. Don't
duplicate it.

> +
> +		imx_pcie_clrset(pp, iomuxc_gpr1_pcie_ref_clk_en, 0 << 16,
> +				IOMUXC_GPR1);
> +
> +		/* Disable PCIE power */
> +		gpio_set_value(pp->pcie_pwr_en, 0);
> +
> +		imx_pcie_clrset(pp, iomuxc_gpr1_test_powerdown, 1 << 18,
> +				IOMUXC_GPR1);
> +
> +		return ret;
> +	}
> +
> +	dev_info(dev, "IMX PCIe port: link up.\n");
> +	pp->index = 0;
> +	pp->root_bus_nr = -1;
> +	spin_lock_init(&pp->conf_lock);
> +	return 0;
> +}
> +
> +
> +static int set_pcie_clock_tunings(struct platform_device *pdev)
> +{
> +	struct imx_pcie_port *pp = platform_get_drvdata(pdev);
> +	/* FIXME the field name should be aligned to RM */
> +	imx_pcie_clrset(pp, iomuxc_gpr12_app_ltssm_enable, 0 << 10, IOMUXC_GPR12);
> +
> +	/* configure constant input signal to the pcie ctrl and phy */
> +	imx_pcie_clrset(pp, iomuxc_gpr12_device_type, PCI_EXP_TYPE_ROOT_PORT << 12,
> +			IOMUXC_GPR12);
> +	imx_pcie_clrset(pp, iomuxc_gpr12_los_level, 9 << 4, IOMUXC_GPR12);
> +
> +	imx_pcie_clrset(pp, iomuxc_gpr8_tx_deemph_gen1, 0 << 0, IOMUXC_GPR8);
> +	imx_pcie_clrset(pp, iomuxc_gpr8_tx_deemph_gen2_3p5db, 0 << 6, IOMUXC_GPR8);
> +	imx_pcie_clrset(pp, iomuxc_gpr8_tx_deemph_gen2_6db, 20 << 12, IOMUXC_GPR8);
> +	imx_pcie_clrset(pp, iomuxc_gpr8_tx_swing_full, 127 << 18, IOMUXC_GPR8);
> +	imx_pcie_clrset(pp, iomuxc_gpr8_tx_swing_low, 127 << 25, IOMUXC_GPR8);
> +	return 0;
> +}
> +
> +
> +static int __init imx_pcie_pltfm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx_pcie_port *pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
> +	int ret;
> +
> +	platform_set_drvdata(pdev, pp);
> +	pp->dev = &pdev->dev;
> +
> +        pp->pcie_pwr_en = of_get_named_gpio(pdev->dev.of_node,
> +                                "power-enable", 0);
> +        if (gpio_is_valid(pp->pcie_pwr_en))
> +                devm_gpio_request_one(dev, pp->pcie_pwr_en,
> +                                    GPIOF_OUT_INIT_LOW,
> +                                    "PCIe power enable");
> +
> +        pp->pcie_rst = of_get_named_gpio(pdev->dev.of_node,
> +                                "pcie-reset", 0);
> +        if (gpio_is_valid(pp->pcie_rst))
> +                devm_gpio_request_one(dev, pp->pcie_rst,
> +                                    GPIOF_OUT_INIT_LOW,
> +                                    "PCIe reset");
> +
> +        pp->pcie_wake_up = of_get_named_gpio(pdev->dev.of_node,
> +                                "wake-up", 0);
> +        if (gpio_is_valid(pp->pcie_wake_up))
> +                devm_gpio_request_one(dev, pp->pcie_wake_up,
> +                                    GPIOF_IN,
> +                                    "PCIe wake up");

More whitespace damage above.

> +
> +	pp->dbi = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!pp->dbi) {
> +		dev_err(dev, "no mmio space\n");
> +		return -EINVAL;
> +	}
> +
> +	pp->dbi_base = devm_request_and_ioremap(&pdev->dev, pp->dbi);
> +	if (!pp->dbi_base) {
> +		pr_err("unable to remap dbi\n");
> +		return -ENOMEM;
> +	}
> +
> +
> +	pp->io = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!pp->io) {
> +		dev_err(dev, "no mmio space\n");
> +		return -EINVAL;
> +	}
> +
> +	pp->mem = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	if (!pp->mem) {
> +		dev_err(dev, "no mmio space\n");
> +		return -EINVAL;
> +	}
> +
> +	pp->root = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +	if (!pp->root) {
> +		dev_err(dev, "no root memory space\n");
> +		return -EINVAL;
> +	}
> +
> +	pp->root_base = devm_request_and_ioremap(&pdev->dev, pp->root);
> +	if (!pp->root_base) {
> +		dev_err(&pdev->dev, "unable to remap root mem\n");
> +		return -ENOMEM;
> +	}
> +
> +
> +	pp->interrupt = platform_get_irq(pdev, 0);
> +
> +
> +        /* Setup clocks */

Whitespace damage here.

> +	pp->lvds1_sel = clk_get(dev, "lvds1_sel");

Use devm_clk_get

> +	if (IS_ERR(pp->lvds1_sel)) {
> +		dev_err(dev,
> +			"lvds1_sel clock missing or invalid\n");
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	pp->lvds1 = clk_get(dev, "lvds1");
> +	if (IS_ERR(pp->lvds1)) {
> +		dev_err(dev,
> +			"lvds1 clock select missing or invalid\n");
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	pp->pcie_ref_125m = clk_get(dev, "pcie_ref_125m");
> +	if (IS_ERR(pp->pcie_ref_125m)) {
> +		dev_err(dev,
> +			"pcie_ref_125m clock source missing or invalid\n");
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	pp->pcie_axi = clk_get(dev, "pcie_axi");
> +	if (IS_ERR(pp->pcie_axi)) {
> +		dev_err(dev, "pcie_axi clock source missing or invalid\n");
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	pp->sata_ref = clk_get(dev, "sata_ref");
> +	if (IS_ERR(pp->sata_ref)) {
> +		dev_err(dev, "sata_ref clock source missing or invalid\n");
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	pp->iomuxc_gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +	if (IS_ERR(pp->iomuxc_gpr)) {
> +		dev_err(dev, "unable to find iomuxc registers\n");
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	/* togle the external card's reset */
> +	card_reset(pdev);
> +
> +	/* Enable the pwr, clks and so on */
> +	set_pcie_clock_tunings(pdev);
> +	ret = imx_pcie_enable_controller(pdev);
> +	if (ret)
> +		goto err_out;
> +
> +	usleep_range(3000, 4000);
> +	imx_pcie_regions_setup(pdev, pp);
> +	usleep_range(3000, 4000);

Are these usleeps required?

> +
> +	/* start link up */
> +	imx_pcie_clrset(pp, iomuxc_gpr12_app_ltssm_enable, 1 << 10, IOMUXC_GPR12);
> +
> +	/* add the pcie port */
> +	ret = add_pcie_port(pdev);
> +	if (ret)
> +		goto err_out;
> +
> +	pp->index = imx_pcie.nr_controllers;
> +	imx_pcie.nr_controllers++;
> +	list_add_tail(&pp->next, &pcie_port_list);
> +
> +	pci_common_init(&imx_pci);
> +
> +	return 0;
> +
> +err_out:
> +	if (pp->lvds1_sel)
> +		clk_put(pp->lvds1_sel);
> +	if (pp->lvds1)
> +		clk_put(pp->lvds1);
> +	if (pp->pcie_ref_125m)
> +		clk_put(pp->pcie_ref_125m);
> +	if (pp->pcie_axi)
> +		clk_put(pp->pcie_axi);
> +	if (pp->sata_ref)
> +		clk_put(pp->sata_ref);

You shouldn't call clk_put with error codes.

> +	return ret;
> +}
> +
> +static int __exit imx_pcie_pltfm_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx_pcie_port *pp = platform_get_drvdata(pdev);
> +
> +	if (pp->rfkill) {
> +		rfkill_unregister(pp->rfkill);
> +		rfkill_destroy(pp->rfkill);
> +		pp->rfkill = NULL;
> +	}
> +
> +	imx_pcie_clrset(pp, iomuxc_gpr1_pcie_ref_clk_en, 0 << 16, IOMUXC_GPR1);
> +	imx_pcie_clrset(pp, iomuxc_gpr1_test_powerdown, 1 << 18, IOMUXC_GPR1);
> +	imx_pcie_clrset(pp, iomuxc_gpr12_app_ltssm_enable, 1 << 10, IOMUXC_GPR12);
> +
> +	/* Release clocks, and disable power  */
> +	if (pp->pcie_axi) {
> +		clk_disable(pp->pcie_axi);
> +		clk_put(pp->pcie_axi);
> +	}
> +
> +	if (pp->lvds1) {
> +		clk_disable(pp->lvds1);
> +		clk_put(pp->lvds1);
> +	}
> +
> +	if (pp->pcie_ref_125m)
> +		clk_put(pp->pcie_ref_125m);
> +
> +	if (pp->sata_ref)
> +		clk_put(pp->sata_ref);

All these tests are *always* true.

> +
> +	gpio_set_value(pp->pcie_rst, 0);
> +	gpio_set_value(pp->pcie_pwr_en, 0);
> +
> +	dev_err(dev, "disabled everything\n");

Remove this.

> +	msleep(500);

Why?

> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver imx_pcie_pltfm_driver = {
> +	.driver = {
> +		.name		= "imx-pcie",
> +		.owner		= THIS_MODULE,
> +		.of_match_table = pcie_of_match,
> +	},
> +	.probe		= imx_pcie_pltfm_probe,
> +	.remove		= __exit_p(imx_pcie_pltfm_remove),
> +};
> +
> +/*****************************************************************************\
> + *                                                                           *
> + * Driver init/exit                                                          *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static int __init imx_pcie_drv_init(void)
> +{
> +	INIT_LIST_HEAD(&pcie_port_list);
> +	return platform_driver_register(&imx_pcie_pltfm_driver);
> +}
> +
> +static void __exit imx_pcie_drv_exit(void)
> +{
> +	platform_driver_unregister(&imx_pcie_pltfm_driver);
> +}
> +
> +module_init(imx_pcie_drv_init);
> +module_exit(imx_pcie_drv_exit);
> +
> +MODULE_DESCRIPTION("i.MX PCIE platform driver");
> +MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
