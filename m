Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/3] phy: keystone: serdes driver for gbe 10gbe and pcie
To: WingMan Kwok <w-kwok2@ti.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rogerq@ti.com>, <m-karicheri2@ti.com>, <bhelgaas@google.com>,
	<ssantosh@kernel.org>, <linux@arm.linux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <1444759464-32299-1-git-send-email-w-kwok2@ti.com>
 <1444759464-32299-2-git-send-email-w-kwok2@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <561D8C91.5060403@ti.com>
Date: Wed, 14 Oct 2015 04:28:25 +0530
MIME-Version: 1.0
In-Reply-To: <1444759464-32299-2-git-send-email-w-kwok2@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 13 October 2015 11:34 PM, WingMan Kwok wrote:
> On TI's Keystone platforms, several peripherals such as the
> gbe ethernet switch, 10gbe ethernet switch and PCIe controller
> require the use of a SerDes for converting SoC parallel data into
> serialized data that can be output over a high-speed electrical
> interface, and also converting high-speed serial input data
> into parallel data that can be processed by the SoC.  The
> SerDeses used by those peripherals, though they may be different,
> are largely similar in functionality and setup.
> 
> This patch provides a SerDes phy driver implementation that can be
> used by the above mentioned peripheral drivers to configure their
> respective SerDeses.
> 
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |  256 +++
>  drivers/phy/Kconfig                              |    8 +
>  drivers/phy/Makefile                             |    1 +
>  drivers/phy/phy-keystone-serdes.c                | 2465 ++++++++++++++++++++++
>  4 files changed, 2730 insertions(+)
>  create mode 100644 drivers/phy/phy-keystone-serdes.c
> 

<snip>

> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 47da573..8fc21a4 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -118,6 +118,14 @@ config PHY_RCAR_GEN2
>  	help
>  	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
>  
> +config PHY_TI_KEYSTONE_SERDES
> +	tristate "TI Keystone SerDes PHY support"
> +	depends on OF && ARCH_KEYSTONE
> +	select GENERIC_PHY
> +	help
> +	  This option enables support for TI Keystone SerDes PHY found
> +	  in peripherals GBE, 10GBE and PCIe.
> +
>  config OMAP_CONTROL_PHY
>  	tristate "OMAP CONTROL PHY Driver"
>  	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index a5b18c1..8cb365b 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -46,3 +46,4 @@ obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-14nm.o
>  obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
>  obj-$(CONFIG_PHY_BRCMSTB_SATA)		+= phy-brcmstb-sata.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> +obj-$(CONFIG_PHY_TI_KEYSTONE_SERDES)	+= phy-keystone-serdes.o
> diff --git a/drivers/phy/phy-keystone-serdes.c b/drivers/phy/phy-keystone-serdes.c
> new file mode 100644
> index 0000000..c73d4de
> --- /dev/null
> +++ b/drivers/phy/phy-keystone-serdes.c
> @@ -0,0 +1,2465 @@
> +/*
> + * Texas Instruments Keystone SerDes driver
> + * Authors: WingMan Kwok <w-kwok2@ti.com>
> + *
> + * This is the SerDes Phy driver for Keystone devices. This is
> + * required to support PCIe RC functionality based on designware
> + * PCIe hardware, gbe and 10gbe found on these devices.
> + *
> + * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + * Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *
> + * Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the
> + * distribution.
> + *
> + * Neither the name of Texas Instruments Incorporated nor the names of
> + * its contributors may be used to endorse or promote products derived
> + * from this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * The contents of the array k2_100mhz_pcie_5gbps_serdes is covered by BSD
> + * license.
> + */
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/random.h>
> +#include <linux/firmware.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * Keystone2 SERDES registers
> + */
> +/* 0x1fc0 - 0x1fff */
> +#define KSERDES_SS_OFFSET	0x1fc0
> +/* 0x1fc0 */
> +#define MOD_VER_REG		(KSERDES_SS_OFFSET + 0x00)
> +/* 0x1fc4 */
> +#define MEM_ADR_REG		(KSERDES_SS_OFFSET + 0x04)
> +/* 0x1fc8 */
> +#define MEM_DAT_REG		(KSERDES_SS_OFFSET + 0x08)
> +/* 0x1fcc */
> +#define MEM_DATINC_REG		(KSERDES_SS_OFFSET + 0x0c)
> +/* 0x1fd0 */
> +#define CPU_CTRL_REG		(KSERDES_SS_OFFSET + 0x10)
> +/* 0x1fe0, 0x1fe4 */
> +#define LANE_CTRL_STS_REG(x)	(KSERDES_SS_OFFSET + 0x20 + (x * 0x04))
> +/* 0x1ff0 */
> +#define LINK_LOSS_WAIT_REG	(KSERDES_SS_OFFSET + 0x30)
> +/* 0x1ff4 */
> +#define PLL_CTRL_REG		(KSERDES_SS_OFFSET + 0x34)
> +
> +/* CMU0 SS 0x0000 - 0x01ff */
> +#define CMU0_SS_OFFSET		0x0000
> +#define CMU0_REG(x)		(CMU0_SS_OFFSET + x)
> +
> +/* LANE SS 0x0200 - 0x03ff, 0x0400 - 0x05ff, ... */
> +#define LANE0_SS_OFFSET		0x0200
> +#define LANEX_SS_OFFSET(x)	(LANE0_SS_OFFSET * (x + 1))
> +#define LANEX_REG(x, y)		(LANEX_SS_OFFSET(x) + y)
> +
> +/* CML SS 0x0a00 - 0x0bff */
> +#define CML_SS_OFFSET		0x0a00
> +#define CML_REG(x)		(CML_SS_OFFSET + x)
> +
> +/* CMU1 SS 0x0c00 - 0x0dff */
> +#define CMU1_SS_OFFSET		0x0c00
> +#define CMU1_REG(x)		(CMU1_SS_OFFSET + x)
> +
> +/*
> + * XGE PCS-R registers
> + */
> +#define PCSR_OFFSET(x)		(x * 0x80)
> +
> +#define PCSR_TX_CTL(x)		(PCSR_OFFSET(x) + 0x00)
> +#define PCSR_TX_STATUS(x)	(PCSR_OFFSET(x) + 0x04)
> +#define PCSR_RX_CTL(x)		(PCSR_OFFSET(x) + 0x08)
> +#define PCSR_RX_STATUS(x)	(PCSR_OFFSET(x) + 0x0C)
> +
> +#define XGE_CTRL_OFFSET		0x0c
> +#define PCIE_PL_GEN2_OFFSET	0x180c
> +
> +#define reg_rmw(addr, value, mask) \
> +	__raw_writel(((__raw_readl(addr) & (~(mask))) | \
> +			(value & (mask))), (addr))
> +
> +/* bit mask from bit-a to bit-b inclusive */
> +#define MASK(msb, lsb) \
> +	((((msb) - (lsb)) == 31) ? 0xffffffff :  \
> +		((((u32)1 << ((msb) - (lsb) + 1)) - 1) << (lsb)))

use GENMASK instead?
> +
> +/* Replaces bit field [msb:lsb] in register located
> + * at (base + offset) by val
> + */
> +#define FINSR(base, offset, msb, lsb, val) \
> +	reg_rmw((base) + (offset), ((val) << (lsb)), MASK((msb), (lsb)))
> +
> +/* This version of FEXTR is NOT safe for msb = 31, lsb = 0
> + * but then why would we need FEXTR for that case.
> + */
> +#define FEXTR(val, msb, lsb) \
> +	(((val) >> (lsb)) & ((1 << ((msb) - (lsb) + 1)) - 1))
> +
> +#define MOD_VER(serdes) \
> +	((kserdes_readl(serdes, MOD_VER_REG) >> 16) & 0xffff)
> +
> +#define PHY_A(serdes) (MOD_VER(serdes) != 0x4eba)
> +
> +#define FOUR_LANE(serdes) \
> +	((MOD_VER(serdes) == 0x4eb9) || (MOD_VER(serdes) == 0x4ebd))
> +
> +#define LANE_ENABLE(sc, n) ((sc)->lane[n].enable)
> +
> +#define for_each_enable_lane(func, sc)			\
> +	do {						\
> +		int i;					\
> +		for (i = 0; i < (sc)->lanes; i++) {	\
> +			if (!LANE_ENABLE((sc), i))	\
> +				continue;		\
> +							\
> +			(func)((sc), i);		\
> +		}					\
> +	} while (0)
> +
> +#define for_each_lane(func, sc)				\
> +	do {						\
> +		int i;					\
> +		for (i = 0; i < (sc)->lanes; i++) {	\
> +			(func)((sc), i);		\
> +		}					\
> +	} while (0)
> +
> +#define for_each_enable_lane_return(func, sc, r)	\
> +	do {						\
> +		int i;					\
> +		(r) = 0;				\
> +		for (i = 0; i < (sc)->lanes; i++) {	\
> +			if (!LANE_ENABLE((sc), i))	\
> +				continue;		\
> +							\
> +			(r) = (func)((sc), i);		\
> +			if ((r))			\
> +				break;			\
> +		}					\
> +	} while (0)
> +
> +#define for_each_lane_return(func, sc, r)		\
> +	do {						\
> +		int i;					\
> +		(r) = 0;				\
> +		for (i = 0; i < (sc)->lanes; i++) {	\
> +			(r) = (func)((sc), i);		\
> +			if ((r))			\
> +				break;			\
> +		}					\
> +	} while (0)

Overuse of macros here and *for_each_lane_return* is not used in this
file at all.
> +
> +#define MAX_COMPARATORS			5
> +#define DFE_OFFSET_SAMPLES		100
> +
> +/* CPU CTRL bits */
> +#define CPU_EN			BIT(31)
> +#define CPU_GO			BIT(30)
> +#define POR_EN			BIT(29)
> +#define CPUREG_EN		BIT(28)
> +#define AUTONEG_CTL		BIT(27)
> +#define DATASPLIT		BIT(26)
> +#define LNKTRN_SIG_DET		BIT(8)
> +
> +#define ANEG_LINK_CTL_10GKR_MASK	MASK(21, 20)
> +#define ANEG_LINK_CTL_1GKX_MASK		MASK(17, 16)
> +#define ANEG_LINK_CTL_1G10G_MASK \
> +	(ANEG_LINK_CTL_10GKR_MASK | ANEG_LINK_CTL_1GKX_MASK)
> +

<snip>

> +static inline void kserdes_xfw_get_lane_params(struct kserdes_config *sc,
> +					       int lane)
> +{
> +	struct kserdes_fw_config *fw = &sc->fw;
> +	u32 tx_ctrl, val_0, val_1;
> +	u32 phy_a = PHY_A(sc->regs);
> +
> +	val_0 = kserdes_readl(sc->regs, LANEX_REG(lane, 0x04));
> +	val_1 = kserdes_readl(sc->regs, LANEX_REG(lane, 0x08));
> +
> +	tx_ctrl = ((((val_0 >> 18) & 0x1)    << 24) |	/* TX_CTRL_O_24 */
> +		   (((val_1 >> 0)  & 0xffff) <<  8) |	/* TX_CTRL_O_23_8 */
> +		   (((val_0 >> 24) & 0xff)   <<  0));	/* TX_CTRL_O_7_0 */
> +
> +	if (phy_a) {
> +		fw->cm = (val_1 >> 12) & 0xf;
> +		fw->c1 = (val_1 >> 0) & 0x1f;
> +		fw->c2 = (val_1 >> 8) & 0xf;
> +	} else {
> +		fw->cm = (tx_ctrl >> 16) & 0xf;
> +		fw->c1 = (tx_ctrl >> 8) & 0x1f;
> +		fw->c2 = (tx_ctrl >> 13) & 0x7;
> +		fw->c2 = fw->c2 | (((tx_ctrl >> 24) & 0x1) << 3);
> +	}
> +
> +	val_0 = _kserdes_read_select_tbus(sc->regs, lane + 1,
> +					  (phy_a ? 0x11 : 0x10));
> +	fw->attn = (val_0 >> 4) & 0xf;
> +	fw->boost = (val_0 >> 8) & 0xf;
> +
> +	val_0 = _kserdes_read_select_tbus(sc->regs, lane + 1, 0x5);
> +	fw->dlpf = (val_0 >> 2) & 0x3ff;
> +
> +	val_0 = _kserdes_read_select_tbus(sc->regs, lane + 1, 0x6);
> +	fw->cdrcal = (val_0 >> 3) & 0xff;
> +}
> +
> +static inline void kserdes_xfw_mem_init(struct kserdes_config *sc)
> +{
> +	struct kserdes_fw_config *fw = &sc->fw;
> +	u32 i, lane_config = 0, lanes = sc->lanes;
> +
> +	for (i = 0; i < lanes; i++)
> +		lane_config = (lane_config << 8) |
> +			(fw->lane_config[i] & 0xff);
> +
> +	lane_config <<= 8;
> +
> +	/* initialize 64B data mem */
> +	kserdes_writel(sc->regs, MEM_ADR_REG, 0x0000ffc0);
> +
> +	for (i = 0; i < 11; i++)

Why 11? This needs a macro.
> +		kserdes_writel(sc->regs, MEM_DATINC_REG, 0x00000000);
> +
> +	/* Flush 64 bytes 10,11,12,13 */
> +	kserdes_writel(sc->regs, MEM_DATINC_REG, 0x00009C9C);
> +
> +	/* fast train */
> +	kserdes_writel(sc->regs, MEM_DATINC_REG, fw->fast_train);
> +
> +	kserdes_writel(sc->regs, MEM_DATINC_REG, 0x00000000);
> +	/* lane seeds */
> +	kserdes_writel(sc->regs, MEM_DATINC_REG, fw->lane_seeds);
> +	/* lane config */
> +	kserdes_writel(sc->regs, MEM_DATINC_REG, lane_config);
> +}
> +
> +static int kserdes_xge_init(struct kserdes_config *sc)
> +{
> +	if (sc->clk_rate != KSERDES_CLOCK_RATE_156P25M)
> +		return -EINVAL;
> +
> +	return kserdes_load_init_fw(sc, ks2_xgbe_serdes_firmwares,
> +				    ARRAY_SIZE(ks2_xgbe_serdes_firmwares));
> +}
> +
> +static int kserdes_pcie_lanes_enable(struct kserdes_config *sc)
> +{
> +	int ret, i;
> +	u32 lanes_enable = 0;
> +
> +	for (i = 0; i < sc->lanes; i++) {
> +		if (!LANE_ENABLE(sc, i))
> +			continue;
> +
> +		lanes_enable |= (1 << i);
> +	}
> +
> +	for (i = 0; i < sc->lanes; i++) {
> +		kserdes_release_reset(sc, i);
> +
> +		if (sc->lane[i].loopback)
> +			_kserdes_set_lane_loopback(sc->regs, i, sc->link_rate);
> +	}
> +
> +	ret = kserdes_get_status(sc);
> +	if (ret)
> +		return ret;
> +	else
> +		return lanes_enable;
> +}
> +
> +static int kserdes_pcie_init(struct kserdes_config *sc)
> +{
> +	if ((sc->clk_rate != KSERDES_CLOCK_RATE_100M) ||
> +	    (sc->link_rate != KSERDES_LINK_RATE_5G))
> +		return -EINVAL;
> +
> +	return kserdes_load_init_fw(sc, ks2_pcie_serdes_firmwares,
> +				    ARRAY_SIZE(ks2_pcie_serdes_firmwares));
> +}
> +
> +static void kserdes_show_fw_config(struct kserdes_config *sc)
> +{
> +	struct kserdes_fw_config *fw = &sc->fw;
> +
> +	dev_info(sc->dev, "fw configs:\n");
> +	dev_info(sc->dev, "  lane_configs: 0x%02x, 0x%02x\n",
> +		 fw->lane_config[0], fw->lane_config[1]);
> +	dev_info(sc->dev,
> +		 "  lnk_loss_wait: %d, lane_seeds: 0x%08x, fast_train: 0x%08x\n",
> +		 fw->link_loss_wait, fw->lane_seeds, fw->fast_train);

This looks more like a debug feature. Lets use debugfs for it.
> +}
> +
> +static void kserdes_show_lane_config(struct device *dev,
> +				     struct kserdes_lane_config *lc)
> +{
> +	dev_info(dev, "%s\n", lc->enable ? "enable" : "disable");
> +	dev_info(dev, "ctrl_rate 0x%x\n", lc->ctrl_rate);
> +	dev_info(dev, "rx_start %u %u\n",
> +		 lc->rx_start.att, lc->rx_start.boost);
> +	dev_info(dev, "rx_force %u %u\n",
> +		 lc->rx_force.att, lc->rx_force.boost);
> +	dev_info(dev, "tx_coeff %u %u %u %u %u\n",
> +		 lc->tx_coeff.c1, lc->tx_coeff.c2, lc->tx_coeff.cm,
> +		 lc->tx_coeff.att, lc->tx_coeff.vreg);
> +	dev_info(dev, "loopback %u\n", lc->loopback);

same here.
> +}
> +
> +static void kserdes_show_config(struct kserdes_config *sc)
> +{
> +	u32 i;
> +
> +	if (!sc->debug)
> +		return;
> +
> +	dev_info(sc->dev, "serdes regs 0x%p\n", sc->regs);
> +	if (sc->peripheral_regmap)
> +		dev_info(sc->dev, "peripheral regmap handle defined\n");
> +	dev_info(sc->dev, "phy_type %u\n", sc->phy_type);
> +	dev_info(sc->dev, "clk_rate %u\n", sc->clk_rate);
> +	dev_info(sc->dev, "link_rate %u\n", sc->link_rate);
> +	dev_info(sc->dev, "lanes %u\n", sc->lanes);
> +	if ((sc->phy_type == KSERDES_PHY_XGE) && sc->pcsr_regmap)
> +		dev_info(sc->dev, "pcsr regmap handle defined\n");
> +
> +	if (sc->firmware) {
> +		kserdes_show_fw_config(sc);
> +		return;
> +	} else if (sc->init_fw) {
> +		dev_info(sc->dev, "init fw: %s\n", sc->init_fw);
> +	}
> +
> +	dev_info(sc->dev, "rx-force-%s\n",
> +		 (sc->rx_force_enable ? "enable" : "disable"));
> +
> +	for (i = 0; i < sc->lanes; i++) {
> +		dev_info(sc->dev, "lane[%u]:\n", i);
> +		kserdes_show_lane_config(sc->dev, &sc->lane[i]);
> +	}
here too.

> +}
> +
> +static int kserdes_lanes_enable(struct kserdes_config *sc)
> +{
> +	int ret = -EINVAL;
> +
> +	if (sc->phy_type == KSERDES_PHY_SGMII)
> +		ret = kserdes_sgmii_lanes_enable(sc);
> +	else if (sc->phy_type == KSERDES_PHY_XGE)
> +		ret = kserdes_xge_lanes_enable(sc);
> +	else if (sc->phy_type == KSERDES_PHY_PCIE)
> +		ret = kserdes_pcie_lanes_enable(sc);

switch case here?
> +
> +	return ret;
> +}
> +
> +static int kserdes_init(struct phy *phy)
> +{
> +	struct kserdes_dev *sd = phy_get_drvdata(phy);
> +	struct kserdes_config *sc = &sd->sc;
> +	int ret;
> +
> +	if (sc->phy_type == KSERDES_PHY_SGMII)
> +		ret = kserdes_sgmii_init(sc);
> +	else if (sc->phy_type == KSERDES_PHY_XGE)
> +		ret = kserdes_xge_init(sc);
> +	else if (sc->phy_type == KSERDES_PHY_PCIE)
> +		ret = kserdes_pcie_init(sc);
> +	else
> +		ret = -EINVAL;

use switch case instead.
> +
> +	if (ret < 0) {
> +		dev_err(sd->dev, "serdes initialization failed %d\n", ret);
> +		goto done;
> +	}
> +
> +	ret = kserdes_lanes_enable(sc);
> +	if (ret < 0) {
> +		dev_err(sd->dev, "serdes lanes enable failed: %d\n", ret);
> +		goto done;
> +	}
> +
> +	dev_info(sd->dev, "serdes config done lanes(mask) 0x%x\n", ret);

dev_dbg?
> +
> +done:
> +	return ret;
> +}
> +
> +struct phy *kserdes_phy_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	struct kserdes_dev *sd = dev_get_drvdata(dev);

Why not use the default xlate provided by phy-core? xlates should only
be defined if the driver has to use arguments provided in the PHY specifier.
> +
> +	return sd->phy;
> +}
> +
> +static int kserdes_get_lane_bindings(struct device *dev,
> +				     struct device_node *np,
> +				     struct kserdes_lane_config *lc)
> +{
> +	struct kserdes_equalizer *eq;
> +	struct kserdes_tx_coeff *tc;
> +
> +	if (of_find_property(np, "disable", NULL))
> +		lc->enable = 0;
> +	else
> +		lc->enable = 1;
> +
> +	dev_dbg(dev, "lane enable: %d\n", lc->enable);
> +
> +	if (of_property_read_u32(np, "control-rate", &lc->ctrl_rate)) {
> +		dev_info(dev, "use default lane control-rate: %u\n",
> +			 lc->ctrl_rate);
> +	}
> +	dev_dbg(dev, "lane control-rate: %d\n", lc->ctrl_rate);
> +
> +	if (of_find_property(np, "loopback", NULL))
> +		lc->loopback = 1;
> +	else
> +		lc->loopback = 0;
> +
> +	dev_dbg(dev, "lane loopback: %d\n", lc->loopback);
> +
> +	eq = &lc->rx_start;
> +	if (of_property_read_u32_array(np, "rx-start", &eq->att, 2)) {
> +		dev_info(dev, "use default lane rx-start 0 0\n");
> +		eq->att = 0;
> +		eq->boost = 0;
> +	}
> +	dev_dbg(dev, "lane rx-start: %d %d\n", eq->att, eq->boost);
> +
> +	eq = &lc->rx_force;
> +	if (of_property_read_u32_array(np, "rx-force", &eq->att, 2)) {
> +		dev_info(dev, "use default lane rx-force 0 0\n");
> +		eq->att = 0;
> +		eq->boost = 0;
> +	}
> +	dev_dbg(dev, "lane rx-force: %d %d\n", eq->att, eq->boost);
> +
> +	tc = &lc->tx_coeff;
> +	if (of_property_read_u32_array(np, "tx-coeff", &tc->c1, 5)) {
> +		dev_info(dev, "use default tx-coeff 0\n");
> +		tc->c1 = 0;
> +	}
> +	dev_dbg(dev, "tx-coeff: %d %d %d %d %d\n",
> +		tc->c1, tc->c2, tc->cm, tc->att, tc->vreg);
> +
> +	return 0;
> +}
> +
> +static void kserdes_set_sgmii_defaults(struct kserdes_config *sc)
> +{
> +	int i;
> +
> +	sc->clk_rate		= KSERDES_CLOCK_RATE_156P25M;
> +	sc->link_rate		= KSERDES_LINK_RATE_1P25G;
> +	sc->lanes		= 4;
> +	sc->rx_force_enable	= 0;
> +
> +	for (i = 0; i < sc->lanes; i++) {
> +		memset(&sc->lane[i], 0, sizeof(sc->lane[i]));
> +		sc->lane[i].ctrl_rate = KSERDES_QUARTER_RATE;
> +	}
> +}
> +
> +static void kserdes_set_xge_defaults(struct kserdes_config *sc)
> +{
> +	int i;
> +
> +	sc->clk_rate		= KSERDES_CLOCK_RATE_156P25M;
> +	sc->link_rate		= KSERDES_LINK_RATE_10P3125G;
> +	sc->lanes		= 2;
> +	sc->rx_force_enable	= 0;
> +
> +	for (i = 0; i < sc->lanes; i++) {
> +		memset(&sc->lane[i], 0, sizeof(sc->lane[i]));
> +		sc->lane[i].ctrl_rate = KSERDES_FULL_RATE;
> +	}
> +}
> +
> +static void kserdes_set_pcie_defaults(struct kserdes_config *sc)
> +{
> +	int i;
> +
> +	sc->clk_rate		= KSERDES_CLOCK_RATE_100M;
> +	sc->link_rate		= KSERDES_LINK_RATE_5G;
> +	sc->lanes		= 2;
> +	sc->rx_force_enable	= 0;
> +
> +	for (i = 0; i < sc->lanes; i++)
> +		memset(&sc->lane[i], 0, sizeof(sc->lane[i]));
> +}
> +
> +static void kserdes_set_defaults(struct kserdes_config *sc,
> +				 enum KSERDES_PHY_TYPE phy_type)
> +{
> +	switch (phy_type) {
> +	case KSERDES_PHY_SGMII:
> +		kserdes_set_sgmii_defaults(sc);
> +		break;
> +	case KSERDES_PHY_XGE:
> +		kserdes_set_xge_defaults(sc);
> +		break;
> +	case KSERDES_PHY_PCIE:
> +		kserdes_set_pcie_defaults(sc);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static int kserdes_get_properties(struct kserdes_dev *sd,
> +				  struct device_node *np)

kserdes_of_parse?
> +{
> +	struct kserdes_config *sc = &sd->sc;
> +	struct device_node *lp;
> +	struct device *dev = sd->dev;
> +	struct resource res;
> +	void __iomem *regs;
> +	const char *phy_type;
> +	char name[16] = {'l', 'a', 'n', 'e'};
> +	int ret, i;
> +
> +	ret = of_address_to_resource(np, SERDES_REG_INDEX, &res);
> +	if (ret) {
> +		dev_err(dev, "Can't xlate serdes reg addr of node(%s)\n",
> +			np->name);
> +		return ret;
> +	}
> +
> +	regs = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(regs)) {
> +		dev_err(dev, "Failed to map serdes register base\n");
> +		return PTR_ERR(regs);
> +	}
> +	sc->regs = regs;
> +
> +	ret = of_property_read_string(np, "phy-type", &phy_type);

use compatible property for this.
> +	if (!ret) {
> +		if (strcmp(phy_type, "sgmii") == 0)
> +			sc->phy_type = KSERDES_PHY_SGMII;
> +		else if (strcmp(phy_type, "xge") == 0)
> +			sc->phy_type = KSERDES_PHY_XGE;
> +		else if (strcmp(phy_type, "pcie") == 0)
> +			sc->phy_type = KSERDES_PHY_PCIE;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	sc->dev = dev;
> +
> +	/* Set the defaults base on phy type */
> +	kserdes_set_defaults(sc, sc->phy_type);
> +
> +	if (of_property_read_bool(np, "syscon-peripheral")) {
> +		sc->peripheral_regmap =
> +			syscon_regmap_lookup_by_phandle(np,
> +							"syscon-peripheral");
> +		if (IS_ERR(sc->peripheral_regmap)) {
> +			dev_err(sc->dev,
> +				"failed to get syscon-peripheral regmap\n");
> +			return PTR_ERR(sc->peripheral_regmap);
> +		}
> +	}
> +
> +	if (of_property_read_bool(np, "syscon-link")) {
> +		sc->pcsr_regmap =
> +			syscon_regmap_lookup_by_phandle(np, "syscon-link");
> +		if (IS_ERR(sc->pcsr_regmap)) {
> +			dev_err(sc->dev,
> +				"failed to get syscon-link regmap\n");
> +			return PTR_ERR(sc->pcsr_regmap);
> +		}
> +	}
> +
> +	if (of_property_read_u32(np, "refclk-khz", &sc->clk_rate))
> +		dev_info(dev, "use default refclk-khz: %u\n", sc->clk_rate);
> +
> +	if (of_property_read_u32(np, "link-rate-kbps", &sc->link_rate)) {
> +		dev_info(dev, "use default link-rate-kbps: %u\n",
> +			 sc->link_rate);
> +	}
> +
> +	if (of_property_read_u32(np, "max-lanes", &sc->lanes))
> +		dev_info(dev, "use default max-lanes %d\n", sc->lanes);
> +
> +	if (sc->lanes > KSERDES_MAX_LANES) {
> +		sc->lanes = KSERDES_MAX_LANES;
> +		dev_info(dev, "use max allowed lanes %d\n", sc->lanes);
> +	}
> +
> +	sc->debug = of_property_read_bool(np, "debug");
> +
> +	if (of_find_property(np, "rx-force-enable", NULL))
> +		sc->rx_force_enable = 1;
> +	else
> +		sc->rx_force_enable = 0;
> +
> +	for (i = 0; i < sc->lanes; i++) {
> +		sprintf(&name[4], "%d", i);
> +		lp = of_find_node_by_name(np, name);
> +		if (lp) {
> +			if (kserdes_get_lane_bindings(dev, lp, &sc->lane[i]))
> +				return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct phy_ops kserdes_ops = {
> +	.init		= kserdes_init,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int kserdes_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct kserdes_dev *sd;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	sd = devm_kzalloc(dev, sizeof(*sd), GFP_KERNEL);
> +	if (!sd)
> +		return -ENOMEM;
> +
> +	sd->dev = dev;
> +
> +	ret = kserdes_get_properties(sd, np);
> +	if (ret)
> +		return ret;
> +
> +	kserdes_show_config(&sd->sc);
> +
> +	dev_set_drvdata(dev, sd);
> +	sd->phy = devm_phy_create(dev, NULL, &kserdes_ops);
> +	if (IS_ERR(sd->phy))
> +		return PTR_ERR(sd->phy);
> +
> +	phy_set_drvdata(sd->phy, sd);
> +	phy_provider = devm_of_phy_provider_register(sd->dev,
> +						     kserdes_phy_xlate);
> +
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR_OR_ZERO(phy_provider);
> +
> +	dev_info(&pdev->dev, "probed");

This is not needed. Maybe dev_vdbg?
> +	return 0;
> +}
> +
> +static const struct of_device_id kserdes_of_match[] = {
> +	{ .compatible = "ti,keystone-serdes-gbe" },
> +	{ .compatible = "ti,keystone-serdes-pcie" },
> +	{ .compatible = "ti,keystone-serdes-xgbe" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, kserdes_of_match);
> +
> +static struct platform_driver kserdes_driver = {
> +	.probe	= kserdes_probe,
> +	.driver = {
> +		.of_match_table	= kserdes_of_match,
> +		.name  = "ti,keystone-serdes",
> +		.owner = THIS_MODULE,

.owner is not required.
> +	}
> +};
> +
> +static int __init keystone_serdes_phy_init(void)
> +{
> +	return platform_driver_register(&kserdes_driver);
> +}
> +subsys_initcall(keystone_serdes_phy_init);

this should be module_init.

-Kishon
