Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:50161 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeCUArc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2018 20:47:32 -0400
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/6] PCI: rockchip: Create individual folder for
 rockchip drivers
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1520304173-231081-1-git-send-email-shawn.lin@rock-chips.com>
 <1520304202-232891-1-git-send-email-shawn.lin@rock-chips.com>
 <20180320140431.GA15953@e107981-ln.cambridge.arm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <111f1278-d68a-a2e4-def7-e39a32b89ded@rock-chips.com>
Date: Wed, 21 Mar 2018 08:47:29 +0800
MIME-Version: 1.0
In-Reply-To: <20180320140431.GA15953@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 2018/3/20 22:04, Lorenzo Pieralisi wrote:
> On Tue, Mar 06, 2018 at 10:43:22AM +0800, Shawn Lin wrote:
>> In preparation for introducing End-Point driver for Rockchip
>> PCIe controller, we create a new folder to follow the convention
>> of dwc and cadence. Then we rename the host driver from pcie-rockchip.c
>> to pcie-rockchip-host.c, and only leave some common functions in
>> pcie-rockchip.c in order to be reused for both of host and EP drivers.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   MAINTAINERS                                        |   4 +-
>>   drivers/pci/Kconfig                                |   1 +
>>   drivers/pci/Makefile                               |   2 +
>>   drivers/pci/host/Kconfig                           |  11 -
>>   drivers/pci/host/Makefile                          |   1 -
>>   drivers/pci/rockchip/Kconfig                       |  20 ++
>>   drivers/pci/rockchip/Makefile                      |   3 +
>>   .../pcie-rockchip-host.c}                          | 344 +--------------------
>>   drivers/pci/rockchip/pcie-rockchip.c               | 141 +++++++++
>>   drivers/pci/rockchip/pcie-rockchip.h               | 246 +++++++++++++++
>>   10 files changed, 416 insertions(+), 357 deletions(-)
>>   create mode 100644 drivers/pci/rockchip/Kconfig
>>   create mode 100644 drivers/pci/rockchip/Makefile
>>   rename drivers/pci/{host/pcie-rockchip.c => rockchip/pcie-rockchip-host.c} (75%)
>>   create mode 100644 drivers/pci/rockchip/pcie-rockchip.c
>>   create mode 100644 drivers/pci/rockchip/pcie-rockchip.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6d78237..6b84d80 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10883,8 +10883,8 @@ M:	Shawn Lin <shawn.lin@rock-chips.com>
>>   L:	linux-pci@vger.kernel.org
>>   L:	linux-rockchip@lists.infradead.org
>>   S:	Maintained
>> -F:	Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> -F:	drivers/pci/host/pcie-rockchip.c
>> +F:	Documentation/devicetree/bindings/pci/rockchip-pcie*
>> +F:	drivers/pci/rockchip/*
>>   
>>   PCI DRIVER FOR V3 SEMICONDUCTOR V360EPC
>>   M:	Linus Walleij <linus.walleij@linaro.org>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 34b56a8..b85ad40 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -141,4 +141,5 @@ source "drivers/pci/cadence/Kconfig"
>>   source "drivers/pci/dwc/Kconfig"
>>   source "drivers/pci/host/Kconfig"
>>   source "drivers/pci/endpoint/Kconfig"
>> +source "drivers/pci/rockchip/Kconfig"
>>   source "drivers/pci/switch/Kconfig"
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 9419709..8434afb 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -55,6 +55,8 @@ obj-y += switch/
>>   
>>   obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>>   
>> +obj-$(CONFIG_PCIE_ROCKCHIP)	+= rockchip/
>> +
>>   # Endpoint library must be initialized before its users
>>   obj-$(CONFIG_PCIE_CADENCE)	+= cadence/
>>   # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index dc8a2a1..4145f4f 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -177,17 +177,6 @@ config PCI_HOST_THUNDER_ECAM
>>   	help
>>   	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
>>   
>> -config PCIE_ROCKCHIP
>> -	tristate "Rockchip PCIe controller"
>> -	depends on ARCH_ROCKCHIP || COMPILE_TEST
>> -	depends on OF
>> -	depends on PCI_MSI_IRQ_DOMAIN
>> -	select MFD_SYSCON
>> -	help
>> -	  Say Y here if you want internal PCI support on Rockchip SoC.
>> -	  There is 1 internal PCIe port available to support GEN2 with
>> -	  4 slots.
>> -
>>   config PCIE_MEDIATEK
>>   	bool "MediaTek PCIe controller"
>>   	depends on (ARM || ARM64) && (ARCH_MEDIATEK || COMPILE_TEST)
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index 3b10591..ceab86a 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -19,7 +19,6 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>>   obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>>   obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>>   obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>> -obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>>   obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>>   obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>>   obj-$(CONFIG_VMD) += vmd.o
>> diff --git a/drivers/pci/rockchip/Kconfig b/drivers/pci/rockchip/Kconfig
>> new file mode 100644
>> index 0000000..d655b77
>> --- /dev/null
>> +++ b/drivers/pci/rockchip/Kconfig
>> @@ -0,0 +1,20 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +menu "Rockchip PCIe controllers support"
>> +
>> +config PCIE_ROCKCHIP
>> +	bool
> 
> You have to replace the existing defconfigs though, (eg arm64
> defconfig where this is set as "m" since it would warn otherwise).
> 

Nice catch, will send new patch for fixing defconfigs later once
applied.

> Two nits below.

Will fix in the next version.


Thanks.

> 
> [...]
> 
>>   static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
>>   {
>>   	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> diff --git a/drivers/pci/rockchip/pcie-rockchip.c b/drivers/pci/rockchip/pcie-rockchip.c
>> new file mode 100644
>> index 0000000..c7614f9
>> --- /dev/null
>> +++ b/drivers/pci/rockchip/pcie-rockchip.c
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Rockchip AXI PCIe host controller driver
>> + *
>> + * Copyright (c) 2016 Rockchip, Inc.
>> + *
>> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
>> + *         Wenrui Li <wenrui.li@rock-chips.com>
>> + *
>> + * Bits taken from Synopsys DesignWare Host controller driver and
>> + * ARM PCI Host generic driver.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/phy/phy.h>
>> +
>> +#include "pcie-rockchip.h"
>> +
>> +int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
>> +{
>> +	struct device *dev = rockchip->dev;
>> +	struct phy *phy;
>> +	char *name;
>> +	u32 i;
>> +
>> +	phy = devm_phy_get(dev, "pcie-phy");
>> +	if (!IS_ERR(phy)) {
>> +		rockchip->legacy_phy = true;
>> +		rockchip->phys[0] = phy;
>> +		dev_warn(dev, "legacy phy model is deprecated!\n");
>> +		return 0;
>> +	}
>> +
>> +	if (PTR_ERR(phy) == -EPROBE_DEFER)
>> +		return PTR_ERR(phy);
>> +
>> +	dev_dbg(dev, "missing legacy phy; search for per-lane PHY\n");
>> +
>> +	for (i = 0; i < MAX_LANE_NUM; i++) {
>> +		name = kasprintf(GFP_KERNEL, "pcie-phy-%u", i);
>> +		if (!name)
>> +			return -ENOMEM;
>> +
>> +		phy = devm_of_phy_get(dev, dev->of_node, name);
>> +		kfree(name);
>> +
>> +		if (IS_ERR(phy)) {
>> +			if (PTR_ERR(phy) != -EPROBE_DEFER)
>> +				dev_err(dev, "missing phy for lane %d: %ld\n",
>> +					i, PTR_ERR(phy));
>> +			return PTR_ERR(phy);
>> +		}
>> +
>> +		rockchip->phys[i] = phy;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +
> 
> Nit: remove one empty line.
> 
>> +void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < MAX_LANE_NUM; i++) {
>> +		/* inactive lanes are already powered off */
>> +		if (rockchip->lanes_map & BIT(i))
>> +			phy_power_off(rockchip->phys[i]);
>> +		phy_exit(rockchip->phys[i]);
>> +	}
>> +}
>> +
>> +int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
>> +{
>> +	struct device *dev = rockchip->dev;
>> +	int err;
>> +
>> +	err = clk_prepare_enable(rockchip->aclk_pcie);
>> +	if (err) {
>> +		dev_err(dev, "unable to enable aclk_pcie clock\n");
>> +		return err;
>> +	}
>> +
>> +	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
>> +	if (err) {
>> +		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
>> +		goto err_aclk_perf_pcie;
>> +	}
>> +
>> +	err = clk_prepare_enable(rockchip->hclk_pcie);
>> +	if (err) {
>> +		dev_err(dev, "unable to enable hclk_pcie clock\n");
>> +		goto err_hclk_pcie;
>> +	}
>> +
>> +	err = clk_prepare_enable(rockchip->clk_pcie_pm);
>> +	if (err) {
>> +		dev_err(dev, "unable to enable clk_pcie_pm clock\n");
>> +		goto err_clk_pcie_pm;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_clk_pcie_pm:
>> +	clk_disable_unprepare(rockchip->hclk_pcie);
>> +err_hclk_pcie:
>> +	clk_disable_unprepare(rockchip->aclk_perf_pcie);
>> +err_aclk_perf_pcie:
>> +	clk_disable_unprepare(rockchip->aclk_pcie);
>> +	return err;
>> +}
>> +
>> +void rockchip_pcie_disable_clocks(void *data)
>> +{
>> +	struct rockchip_pcie *rockchip = data;
>> +
>> +	clk_disable_unprepare(rockchip->clk_pcie_pm);
>> +	clk_disable_unprepare(rockchip->hclk_pcie);
>> +	clk_disable_unprepare(rockchip->aclk_perf_pcie);
>> +	clk_disable_unprepare(rockchip->aclk_pcie);
>> +}
>> +
>> +void rockchip_pcie_cfg_configuration_accesses(
>> +		struct rockchip_pcie *rockchip, u32 type)
>> +{
>> +	u32 ob_desc_0;
>> +
>> +	/* Configuration Accesses for region 0 */
>> +	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
>> +
>> +	rockchip_pcie_write(rockchip,
>> +			    (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
>> +			    PCIE_CORE_OB_REGION_ADDR0);
>> +	rockchip_pcie_write(rockchip, RC_REGION_0_ADDR_TRANS_H,
>> +			    PCIE_CORE_OB_REGION_ADDR1);
>> +	ob_desc_0 = rockchip_pcie_read(rockchip, PCIE_CORE_OB_REGION_DESC0);
>> +	ob_desc_0 &= ~(RC_REGION_0_TYPE_MASK);
>> +	ob_desc_0 |= (type | (0x1 << 23));
>> +	rockchip_pcie_write(rockchip, ob_desc_0, PCIE_CORE_OB_REGION_DESC0);
>> +	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
>> +}
>> diff --git a/drivers/pci/rockchip/pcie-rockchip.h b/drivers/pci/rockchip/pcie-rockchip.h
>> new file mode 100644
>> index 0000000..9e0cf2e
>> --- /dev/null
>> +++ b/drivers/pci/rockchip/pcie-rockchip.h
>> @@ -0,0 +1,246 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Rockchip AXI PCIe controller driver
>> + *
>> + * Copyright (c) 2018 Rockchip, Inc.
>> + *
>> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
>> + *
>> + */
>> +
>> +#ifndef _PCIE_ROCKCHIP_H
>> +#define _PCIE_ROCKCHIP_H
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +
>> +/*
>> + * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
>> + * bits.  This allows atomic updates of the register without locking.
>> + */
>> +#define HIWORD_UPDATE(mask, val)	(((mask) << 16) | (val))
>> +#define HIWORD_UPDATE_BIT(val)		HIWORD_UPDATE(val, val)
>> +
>> +#define ENCODE_LANES(x)			((((x) >> 1) & 3) << 4)
>> +#define MAX_LANE_NUM			4
>> +
>> +#define PCIE_CLIENT_BASE		0x0
>> +#define PCIE_CLIENT_CONFIG		(PCIE_CLIENT_BASE + 0x00)
>> +#define   PCIE_CLIENT_CONF_ENABLE	  HIWORD_UPDATE_BIT(0x0001)
>> +#define   PCIE_CLIENT_LINK_TRAIN_ENABLE	  HIWORD_UPDATE_BIT(0x0002)
>> +#define   PCIE_CLIENT_ARI_ENABLE	  HIWORD_UPDATE_BIT(0x0008)
>> +#define   PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
>> +#define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
>> +#define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
>> +#define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
>> +#define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
>> +#define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
>> +#define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
>> +#define   PCIE_CLIENT_DEBUG_LTSSM_L2		0x19
>> +#define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
>> +#define   PCIE_CLIENT_LINK_STATUS_UP		0x00300000
>> +#define   PCIE_CLIENT_LINK_STATUS_MASK		0x00300000
>> +#define PCIE_CLIENT_INT_MASK		(PCIE_CLIENT_BASE + 0x4c)
>> +#define PCIE_CLIENT_INT_STATUS		(PCIE_CLIENT_BASE + 0x50)
>> +#define   PCIE_CLIENT_INTR_MASK			GENMASK(8, 5)
>> +#define   PCIE_CLIENT_INTR_SHIFT		5
>> +#define   PCIE_CLIENT_INT_LEGACY_DONE		BIT(15)
>> +#define   PCIE_CLIENT_INT_MSG			BIT(14)
>> +#define   PCIE_CLIENT_INT_HOT_RST		BIT(13)
>> +#define   PCIE_CLIENT_INT_DPA			BIT(12)
>> +#define   PCIE_CLIENT_INT_FATAL_ERR		BIT(11)
>> +#define   PCIE_CLIENT_INT_NFATAL_ERR		BIT(10)
>> +#define   PCIE_CLIENT_INT_CORR_ERR		BIT(9)
>> +#define   PCIE_CLIENT_INT_INTD			BIT(8)
>> +#define   PCIE_CLIENT_INT_INTC			BIT(7)
>> +#define   PCIE_CLIENT_INT_INTB			BIT(6)
>> +#define   PCIE_CLIENT_INT_INTA			BIT(5)
>> +#define   PCIE_CLIENT_INT_LOCAL			BIT(4)
>> +#define   PCIE_CLIENT_INT_UDMA			BIT(3)
>> +#define   PCIE_CLIENT_INT_PHY			BIT(2)
>> +#define   PCIE_CLIENT_INT_HOT_PLUG		BIT(1)
>> +#define   PCIE_CLIENT_INT_PWR_STCG		BIT(0)
>> +
>> +#define PCIE_CLIENT_INT_LEGACY \
>> +	(PCIE_CLIENT_INT_INTA | PCIE_CLIENT_INT_INTB | \
>> +	PCIE_CLIENT_INT_INTC | PCIE_CLIENT_INT_INTD)
>> +
>> +#define PCIE_CLIENT_INT_CLI \
>> +	(PCIE_CLIENT_INT_CORR_ERR | PCIE_CLIENT_INT_NFATAL_ERR | \
>> +	PCIE_CLIENT_INT_FATAL_ERR | PCIE_CLIENT_INT_DPA | \
>> +	PCIE_CLIENT_INT_HOT_RST | PCIE_CLIENT_INT_MSG | \
>> +	PCIE_CLIENT_INT_LEGACY_DONE | PCIE_CLIENT_INT_LEGACY | \
>> +	PCIE_CLIENT_INT_PHY)
>> +
>> +#define PCIE_CORE_CTRL_MGMT_BASE	0x900000
>> +#define PCIE_CORE_CTRL			(PCIE_CORE_CTRL_MGMT_BASE + 0x000)
>> +#define   PCIE_CORE_PL_CONF_SPEED_5G		0x00000008
>> +#define   PCIE_CORE_PL_CONF_SPEED_MASK		0x00000018
>> +#define   PCIE_CORE_PL_CONF_LANE_MASK		0x00000006
>> +#define   PCIE_CORE_PL_CONF_LANE_SHIFT		1
>> +#define PCIE_CORE_CTRL_PLC1		(PCIE_CORE_CTRL_MGMT_BASE + 0x004)
>> +#define   PCIE_CORE_CTRL_PLC1_FTS_MASK		GENMASK(23, 8)
>> +#define   PCIE_CORE_CTRL_PLC1_FTS_SHIFT		8
>> +#define   PCIE_CORE_CTRL_PLC1_FTS_CNT		0xffff
>> +#define PCIE_CORE_TXCREDIT_CFG1		(PCIE_CORE_CTRL_MGMT_BASE + 0x020)
>> +#define   PCIE_CORE_TXCREDIT_CFG1_MUI_MASK	0xFFFF0000
>> +#define   PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT	16
>> +#define   PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(x) \
>> +		(((x) >> 3) << PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT)
>> +#define PCIE_CORE_LANE_MAP             (PCIE_CORE_CTRL_MGMT_BASE + 0x200)
>> +#define   PCIE_CORE_LANE_MAP_MASK              0x0000000f
>> +#define   PCIE_CORE_LANE_MAP_REVERSE           BIT(16)
>> +#define PCIE_CORE_INT_STATUS		(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
>> +#define   PCIE_CORE_INT_PRFPE			BIT(0)
>> +#define   PCIE_CORE_INT_CRFPE			BIT(1)
>> +#define   PCIE_CORE_INT_RRPE			BIT(2)
>> +#define   PCIE_CORE_INT_PRFO			BIT(3)
>> +#define   PCIE_CORE_INT_CRFO			BIT(4)
>> +#define   PCIE_CORE_INT_RT			BIT(5)
>> +#define   PCIE_CORE_INT_RTR			BIT(6)
>> +#define   PCIE_CORE_INT_PE			BIT(7)
>> +#define   PCIE_CORE_INT_MTR			BIT(8)
>> +#define   PCIE_CORE_INT_UCR			BIT(9)
>> +#define   PCIE_CORE_INT_FCE			BIT(10)
>> +#define   PCIE_CORE_INT_CT			BIT(11)
>> +#define   PCIE_CORE_INT_UTC			BIT(18)
>> +#define   PCIE_CORE_INT_MMVC			BIT(19)
>> +#define PCIE_CORE_CONFIG_VENDOR		(PCIE_CORE_CTRL_MGMT_BASE + 0x44)
>> +#define PCIE_CORE_INT_MASK		(PCIE_CORE_CTRL_MGMT_BASE + 0x210)
>> +#define PCIE_RC_BAR_CONF		(PCIE_CORE_CTRL_MGMT_BASE + 0x300)
>> +
>> +#define PCIE_CORE_INT \
>> +		(PCIE_CORE_INT_PRFPE | PCIE_CORE_INT_CRFPE | \
>> +		 PCIE_CORE_INT_RRPE | PCIE_CORE_INT_CRFO | \
>> +		 PCIE_CORE_INT_RT | PCIE_CORE_INT_RTR | \
>> +		 PCIE_CORE_INT_PE | PCIE_CORE_INT_MTR | \
>> +		 PCIE_CORE_INT_UCR | PCIE_CORE_INT_FCE | \
>> +		 PCIE_CORE_INT_CT | PCIE_CORE_INT_UTC | \
>> +		 PCIE_CORE_INT_MMVC)
>> +
>> +#define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
>> +#define PCIE_RC_CONFIG_BASE		0xa00000
>> +#define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
>> +#define   PCIE_RC_CONFIG_SCC_SHIFT		16
>> +#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
>> +#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
>> +#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
>> +#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
>> +#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
>> +#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
>> +#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
>> +#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
>> +#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
>> +#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
>> +#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>> +#define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>> +#define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
>> +
>> +#define PCIE_CORE_AXI_CONF_BASE		0xc00000
>> +#define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
>> +#define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
>> +#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	0xffffff00
>> +#define PCIE_CORE_OB_REGION_ADDR1	(PCIE_CORE_AXI_CONF_BASE + 0x4)
>> +#define PCIE_CORE_OB_REGION_DESC0	(PCIE_CORE_AXI_CONF_BASE + 0x8)
>> +#define PCIE_CORE_OB_REGION_DESC1	(PCIE_CORE_AXI_CONF_BASE + 0xc)
>> +
>> +#define PCIE_CORE_AXI_INBOUND_BASE	0xc00800
>> +#define PCIE_RP_IB_ADDR0		(PCIE_CORE_AXI_INBOUND_BASE + 0x0)
>> +#define   PCIE_CORE_IB_REGION_ADDR0_NUM_BITS	0x3f
>> +#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	0xffffff00
>> +#define PCIE_RP_IB_ADDR1		(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
>> +
>> +/* Size of one AXI Region (not Region 0) */
>> +#define AXI_REGION_SIZE				BIT(20)
>> +/* Size of Region 0, equal to sum of sizes of other regions */
>> +#define AXI_REGION_0_SIZE			(32 * (0x1 << 20))
>> +#define OB_REG_SIZE_SHIFT			5
>> +#define IB_ROOT_PORT_REG_SIZE_SHIFT		3
>> +#define AXI_WRAPPER_IO_WRITE			0x6
>> +#define AXI_WRAPPER_MEM_WRITE			0x2
>> +#define AXI_WRAPPER_TYPE0_CFG			0xa
>> +#define AXI_WRAPPER_TYPE1_CFG			0xb
>> +#define AXI_WRAPPER_NOR_MSG			0xc
>> +
>> +#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
>> +#define MIN_AXI_ADDR_BITS_PASSED		8
>> +#define PCIE_RC_SEND_PME_OFF			0x11960
>> +#define ROCKCHIP_VENDOR_ID			0x1d87
>> +#define PCIE_ECAM_BUS(x)			(((x) & 0xff) << 20)
>> +#define PCIE_ECAM_DEV(x)			(((x) & 0x1f) << 15)
>> +#define PCIE_ECAM_FUNC(x)			(((x) & 0x7) << 12)
>> +#define PCIE_ECAM_REG(x)			(((x) & 0xfff) << 0)
>> +#define PCIE_ECAM_ADDR(bus, dev, func, reg) \
>> +	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
>> +	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
>> +#define PCIE_LINK_IS_L2(x) \
>> +	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
>> +#define PCIE_LINK_UP(x) \
>> +	(((x) & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_UP)
>> +#define PCIE_LINK_IS_GEN2(x) \
>> +	(((x) & PCIE_CORE_PL_CONF_SPEED_MASK) == PCIE_CORE_PL_CONF_SPEED_5G)
>> +
>> +#define RC_REGION_0_ADDR_TRANS_H		0x00000000
>> +#define RC_REGION_0_ADDR_TRANS_L		0x00000000
>> +#define RC_REGION_0_PASS_BITS			(25 - 1)
>> +#define RC_REGION_0_TYPE_MASK			GENMASK(3, 0)
>> +#define MAX_AXI_WRAPPER_REGION_NUM		33
>> +
>> +struct rockchip_pcie {
>> +	void	__iomem *reg_base;		/* DT axi-base */
>> +	void	__iomem *apb_base;		/* DT apb-base */
>> +	bool    legacy_phy;
>> +	struct  phy *phys[MAX_LANE_NUM];
>> +	struct	reset_control *core_rst;
>> +	struct	reset_control *mgmt_rst;
>> +	struct	reset_control *mgmt_sticky_rst;
>> +	struct	reset_control *pipe_rst;
>> +	struct	reset_control *pm_rst;
>> +	struct	reset_control *aclk_rst;
>> +	struct	reset_control *pclk_rst;
>> +	struct	clk *aclk_pcie;
>> +	struct	clk *aclk_perf_pcie;
>> +	struct	clk *hclk_pcie;
>> +	struct	clk *clk_pcie_pm;
>> +	struct	regulator *vpcie12v; /* 12V power supply */
>> +	struct	regulator *vpcie3v3; /* 3.3V power supply */
>> +	struct	regulator *vpcie1v8; /* 1.8V power supply */
>> +	struct	regulator *vpcie0v9; /* 0.9V power supply */
>> +	struct	gpio_desc *ep_gpio;
>> +	u32	lanes;
>> +	u8      lanes_map;
>> +	u8	root_bus_nr;
>> +	int	link_gen;
>> +	struct	device *dev;
>> +	struct	irq_domain *irq_domain;
>> +	int     offset;
>> +	struct pci_bus *root_bus;
>> +	struct resource *io;
>> +	phys_addr_t io_bus_addr;
>> +	u32     io_size;
>> +	void    __iomem *msg_region;
>> +	u32     mem_size;
>> +	phys_addr_t msg_bus_addr;
>> +	phys_addr_t mem_bus_addr;
>> +};
>> +
>> +
> 
> Remove one empty line.
> 
> Thanks,
> Lorenzo
> 
>> +static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
>> +{
>> +	return readl(rockchip->apb_base + reg);
>> +}
>> +
>> +static void rockchip_pcie_write(struct rockchip_pcie *rockchip, u32 val,
>> +				u32 reg)
>> +{
>> +	writel(val, rockchip->apb_base + reg);
>> +}
>> +
>> +int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
>> +void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
>> +int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
>> +void rockchip_pcie_disable_clocks(void *data);
>> +void rockchip_pcie_cfg_configuration_accesses(
>> +		struct rockchip_pcie *rockchip, u32 type);
>> +
>> +#endif /* _PCIE_ROCKCHIP_H */
>> -- 
>> 1.9.1
>>
>>
> 
> 
> 
