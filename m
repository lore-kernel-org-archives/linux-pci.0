Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB5C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920542070D
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lm/Uch5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfCZPPx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:15:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18442 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbfCZPPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2019 11:15:53 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9a42220000>; Tue, 26 Mar 2019 08:15:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 08:15:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 08:15:48 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 15:15:47 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 26 Mar 2019 15:15:47 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9a421a0000>; Tue, 26 Mar 2019 08:15:47 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <vidyas@nvidia.com>, <tiwai@suse.de>,
        <spujar@nvidia.com>, <skomatineni@nvidia.com>,
        <liviu.dudau@arm.com>, <krzk@kernel.org>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <olof@lixom.net>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <ezequiel@collabora.com>,
        <stefan.wahren@i2se.com>, <marc.w.gonzalez@free.fr>,
        <l.stach@pengutronix.de>, <tpiepho@impinj.com>,
        <hayashi.kunihiko@socionext.com>, <yue.wang@amlogic.com>,
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
Subject: [PATCH 09/10] PCI: tegra: Add Tegra194 PCIe support
Date:   Tue, 26 Mar 2019 20:43:26 +0530
Message-ID: <1553613207-3988-10-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553613346; bh=1kePYnAoiNpTM6ZBOLW95MG0KslrUJFn1NIcaig4rSc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=lm/Uch5SM0Dhe0qD4I9IqO2ewmEr+sdb46jnh6IDWlY9u47bnrRba+Aya6v3j+LDd
         sHKJdbdJw9z18mOLc6uEQjPZITy1HdOor2FY+WhDgY8K5MDmJ9N6e666Pp3glhSmax
         vppkb9I3OfkjHLSpQloRTZp5ydrPU4Ngw+D23KgUqdP8BxxAbkPdPrsgQTSPDsSV+x
         5H9xRAFp6QARBYsUUXe6wwuHZqCQy+3MTdVWf7RgXc8mNb6NSAhighCU/MWt3tThtT
         0422Mf6QaPWEKbN39N7uUxm5E0UnXpdmzTQRtrXT2u6CWnZ5fiivR/xgnrCYNmlB0s
         aRtdZ2RqFxACw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Synopsys DesignWare core IP based PCIe host controller
present in Tegra194 SoC.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/Kconfig         |   10 +
 drivers/pci/controller/dwc/Makefile        |    1 +
 drivers/pci/controller/dwc/pcie-tegra194.c | 1862 ++++++++++++++++++++++++++++
 3 files changed, 1873 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 6ea74b1c0d94..d80f2d77892a 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -213,4 +213,14 @@ config PCIE_UNIPHIER
 	  Say Y here if you want PCIe controller support on UniPhier SoCs.
 	  This driver supports LD20 and PXs3 SoCs.
 
+config PCIE_TEGRA194
+	bool "NVIDIA Tegra (T194) PCIe controller"
+	depends on TEGRA_BPMP && (ARCH_TEGRA || COMPILE_TEST)
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	select PHY_TEGRA194_PCIE_P2U
+	help
+	  Say Y here if you want support for DesignWare core based PCIe host
+	  controller found in NVIDIA Tegra T194 SoC.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index b5f3b83cc2b3..4362f0ea89ac 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
 obj-$(CONFIG_PCI_MESON) += pci-meson.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
+obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
new file mode 100644
index 000000000000..7f6be38c8456
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -0,0 +1,1862 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe host controller driver for Tegra T194 SoC
+ *
+ * Copyright (C) 2018 NVIDIA Corporation.
+ *
+ * Author: Vidya Sagar <vidyas@nvidia.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/pci-aspm.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/random.h>
+#include <linux/reset.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+#include "pcie-designware.h"
+#include <soc/tegra/bpmp.h>
+#include <soc/tegra/bpmp-abi.h>
+#include "../../pcie/portdrv.h"
+
+#define dw_pcie_to_tegra_pcie(x) container_of(x, struct tegra_pcie_dw, pci)
+
+#define CTRL_5	5
+
+#define APPL_PINMUX				0x0
+#define APPL_PINMUX_PEX_RST			BIT(0)
+#define APPL_PINMUX_CLKREQ_OVERRIDE_EN		BIT(2)
+#define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
+#define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
+#define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
+#define APPL_PINMUX_CLKREQ_OUT_OVRD_EN		BIT(9)
+#define APPL_PINMUX_CLKREQ_OUT_OVRD		BIT(10)
+
+#define APPL_CTRL				0x4
+#define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
+#define APPL_CTRL_LTSSM_EN			BIT(7)
+#define APPL_CTRL_HW_HOT_RST_EN			BIT(20)
+#define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(1, 0)
+#define APPL_CTRL_HW_HOT_RST_MODE_SHIFT		22
+#define APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST	0x1
+
+#define APPL_INTR_EN_L0_0			0x8
+#define APPL_INTR_EN_L0_0_LINK_STATE_INT_EN	BIT(0)
+#define APPL_INTR_EN_L0_0_MSI_RCV_INT_EN	BIT(4)
+#define APPL_INTR_EN_L0_0_INT_INT_EN		BIT(8)
+#define APPL_INTR_EN_L0_0_CDM_REG_CHK_INT_EN	BIT(19)
+#define APPL_INTR_EN_L0_0_SYS_INTR_EN		BIT(30)
+#define APPL_INTR_EN_L0_0_SYS_MSI_INTR_EN	BIT(31)
+
+#define APPL_INTR_STATUS_L0			0xC
+#define APPL_INTR_STATUS_L0_LINK_STATE_INT	BIT(0)
+#define APPL_INTR_STATUS_L0_INT_INT		BIT(8)
+#define APPL_INTR_STATUS_L0_CDM_REG_CHK_INT	BIT(18)
+
+#define APPL_INTR_EN_L1_0_0				0x1C
+#define APPL_INTR_EN_L1_0_0_LINK_REQ_RST_NOT_INT_EN	BIT(1)
+
+#define APPL_INTR_STATUS_L1_0_0				0x20
+#define APPL_INTR_STATUS_L1_0_0_LINK_REQ_RST_NOT_CHGED	BIT(1)
+
+#define APPL_INTR_STATUS_L1_1			0x2C
+#define APPL_INTR_STATUS_L1_2			0x30
+#define APPL_INTR_STATUS_L1_3			0x34
+#define APPL_INTR_STATUS_L1_6			0x3C
+#define APPL_INTR_STATUS_L1_7			0x40
+
+#define APPL_INTR_EN_L1_8_0			0x44
+#define APPL_INTR_EN_L1_8_BW_MGT_INT_EN		BIT(2)
+#define APPL_INTR_EN_L1_8_AUTO_BW_INT_EN	BIT(3)
+#define APPL_INTR_EN_L1_8_INTX_EN		BIT(11)
+#define APPL_INTR_EN_L1_8_AER_INT_EN		BIT(15)
+
+#define APPL_INTR_STATUS_L1_8_0			0x4C
+#define APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK	GENMASK(11, 6)
+#define APPL_INTR_STATUS_L1_8_0_BW_MGT_INT_STS	BIT(2)
+#define APPL_INTR_STATUS_L1_8_0_AUTO_BW_INT_STS	BIT(3)
+
+#define APPL_INTR_STATUS_L1_9			0x54
+#define APPL_INTR_STATUS_L1_10			0x58
+#define APPL_INTR_STATUS_L1_11			0x64
+#define APPL_INTR_STATUS_L1_13			0x74
+#define APPL_INTR_STATUS_L1_14			0x78
+#define APPL_INTR_STATUS_L1_15			0x7C
+#define APPL_INTR_STATUS_L1_17			0x88
+
+#define APPL_INTR_EN_L1_18				0x90
+#define APPL_INTR_EN_L1_18_CDM_REG_CHK_CMPLT		BIT(2)
+#define APPL_INTR_EN_L1_18_CDM_REG_CHK_CMP_ERR		BIT(1)
+#define APPL_INTR_EN_L1_18_CDM_REG_CHK_LOGIC_ERR	BIT(0)
+
+#define APPL_INTR_STATUS_L1_18				0x94
+#define APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMPLT	BIT(2)
+#define APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMP_ERR	BIT(1)
+#define APPL_INTR_STATUS_L1_18_CDM_REG_CHK_LOGIC_ERR	BIT(0)
+
+#define APPL_MSI_CTRL_2				0xB0
+
+#define APPL_LTR_MSG_1				0xC4
+#define LTR_MSG_REQ				BIT(15)
+#define LTR_MST_NO_SNOOP_SHIFT			16
+
+#define APPL_LTR_MSG_2				0xC8
+#define APPL_LTR_MSG_2_LTR_MSG_REQ_STATE	BIT(3)
+
+#define APPL_LINK_STATUS			0xCC
+#define APPL_LINK_STATUS_RDLH_LINK_UP		BIT(0)
+
+#define APPL_DEBUG				0xD0
+#define APPL_DEBUG_PM_LINKST_IN_L2_LAT		BIT(21)
+#define APPL_DEBUG_PM_LINKST_IN_L0		0x11
+#define APPL_DEBUG_LTSSM_STATE_MASK		GENMASK(8, 3)
+#define APPL_DEBUG_LTSSM_STATE_SHIFT		3
+#define LTSSM_STATE_PRE_DETECT			5
+
+#define APPL_RADM_STATUS			0xE4
+#define APPL_PM_XMT_TURNOFF_STATE		BIT(0)
+
+#define APPL_DM_TYPE				0x100
+#define APPL_DM_TYPE_MASK			GENMASK(3, 0)
+#define APPL_DM_TYPE_RP				0x4
+#define APPL_DM_TYPE_EP				0x0
+
+#define APPL_CFG_BASE_ADDR			0x104
+#define APPL_CFG_BASE_ADDR_MASK			GENMASK(31, 12)
+
+#define APPL_CFG_IATU_DMA_BASE_ADDR		0x108
+#define APPL_CFG_IATU_DMA_BASE_ADDR_MASK	GENMASK(31, 18)
+
+#define APPL_CFG_MISC				0x110
+#define APPL_CFG_MISC_SLV_EP_MODE		BIT(14)
+#define APPL_CFG_MISC_ARCACHE_MASK		GENMASK(13, 10)
+#define APPL_CFG_MISC_ARCACHE_SHIFT		10
+#define APPL_CFG_MISC_ARCACHE_VAL		3
+
+#define APPL_CFG_SLCG_OVERRIDE			0x114
+#define APPL_CFG_SLCG_OVERRIDE_SLCG_EN_MASTER	BIT(0)
+
+#define APPL_CAR_RESET_OVRD				0x12C
+#define APPL_CAR_RESET_OVRD_CYA_OVERRIDE_CORE_RST_N	BIT(0)
+
+#define IO_BASE_IO_DECODE				BIT(0)
+#define IO_BASE_IO_DECODE_BIT8				BIT(8)
+
+#define CFG_PREF_MEM_LIMIT_BASE_MEM_DECODE		BIT(0)
+#define CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE	BIT(16)
+
+#define CFG_LINK_CAP				0x7C
+
+#define CFG_DEV_STATUS_CONTROL			0x78
+#define CFG_DEV_STATUS_CONTROL_MPS_SHIFT	5
+
+#define CFG_LINK_CONTROL		0x80
+
+#define CFG_LINK_STATUS			0x82
+
+#define CFG_LINK_CONTROL_2		0xA0
+
+#define CFG_LINK_STATUS_2		0xA2
+#define CFG_LINK_STATUS_2_PCIE_CAP_EQ_CPL	BIT(17)
+
+#define CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF	0x718
+#define CFG_TIMER_CTRL_ACK_NAK_SHIFT	(19)
+
+#define  PCI_L1SS_CAP_CM_RTM_SHIFT	8	/* Common mode restore mask */
+#define  PCI_L1SS_CAP_PWRN_VAL_SHIFT	19	/* T_POWER_ON val shift */
+
+#define EVENT_COUNTER_ALL_CLEAR		0x3
+#define EVENT_COUNTER_ENABLE_ALL	0x7
+#define EVENT_COUNTER_ENABLE_SHIFT	2
+#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(7, 0)
+#define EVENT_COUNTER_EVENT_SEL_SHIFT	16
+#define EVENT_COUNTER_EVENT_Tx_L0S	0x2
+#define EVENT_COUNTER_EVENT_Rx_L0S	0x3
+#define EVENT_COUNTER_EVENT_L1		0x5
+#define EVENT_COUNTER_EVENT_L1_1	0x7
+#define EVENT_COUNTER_EVENT_L1_2	0x8
+#define EVENT_COUNTER_GROUP_SEL_SHIFT	24
+#define EVENT_COUNTER_GROUP_5		0x5
+
+#define DL_FEATURE_EXCHANGE_EN		BIT(31)
+
+#define PORT_LOGIC_ACK_F_ASPM_CTRL			0x70C
+#define ENTER_ASPM					BIT(30)
+#define L0S_ENTRANCE_LAT_SHIFT				24
+#define L0S_ENTRANCE_LAT_MASK				GENMASK(26, 24)
+#define L1_ENTRANCE_LAT_SHIFT				27
+#define L1_ENTRANCE_LAT_MASK				GENMASK(29, 27)
+#define N_FTS_SHIFT					8
+#define N_FTS_MASK					GENMASK(7, 0)
+#define N_FTS_VAL					52
+
+#define PORT_LOGIC_GEN2_CTRL				0x80C
+#define PORT_LOGIC_GEN2_CTRL_DIRECT_SPEED_CHANGE	BIT(17)
+#define FTS_MASK					GENMASK(7, 0)
+#define FTS_VAL						52
+
+#define PORT_LOGIC_MSI_CTRL_INT_0_EN		0x828
+
+#define GEN3_EQ_CONTROL_OFF			0x8a8
+#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT	8
+#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
+#define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK	GENMASK(3, 0)
+
+#define GEN3_RELATED_OFF			0x890
+#define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
+#define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
+
+#define PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT	0x8D0
+#define AMBA_ERROR_RESPONSE_CRS_SHIFT		3
+#define AMBA_ERROR_RESPONSE_CRS_MASK		GENMASK(1, 0)
+#define AMBA_ERROR_RESPONSE_CRS_OKAY		0
+#define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFFFFFF	1
+#define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001	2
+
+#define PORT_LOGIC_MSIX_DOORBELL			0x948
+
+#define PORT_LOGIC_PL_CHK_REG_CONTROL_STATUS		0xB20
+#define PORT_LOGIC_PL_CHK_REG_CHK_REG_START		BIT(0)
+#define PORT_LOGIC_PL_CHK_REG_CHK_REG_CONTINUOUS	BIT(1)
+#define PORT_LOGIC_PL_CHK_REG_CHK_REG_COMPARISON_ERROR	BIT(16)
+#define PORT_LOGIC_PL_CHK_REG_CHK_REG_LOGIC_ERROR	BIT(17)
+#define PORT_LOGIC_PL_CHK_REG_CHK_REG_COMPLETE		BIT(18)
+
+#define PORT_LOGIC_MISC_CONTROL			0x8bc
+#define PORT_LOGIC_MISC_CONTROL_DBI_RO_WR_EN	BIT(0)
+
+#define PORT_LOGIC_PL_CHK_REG_ERR_ADDR		0xB28
+
+#define CAP_SPCIE_CAP_OFF			0x154
+#define CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK	GENMASK(3, 0)
+#define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
+#define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
+
+#define PL16G_CAP_OFF				0x188
+#define PL16G_CAP_OFF_DSP_16G_TX_PRESET_MASK	GENMASK(3, 0)
+#define PL16G_CAP_OFF_USP_16G_TX_PRESET_MASK	GENMASK(7, 4)
+#define PL16G_CAP_OFF_USP_16G_TX_PRESET_SHIFT	4
+
+#define PME_ACK_TIMEOUT 10000
+
+#define LTSSM_TIMEOUT 50000	/* 50ms */
+
+#define GEN3_GEN4_EQ_PRESET_INIT	5
+
+#define GEN1_CORE_CLK_FREQ	62500000
+#define GEN2_CORE_CLK_FREQ	125000000
+#define GEN3_CORE_CLK_FREQ	250000000
+#define GEN4_CORE_CLK_FREQ	500000000
+
+static unsigned int pcie_gen_freq[] = {
+	GEN1_CORE_CLK_FREQ,
+	GEN2_CORE_CLK_FREQ,
+	GEN3_CORE_CLK_FREQ,
+	GEN4_CORE_CLK_FREQ
+};
+
+struct tegra_pcie_dw {
+	struct device		*dev;
+	struct resource		*appl_res;
+	struct resource		*dbi_res;
+	struct resource		*atu_dma_res;
+	void __iomem		*appl_base;
+	struct clk		*core_clk;
+	struct reset_control	*core_apb_rst;
+	struct reset_control	*core_rst;
+	struct dw_pcie		pci;
+	enum dw_pcie_device_mode mode;
+
+	bool disable_clock_request;
+	bool power_down_en;
+	u8 init_link_width;
+	bool link_state;
+	u32 msi_ctrl_int;
+	u32 num_lanes;
+	u32 max_speed;
+	u32 init_speed;
+	bool cdm_check;
+	u32 cid;
+	int pex_wake;
+	bool update_fc_fixup;
+	int n_gpios;
+	int *gpios;
+#if defined(CONFIG_PCIEASPM)
+	u32 cfg_link_cap_l1sub;
+	u32 event_cntr_ctrl;
+	u32 event_cntr_data;
+	u32 aspm_cmrt;
+	u32 aspm_pwr_on_t;
+	u32 aspm_l0s_enter_lat;
+	u32 disabled_aspm_states;
+#endif
+
+	struct regulator	*pex_ctl_reg;
+
+	int			phy_count;
+	struct phy		**phy;
+
+	struct dentry		*debugfs;
+};
+
+struct tegra_pcie_of_data {
+	enum dw_pcie_device_mode mode;
+};
+
+static void apply_bad_link_workaround(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
+	u16 val;
+
+	/*
+	 * NOTE:- Since this scenario is uncommon and link as
+	 * such is not stable anyway, not waiting to confirm
+	 * if link is really transiting to Gen-2 speed
+	 */
+	val = dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
+	if (val & PCI_EXP_LNKSTA_LBMS) {
+		if (pcie->init_link_width >
+		    (val & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT) {
+			dev_warn(pci->dev, "PCIe link is bad, width reduced\n");
+			val = dw_pcie_readw_dbi(pci, CFG_LINK_CONTROL_2);
+			val &= ~PCI_EXP_LNKCTL2_TLS;
+			val |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+			dw_pcie_writew_dbi(pci, CFG_LINK_CONTROL_2, val);
+
+			val = dw_pcie_readw_dbi(pci, CFG_LINK_CONTROL);
+			val |= PCI_EXP_LNKCTL_RL;
+			dw_pcie_writew_dbi(pci, CFG_LINK_CONTROL, val);
+		}
+	}
+}
+
+static irqreturn_t tegra_pcie_rp_irq_handler(struct tegra_pcie_dw *pcie)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	u32 val, tmp;
+	u16 val_w;
+
+	val = readl(pcie->appl_base + APPL_INTR_STATUS_L0);
+	dev_dbg(pci->dev, "APPL_INTR_STATUS_L0 = 0x%08X\n", val);
+	if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
+		val = readl(pcie->appl_base + APPL_INTR_STATUS_L1_0_0);
+		dev_dbg(pci->dev, "APPL_INTR_STATUS_L1_0_0 = 0x%08X\n", val);
+		if (val & APPL_INTR_STATUS_L1_0_0_LINK_REQ_RST_NOT_CHGED) {
+			writel(val, pcie->appl_base + APPL_INTR_STATUS_L1_0_0);
+
+			/* SBR & Surprise Link Down WAR */
+			val = readl(pcie->appl_base + APPL_CAR_RESET_OVRD);
+			val &= ~APPL_CAR_RESET_OVRD_CYA_OVERRIDE_CORE_RST_N;
+			writel(val, pcie->appl_base + APPL_CAR_RESET_OVRD);
+			udelay(1);
+			val = readl(pcie->appl_base + APPL_CAR_RESET_OVRD);
+			val |= APPL_CAR_RESET_OVRD_CYA_OVERRIDE_CORE_RST_N;
+			writel(val, pcie->appl_base + APPL_CAR_RESET_OVRD);
+
+			val = dw_pcie_readl_dbi(pci, PORT_LOGIC_GEN2_CTRL);
+			val |= PORT_LOGIC_GEN2_CTRL_DIRECT_SPEED_CHANGE;
+			dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
+		}
+	}
+	if (val & APPL_INTR_STATUS_L0_INT_INT) {
+		val = readl(pcie->appl_base + APPL_INTR_STATUS_L1_8_0);
+		dev_dbg(pci->dev, "APPL_INTR_STATUS_L1_8_0 = 0x%08X\n", val);
+		if (val & APPL_INTR_STATUS_L1_8_0_AUTO_BW_INT_STS) {
+			writel(APPL_INTR_STATUS_L1_8_0_AUTO_BW_INT_STS,
+			       pcie->appl_base + APPL_INTR_STATUS_L1_8_0);
+			apply_bad_link_workaround(pp);
+		}
+		if (val & APPL_INTR_STATUS_L1_8_0_BW_MGT_INT_STS) {
+			writel(APPL_INTR_STATUS_L1_8_0_BW_MGT_INT_STS,
+			       pcie->appl_base + APPL_INTR_STATUS_L1_8_0);
+
+			val_w = dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
+			dev_dbg(pci->dev, "Link Speed : Gen-%u\n", val_w &
+				PCI_EXP_LNKSTA_CLS);
+		}
+	}
+	val = readl(pcie->appl_base + APPL_INTR_STATUS_L0);
+	if (val & APPL_INTR_STATUS_L0_CDM_REG_CHK_INT) {
+		val = readl(pcie->appl_base + APPL_INTR_STATUS_L1_18);
+		tmp = dw_pcie_readl_dbi(pci,
+					PORT_LOGIC_PL_CHK_REG_CONTROL_STATUS);
+		dev_dbg(pci->dev, "APPL_INTR_STATUS_L1_18 = 0x%08X\n", val);
+		if (val & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMPLT) {
+			dev_err(pci->dev, "CDM check complete\n");
+			tmp |= PORT_LOGIC_PL_CHK_REG_CHK_REG_COMPLETE;
+		}
+		if (val & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMP_ERR) {
+			dev_err(pci->dev, "CDM comparison mismatch\n");
+			tmp |= PORT_LOGIC_PL_CHK_REG_CHK_REG_COMPARISON_ERROR;
+		}
+		if (val & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_LOGIC_ERR) {
+			dev_err(pci->dev, "CDM Logic error\n");
+			tmp |= PORT_LOGIC_PL_CHK_REG_CHK_REG_LOGIC_ERROR;
+		}
+		dw_pcie_writel_dbi(pci, PORT_LOGIC_PL_CHK_REG_CONTROL_STATUS,
+				   tmp);
+		tmp = dw_pcie_readl_dbi(pci, PORT_LOGIC_PL_CHK_REG_ERR_ADDR);
+		dev_err(pci->dev, "CDM Error Address Offset = 0x%08X\n", tmp);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t tegra_pcie_irq_handler(int irq, void *arg)
+{
+	struct tegra_pcie_dw *pcie = (struct tegra_pcie_dw *)arg;
+
+	if (pcie->mode == DW_PCIE_RC_TYPE)
+		return tegra_pcie_rp_irq_handler(pcie);
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t tegra_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	return dw_handle_msi_irq(pp);
+}
+
+static int tegra_pcie_dw_rd_own_conf(struct pcie_port *pp, int where, int size,
+				     u32 *val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	/*
+	 * This is an endpoint mode specific register happen to appear even
+	 * when controller is operating in root port mode and system hangs
+	 * when it is accessed with link being in ASPM-L1 state.
+	 * So skip accessing it altogether
+	 */
+	if (where == PORT_LOGIC_MSIX_DOORBELL) {
+		*val = 0x00000000;
+		return PCIBIOS_SUCCESSFUL;
+	} else {
+		return dw_pcie_read(pci->dbi_base + where, size, val);
+	}
+}
+
+static int tegra_pcie_dw_wr_own_conf(struct pcie_port *pp, int where, int size,
+				     u32 val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	/* This is EP specific register and system hangs when it is
+	 * accessed with link being in ASPM-L1 state.
+	 * So skip accessing it altogether
+	 */
+	if (where == PORT_LOGIC_MSIX_DOORBELL)
+		return PCIBIOS_SUCCESSFUL;
+	else
+		return dw_pcie_write(pci->dbi_base + where, size, val);
+}
+
+static void config_plat_gpio(struct tegra_pcie_dw *pcie, bool flag)
+{
+	int count;
+
+	for (count = 0; count < pcie->n_gpios; ++count)
+		gpiod_set_value(gpio_to_desc(pcie->gpios[count]), flag);
+}
+
+#if defined(CONFIG_PCIEASPM)
+static void disable_aspm_l0s(struct tegra_pcie_dw *pcie)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(&pcie->pci, CFG_LINK_CAP);
+	val &= ~(PCI_EXP_LNKCTL_ASPM_L0S << 10);
+	dw_pcie_writel_dbi(&pcie->pci, CFG_LINK_CAP, val);
+}
+
+static void disable_aspm_l10(struct tegra_pcie_dw *pcie)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(&pcie->pci, CFG_LINK_CAP);
+	val &= ~(PCI_EXP_LNKCTL_ASPM_L1 << 10);
+	dw_pcie_writel_dbi(&pcie->pci, CFG_LINK_CAP, val);
+}
+
+static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
+	val &= ~PCI_L1SS_CAP_ASPM_L1_1;
+	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
+}
+
+static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
+	val &= ~PCI_L1SS_CAP_ASPM_L1_2;
+	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
+}
+
+static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(&pcie->pci, pcie->event_cntr_ctrl);
+	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
+	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
+	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
+	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
+	dw_pcie_writel_dbi(&pcie->pci, pcie->event_cntr_ctrl, val);
+	val = dw_pcie_readl_dbi(&pcie->pci, pcie->event_cntr_data);
+	return val;
+}
+
+static int aspm_state_cnt(struct seq_file *s, void *data)
+{
+	struct tegra_pcie_dw *pcie = (struct tegra_pcie_dw *)(s->private);
+	u32 val;
+
+	seq_printf(s, "Tx L0s entry count : %u\n",
+		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_Tx_L0S));
+
+	seq_printf(s, "Rx L0s entry count : %u\n",
+		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_Rx_L0S));
+
+	seq_printf(s, "Link L1 entry count : %u\n",
+		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_L1));
+
+	seq_printf(s, "Link L1.1 entry count : %u\n",
+		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_L1_1));
+
+	seq_printf(s, "Link L1.2 entry count : %u\n",
+		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_L1_2));
+
+	/* Clear all counters */
+	dw_pcie_writel_dbi(&pcie->pci, pcie->event_cntr_ctrl,
+			   EVENT_COUNTER_ALL_CLEAR);
+
+	/* Re-enable counting */
+	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
+	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
+	dw_pcie_writel_dbi(&pcie->pci, pcie->event_cntr_ctrl, val);
+
+	return 0;
+}
+
+#define DEFINE_ENTRY(__name)	\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, __name, inode->i_private); \
+}									\
+static const struct file_operations __name ## _fops = {	\
+	.open		= __name ## _open,	\
+	.read		= seq_read,	\
+	.llseek		= seq_lseek,	\
+	.release	= single_release,	\
+}
+
+DEFINE_ENTRY(aspm_state_cnt);
+#endif
+
+static int init_debugfs(struct tegra_pcie_dw *pcie)
+{
+#if defined(CONFIG_PCIEASPM)
+	struct dentry *d;
+
+	d = debugfs_create_file("aspm_state_cnt", 0444, pcie->debugfs,
+				(void *)pcie, &aspm_state_cnt_fops);
+	if (!d)
+		dev_err(pcie->dev, "debugfs for aspm_state_cnt failed\n");
+#endif
+	return 0;
+}
+
+static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
+	u32 val;
+	u16 val_w;
+
+	val = readl(pcie->appl_base + APPL_INTR_EN_L0_0);
+	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
+	writel(val, pcie->appl_base + APPL_INTR_EN_L0_0);
+
+	val = readl(pcie->appl_base + APPL_INTR_EN_L1_0_0);
+	val |= APPL_INTR_EN_L1_0_0_LINK_REQ_RST_NOT_INT_EN;
+	writel(val, pcie->appl_base + APPL_INTR_EN_L1_0_0);
+
+	if (pcie->cdm_check) {
+		val = readl(pcie->appl_base + APPL_INTR_EN_L0_0);
+		val |= APPL_INTR_EN_L0_0_CDM_REG_CHK_INT_EN;
+		writel(val, pcie->appl_base + APPL_INTR_EN_L0_0);
+
+		val = readl(pcie->appl_base + APPL_INTR_EN_L1_18);
+		val |= APPL_INTR_EN_L1_18_CDM_REG_CHK_CMP_ERR;
+		val |= APPL_INTR_EN_L1_18_CDM_REG_CHK_LOGIC_ERR;
+		writel(val, pcie->appl_base + APPL_INTR_EN_L1_18);
+	}
+
+	val_w = dw_pcie_readw_dbi(&pcie->pci, CFG_LINK_STATUS);
+	pcie->init_link_width = (val_w & PCI_EXP_LNKSTA_NLW) >>
+				PCI_EXP_LNKSTA_NLW_SHIFT;
+
+	val_w = dw_pcie_readw_dbi(&pcie->pci, CFG_LINK_CONTROL);
+	val_w |= PCI_EXP_LNKCTL_LBMIE;
+	dw_pcie_writew_dbi(&pcie->pci, CFG_LINK_CONTROL, val_w);
+}
+
+static void tegra_pcie_enable_legacy_interrupts(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
+	u32 val;
+
+	/* enable legacy interrupt generation */
+	val = readl(pcie->appl_base + APPL_INTR_EN_L0_0);
+	val |= APPL_INTR_EN_L0_0_SYS_INTR_EN;
+	val |= APPL_INTR_EN_L0_0_INT_INT_EN;
+	writel(val, pcie->appl_base + APPL_INTR_EN_L0_0);
+
+	val = readl(pcie->appl_base + APPL_INTR_EN_L1_8_0);
+	val |= APPL_INTR_EN_L1_8_INTX_EN;
+	val |= APPL_INTR_EN_L1_8_AUTO_BW_INT_EN;
+	val |= APPL_INTR_EN_L1_8_BW_MGT_INT_EN;
+	if (IS_ENABLED(CONFIG_PCIEAER))
+		val |= APPL_INTR_EN_L1_8_AER_INT_EN;
+	writel(val, pcie->appl_base + APPL_INTR_EN_L1_8_0);
+}
+
+static void tegra_pcie_enable_msi_interrupts(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
+	u32 val;
+
+	dw_pcie_msi_init(pp);
+
+	/* enable MSI interrupt generation */
+	val = readl(pcie->appl_base + APPL_INTR_EN_L0_0);
+	val |= APPL_INTR_EN_L0_0_SYS_MSI_INTR_EN;
+	val |= APPL_INTR_EN_L0_0_MSI_RCV_INT_EN;
+	writel(val, pcie->appl_base + APPL_INTR_EN_L0_0);
+}
+
+static void tegra_pcie_enable_interrupts(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
+
+	/* Clear interrupt statuses before enabling interrupts */
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L0);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_0_0);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_1);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_2);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_3);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_6);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_7);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_8_0);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_9);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_10);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_11);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_13);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_14);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_15);
+	writel(0xFFFFFFFF, pcie->appl_base + APPL_INTR_STATUS_L1_17);
+
+	tegra_pcie_enable_system_interrupts(pp);
+	tegra_pcie_enable_legacy_interrupts(pp);
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		tegra_pcie_enable_msi_interrupts(pp);
+}
+
+static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	int i;
+	u32 val, offset;
+
+	/* program init preset */
+	for (i = 0; i < pcie->num_lanes; i++) {
+		dw_pcie_read(pci->dbi_base + CAP_SPCIE_CAP_OFF
+				 + (i * 2), 2, &val);
+		val &= ~CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK;
+		val |= GEN3_GEN4_EQ_PRESET_INIT;
+		val &= ~CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK;
+		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
+			   CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT);
+		dw_pcie_write(pci->dbi_base + CAP_SPCIE_CAP_OFF
+				 + (i * 2), 2, val);
+
+		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PL) +
+				PCI_PL_16GT_LE_CTRL;
+		dw_pcie_read(pci->dbi_base + offset + i, 1, &val);
+		val &= ~PL16G_CAP_OFF_DSP_16G_TX_PRESET_MASK;
+		val |= GEN3_GEN4_EQ_PRESET_INIT;
+		val &= ~PL16G_CAP_OFF_USP_16G_TX_PRESET_MASK;
+		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
+			PL16G_CAP_OFF_USP_16G_TX_PRESET_SHIFT);
+		dw_pcie_write(pci->dbi_base + offset + i, 1, val);
+	}
+
+	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+
+	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
+	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
+	val |= (0x3ff << GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
+	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
+	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
+
+	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
+	val |= (0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+
+	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
+	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
+	val |= (0x360 << GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
+	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
+	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
+
+	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+}
+
+static int tegra_pcie_dw_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
+	int count = 200;
+	u32 val, tmp, offset;
+	u16 val_w;
+
+#if defined(CONFIG_PCIEASPM)
+	pcie->cfg_link_cap_l1sub =
+		dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS) +
+		PCI_L1SS_CAP;
+#endif
+	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
+	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
+	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
+
+	val = dw_pcie_readl_dbi(pci, PCI_PREF_MEMORY_BASE);
+	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_DECODE;
+	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE;
+	dw_pcie_writel_dbi(pci, PCI_PREF_MEMORY_BASE, val);
+
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
+
+	/* Configure FTS */
+	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
+	val &= ~(N_FTS_MASK << N_FTS_SHIFT);
+	val |= N_FTS_VAL << N_FTS_SHIFT;
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
+
+	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_GEN2_CTRL);
+	val &= ~FTS_MASK;
+	val |= FTS_VAL;
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
+
+	/* Enable as 0xFFFF0001 response for CRS */
+	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
+	val &= ~(AMBA_ERROR_RESPONSE_CRS_MASK << AMBA_ERROR_RESPONSE_CRS_SHIFT);
+	val |= (AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001 <<
+		AMBA_ERROR_RESPONSE_CRS_SHIFT);
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
+
+	/* Set MPS to 256 in DEV_CTL */
+	val = dw_pcie_readl_dbi(pci, CFG_DEV_STATUS_CONTROL);
+	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	val |= (1 << CFG_DEV_STATUS_CONTROL_MPS_SHIFT);
+	dw_pcie_writel_dbi(pci, CFG_DEV_STATUS_CONTROL, val);
+
+	/* Configure Max Speed from DT */
+	val = dw_pcie_readl_dbi(pci, CFG_LINK_CAP);
+	val &= ~PCI_EXP_LNKCAP_SLS;
+	val |= pcie->max_speed;
+	dw_pcie_writel_dbi(pci, CFG_LINK_CAP, val);
+
+	val = dw_pcie_readw_dbi(pci, CFG_LINK_CONTROL_2);
+	val &= ~PCI_EXP_LNKCTL2_TLS;
+	val |= pcie->init_speed;
+	dw_pcie_writew_dbi(pci, CFG_LINK_CONTROL_2, val);
+
+	/* Configure Max lane width from DT */
+	val = dw_pcie_readl_dbi(pci, CFG_LINK_CAP);
+	val &= ~PCI_EXP_LNKCAP_MLW;
+	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
+	dw_pcie_writel_dbi(pci, CFG_LINK_CAP, val);
+
+	config_gen3_gen4_eq_presets(pcie);
+
+#if defined(CONFIG_PCIEASPM)
+	/* Enable ASPM counters */
+	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
+	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
+	dw_pcie_writel_dbi(pci, pcie->event_cntr_ctrl, val);
+
+	/* Program T_cmrt and T_pwr_on values */
+	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
+	val &= ~(PCI_L1SS_CAP_CM_RESTORE_TIME | PCI_L1SS_CAP_P_PWR_ON_VALUE);
+	val |= (pcie->aspm_cmrt << PCI_L1SS_CAP_CM_RTM_SHIFT);
+	val |= (pcie->aspm_pwr_on_t << PCI_L1SS_CAP_PWRN_VAL_SHIFT);
+	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
+
+	/* Program L0s and L1 entrance latencies */
+	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
+	val &= ~L0S_ENTRANCE_LAT_MASK;
+	val |= (pcie->aspm_l0s_enter_lat << L0S_ENTRANCE_LAT_SHIFT);
+	val |= ENTER_ASPM;
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
+
+	/* Program what ASPM states sould get advertised */
+	if (pcie->disabled_aspm_states & 0x1)
+		disable_aspm_l0s(pcie); /* Disable L0s */
+	if (pcie->disabled_aspm_states & 0x2) {
+		disable_aspm_l10(pcie); /* Disable L1 */
+		disable_aspm_l11(pcie); /* Disable L1.1 */
+		disable_aspm_l12(pcie); /* Disable L1.2 */
+	}
+	if (pcie->disabled_aspm_states & 0x4)
+		disable_aspm_l11(pcie); /* Disable L1.1 */
+	if (pcie->disabled_aspm_states & 0x8)
+		disable_aspm_l12(pcie); /* Disable L1.2 */
+#endif
+	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+
+	if (pcie->update_fc_fixup) {
+		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
+		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
+		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
+	}
+
+	/* CDM check enable */
+	if (pcie->cdm_check) {
+		val = dw_pcie_readl_dbi(pci,
+					PORT_LOGIC_PL_CHK_REG_CONTROL_STATUS);
+		val |= PORT_LOGIC_PL_CHK_REG_CHK_REG_CONTINUOUS;
+		val |= PORT_LOGIC_PL_CHK_REG_CHK_REG_START;
+		dw_pcie_writel_dbi(pci, PORT_LOGIC_PL_CHK_REG_CONTROL_STATUS,
+				   val);
+	}
+
+	dw_pcie_setup_rc(pp);
+
+	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
+
+	/* assert RST */
+	val = readl(pcie->appl_base + APPL_PINMUX);
+	val &= ~APPL_PINMUX_PEX_RST;
+	writel(val, pcie->appl_base + APPL_PINMUX);
+
+	usleep_range(100, 200);
+
+	/* enable LTSSM */
+	val = readl(pcie->appl_base + APPL_CTRL);
+	val |= APPL_CTRL_LTSSM_EN;
+	writel(val, pcie->appl_base + APPL_CTRL);
+
+	/* de-assert RST */
+	val = readl(pcie->appl_base + APPL_PINMUX);
+	val |= APPL_PINMUX_PEX_RST;
+	writel(val, pcie->appl_base + APPL_PINMUX);
+
+	msleep(100);
+
+	val_w = dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
+	while (!(val_w & PCI_EXP_LNKSTA_DLLLA)) {
+		if (!count) {
+			val = readl(pcie->appl_base + APPL_DEBUG);
+			val &= APPL_DEBUG_LTSSM_STATE_MASK;
+			val >>= APPL_DEBUG_LTSSM_STATE_SHIFT;
+			tmp = readl(pcie->appl_base + APPL_LINK_STATUS);
+			tmp &= APPL_LINK_STATUS_RDLH_LINK_UP;
+			if (val == 0x11 && !tmp) {
+				dev_info(pci->dev, "link is down in DLL");
+				dev_info(pci->dev,
+					 "trying again with DLFE disabled\n");
+				/* disable LTSSM */
+				val = readl(pcie->appl_base + APPL_CTRL);
+				val &= ~APPL_CTRL_LTSSM_EN;
+				writel(val, pcie->appl_base + APPL_CTRL);
+
+				reset_control_assert(pcie->core_rst);
+				reset_control_deassert(pcie->core_rst);
+
+				offset =
+				dw_pcie_find_ext_capability(pci,
+							    PCI_EXT_CAP_ID_DLF)
+				+ PCI_DLF_CAP;
+				val = dw_pcie_readl_dbi(pci, offset);
+				val &= ~DL_FEATURE_EXCHANGE_EN;
+				dw_pcie_writel_dbi(pci, offset, val);
+
+				tegra_pcie_dw_host_init(&pcie->pci.pp);
+				return 0;
+			}
+			dev_info(pci->dev, "link is down\n");
+			return 0;
+		}
+		dev_dbg(pci->dev, "polling for link up\n");
+		usleep_range(1000, 2000);
+		val_w = dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
+		count--;
+	}
+	dev_info(pci->dev, "link is up\n");
+
+	tegra_pcie_enable_interrupts(pp);
+
+	return 0;
+}
+
+static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
+{
+	u32 val = dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
+
+	return !!(val & PCI_EXP_LNKSTA_DLLLA);
+}
+
+static void tegra_pcie_dw_scan_bus(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
+	u32 speed;
+
+	if (!tegra_pcie_dw_link_up(pci))
+		return;
+
+	speed = (dw_pcie_readw_dbi(pci, CFG_LINK_STATUS) & PCI_EXP_LNKSTA_CLS);
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+}
+
+static void tegra_pcie_set_msi_vec_num(struct pcie_port *pp)
+{
+	pp->num_vectors = MAX_MSI_IRQS;
+}
+
+static const struct dw_pcie_ops tegra_dw_pcie_ops = {
+	.link_up = tegra_pcie_dw_link_up,
+};
+
+static struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
+	.rd_own_conf = tegra_pcie_dw_rd_own_conf,
+	.wr_own_conf = tegra_pcie_dw_wr_own_conf,
+	.host_init = tegra_pcie_dw_host_init,
+	.scan_bus = tegra_pcie_dw_scan_bus,
+	.set_num_vectors = tegra_pcie_set_msi_vec_num,
+};
+
+static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
+{
+	int phy_count = pcie->phy_count;
+
+	while (phy_count--) {
+		phy_power_off(pcie->phy[phy_count]);
+		phy_exit(pcie->phy[phy_count]);
+	}
+}
+
+static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
+{
+	int phy_count = pcie->phy_count;
+	int ret;
+	int i;
+
+	for (i = 0; i < phy_count; i++) {
+		ret = phy_init(pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy_init;
+
+		ret = phy_power_on(pcie->phy[i]);
+		if (ret < 0) {
+			phy_exit(pcie->phy[i]);
+			goto err_phy_power_on;
+		}
+	}
+
+	return 0;
+
+	while (i >= 0) {
+		phy_power_off(pcie->phy[i]);
+err_phy_power_on:
+		phy_exit(pcie->phy[i]);
+err_phy_init:
+		i--;
+	}
+
+	return ret;
+}
+
+static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
+{
+	struct device_node *np = pcie->dev->of_node;
+	int ret;
+
+#if defined(CONFIG_PCIEASPM)
+	ret = of_property_read_u32(np, "nvidia,event-cntr-ctrl",
+				   &pcie->event_cntr_ctrl);
+	if (ret < 0) {
+		dev_err(pcie->dev, "fail to read event-cntr-ctrl: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "nvidia,event-cntr-data",
+				   &pcie->event_cntr_data);
+	if (ret < 0) {
+		dev_err(pcie->dev, "fail to read event-cntr-data: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "nvidia,aspm-cmrt", &pcie->aspm_cmrt);
+	if (ret < 0) {
+		dev_info(pcie->dev, "fail to read ASPM T_cmrt: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "nvidia,aspm-pwr-on-t",
+				   &pcie->aspm_pwr_on_t);
+	if (ret < 0)
+		dev_info(pcie->dev, "fail to read ASPM Power On time: %d\n",
+			 ret);
+
+	ret = of_property_read_u32(np, "nvidia,aspm-l0s-entrance-latency",
+				   &pcie->aspm_l0s_enter_lat);
+	if (ret < 0)
+		dev_info(pcie->dev,
+			 "fail to read ASPM L0s Entrance latency: %d\n", ret);
+
+	ret = of_property_read_u32(np, "nvidia,disable-aspm-states",
+				   &pcie->disabled_aspm_states);
+	if (ret < 0) {
+		dev_info(pcie->dev,
+			 "Disabling advertisement of all ASPM states\n");
+		pcie->disabled_aspm_states = 0xF;
+	}
+#endif
+	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
+	if (ret < 0) {
+		dev_err(pcie->dev, "fail to read num-lanes: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "nvidia,max-speed", &pcie->max_speed);
+	if (ret < 0 || (pcie->max_speed < 1 || pcie->max_speed > 4)) {
+		dev_err(pcie->dev, "invalid max-speed (err=%d), set to Gen-1\n",
+			ret);
+		pcie->max_speed = 1;
+	}
+
+	ret = of_property_read_u32(np, "nvidia,init-speed", &pcie->init_speed);
+	if (ret < 0 || (pcie->init_speed < 1 || pcie->init_speed > 4)) {
+		dev_dbg(pcie->dev, "Setting init speed to max speed\n");
+		pcie->init_speed = pcie->max_speed;
+	}
+
+	ret = of_property_read_u32_index(np, "nvidia,controller-id", 1,
+					 &pcie->cid);
+	if (ret) {
+		dev_err(pcie->dev, "Controller-ID is missing in DT: %d\n", ret);
+		return ret;
+	}
+
+	pcie->phy_count = of_property_count_strings(np, "phy-names");
+	if (pcie->phy_count < 0) {
+		dev_err(pcie->dev, "unable to find phy entries\n");
+		return pcie->phy_count;
+	}
+
+	if (of_property_read_bool(np, "nvidia,update-fc-fixup"))
+		pcie->update_fc_fixup = true;
+
+	pcie->pex_wake = of_get_named_gpio(np, "nvidia,pex-wake", 0);
+
+	pcie->power_down_en = of_property_read_bool(pcie->dev->of_node,
+						    "nvidia,enable-power-down");
+
+	pcie->disable_clock_request =
+		of_property_read_bool(pcie->dev->of_node,
+				      "nvidia,disable-clock-request");
+
+	pcie->cdm_check = of_property_read_bool(np, "nvidia,cdm-check");
+
+	pcie->n_gpios = of_gpio_named_count(np, "nvidia,plat-gpios");
+	if (pcie->n_gpios > 0) {
+		int count, gpio;
+		enum of_gpio_flags flags;
+		unsigned long f;
+
+		pcie->gpios = devm_kzalloc(pcie->dev,
+					   pcie->n_gpios * sizeof(int),
+					   GFP_KERNEL);
+		if (!pcie->gpios)
+			return -ENOMEM;
+
+		for (count = 0; count < pcie->n_gpios; ++count) {
+			gpio = of_get_named_gpio_flags(np,
+						       "nvidia,plat-gpios",
+						       count, &flags);
+			if (gpio < 0 && (gpio != -ENOENT))
+				return gpio;
+
+			f = (flags & OF_GPIO_ACTIVE_LOW) ?
+			    (GPIOF_OUT_INIT_HIGH | GPIOF_ACTIVE_LOW) :
+			     GPIOF_OUT_INIT_LOW;
+
+			ret = devm_gpio_request_one(pcie->dev, gpio, f,
+						    NULL);
+			if (ret < 0) {
+				dev_err(pcie->dev,
+					"gpio %d request failed\n",
+					gpio);
+				return ret;
+			}
+			pcie->gpios[count] = gpio;
+		}
+	}
+
+	return 0;
+}
+
+static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
+{
+	struct pcie_port *pp = &pcie->pci.pp;
+	char *name;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = of_irq_get_byname(pcie->dev->of_node, "msi");
+		if (!pp->msi_irq) {
+			dev_err(pcie->dev, "failed to get msi interrupt\n");
+			return -ENODEV;
+		}
+
+		ret = devm_request_irq(pcie->dev, pp->msi_irq,
+				       tegra_pcie_msi_irq_handler,
+				       IRQF_SHARED | IRQF_NO_THREAD,
+				       "tegra-pcie-msi", pp);
+		if (ret) {
+			dev_err(pcie->dev, "failed to request \"msi\" irq\n");
+			return ret;
+		}
+	}
+
+	pm_runtime_enable(pcie->dev);
+	ret = pm_runtime_get_sync(pcie->dev);
+	if (ret < 0) {
+		dev_err(pcie->dev, "failed to enable pcie dev");
+		pm_runtime_disable(pcie->dev);
+		return ret;
+	}
+
+	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
+
+	if (!pcie->link_state && pcie->power_down_en) {
+		ret = -ENOMEDIUM;
+		goto fail_host_init;
+	}
+
+	name = kasprintf(GFP_KERNEL, "pcie@%x",
+			 (uint32_t)pcie->appl_res->start);
+	if (!name) {
+		ret = -ENOMEM;
+		goto fail_host_init;
+	}
+
+	pcie->debugfs = debugfs_create_dir(name, NULL);
+	if (!pcie->debugfs)
+		dev_err(pcie->dev, "debugfs creation failed\n");
+	else
+		init_debugfs(pcie);
+	kfree(name);
+
+	return ret;
+
+fail_host_init:
+	pm_runtime_put_sync(pcie->dev);
+	return ret;
+}
+
+static const struct tegra_pcie_of_data tegra_pcie_rc_of_data = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct of_device_id tegra_pcie_dw_of_match[] = {
+	{
+		.compatible = "nvidia,tegra194-pcie",
+		.data = &tegra_pcie_rc_of_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
+
+static int tegra_pcie_dw_probe(struct platform_device *pdev)
+{
+	struct tegra_pcie_dw *pcie;
+	struct pcie_port *pp;
+	struct dw_pcie *pci;
+	struct phy **phy;
+	struct resource	*dbi_res;
+	struct resource	*atu_dma_res;
+	const struct of_device_id *match;
+	const struct tegra_pcie_of_data *data;
+	char *name;
+	int ret, i;
+
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pci = &pcie->pci;
+	pci->dev = &pdev->dev;
+	pci->ops = &tegra_dw_pcie_ops;
+	pp = &pci->pp;
+	pcie->dev = &pdev->dev;
+
+	match = of_match_device(of_match_ptr(tegra_pcie_dw_of_match),
+				&pdev->dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct tegra_pcie_of_data *)match->data;
+	pcie->mode = (enum dw_pcie_device_mode)data->mode;
+
+	ret = tegra_pcie_dw_parse_dt(pcie);
+	if (ret < 0) {
+		dev_err(pcie->dev, "device tree parsing failed: %d\n", ret);
+		return ret;
+	}
+
+	if (gpio_is_valid(pcie->pex_wake)) {
+		ret = devm_gpio_request(pcie->dev, pcie->pex_wake,
+					"pcie_wake");
+		if (ret < 0) {
+			if (ret == -EBUSY) {
+				dev_err(pcie->dev,
+					"pex_wake already in use\n");
+				pcie->pex_wake = -EINVAL;
+			} else {
+				dev_err(pcie->dev,
+					"pcie_wake gpio_request failed %d\n",
+					ret);
+				return ret;
+			}
+		}
+
+		ret = gpio_direction_input(pcie->pex_wake);
+		if (ret < 0) {
+			dev_err(pcie->dev,
+				"setting pcie_wake input direction failed %d\n",
+				ret);
+			return ret;
+		}
+		device_init_wakeup(pcie->dev, true);
+	}
+
+	pcie->pex_ctl_reg = devm_regulator_get(&pdev->dev, "vddio-pex-ctl");
+	if (IS_ERR(pcie->pex_ctl_reg)) {
+		dev_err(&pdev->dev, "fail to get regulator: %ld\n",
+			PTR_ERR(pcie->pex_ctl_reg));
+		return PTR_ERR(pcie->pex_ctl_reg);
+	}
+
+	pcie->core_clk = devm_clk_get(&pdev->dev, "core_clk");
+	if (IS_ERR(pcie->core_clk)) {
+		dev_err(&pdev->dev, "Failed to get core clock\n");
+		return PTR_ERR(pcie->core_clk);
+	}
+
+	pcie->appl_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						      "appl");
+	if (!pcie->appl_res) {
+		dev_err(&pdev->dev, "missing appl space\n");
+		return PTR_ERR(pcie->appl_res);
+	}
+	pcie->appl_base = devm_ioremap_resource(&pdev->dev, pcie->appl_res);
+	if (IS_ERR(pcie->appl_base)) {
+		dev_err(&pdev->dev, "mapping appl space failed\n");
+		return PTR_ERR(pcie->appl_base);
+	}
+
+	pcie->core_apb_rst = devm_reset_control_get(pcie->dev, "core_apb_rst");
+	if (IS_ERR(pcie->core_apb_rst)) {
+		dev_err(pcie->dev, "PCIE : core_apb_rst reset is missing\n");
+		return PTR_ERR(pcie->core_apb_rst);
+	}
+
+	phy = devm_kcalloc(pcie->dev, pcie->phy_count, sizeof(*phy),
+			   GFP_KERNEL);
+	if (!phy)
+		return PTR_ERR(phy);
+
+	for (i = 0; i < pcie->phy_count; i++) {
+		name = kasprintf(GFP_KERNEL, "pcie-p2u-%u", i);
+		if (!name) {
+			dev_err(pcie->dev, "failed to create p2u string\n");
+			return -ENOMEM;
+		}
+		phy[i] = devm_phy_get(pcie->dev, name);
+		kfree(name);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			dev_err(pcie->dev, "phy_get error: %d\n", ret);
+			return ret;
+		}
+	}
+
+	pcie->phy = phy;
+
+	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	if (!dbi_res) {
+		dev_err(&pdev->dev, "missing config space\n");
+		return PTR_ERR(dbi_res);
+	}
+	pcie->dbi_res = dbi_res;
+
+	pci->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_res);
+	if (IS_ERR(pci->dbi_base)) {
+		dev_err(&pdev->dev, "mapping dbi space failed\n");
+		return PTR_ERR(pci->dbi_base);
+	}
+
+	/* Tegra HW locates DBI2 at a fixed offset from DBI */
+	pci->dbi_base2 = pci->dbi_base + 0x1000;
+
+	atu_dma_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "atu_dma");
+	if (!atu_dma_res) {
+		dev_err(&pdev->dev, "missing atu_dma space\n");
+		return PTR_ERR(atu_dma_res);
+	}
+	pcie->atu_dma_res = atu_dma_res;
+	pci->atu_base = devm_ioremap_resource(&pdev->dev, atu_dma_res);
+	if (IS_ERR(pci->atu_base)) {
+		dev_err(&pdev->dev, "mapping atu space failed\n");
+		return PTR_ERR(pci->atu_base);
+	}
+
+	pcie->core_rst = devm_reset_control_get(pcie->dev, "core_rst");
+	if (IS_ERR(pcie->core_rst)) {
+		dev_err(pcie->dev, "PCIE : core_rst reset is missing\n");
+		return PTR_ERR(pcie->core_rst);
+	}
+
+	pp->irq = platform_get_irq_byname(pdev, "intr");
+	if (!pp->irq) {
+		dev_err(pcie->dev, "failed to get intr interrupt\n");
+		return -ENODEV;
+	}
+
+	ret = devm_request_irq(&pdev->dev, pp->irq, tegra_pcie_irq_handler,
+			       IRQF_SHARED, "tegra-pcie-intr", pcie);
+	if (ret) {
+		dev_err(pcie->dev, "failed to request \"intr\" irq\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pcie);
+
+	if (pcie->mode == DW_PCIE_RC_TYPE) {
+		ret = tegra_pcie_config_rp(pcie);
+		if (ret == -ENOMEDIUM)
+			ret = 0;
+	}
+
+	return ret;
+}
+
+static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
+{
+	u32 val;
+
+	if (!tegra_pcie_dw_link_up(&pcie->pci))
+		return 0;
+
+	val = readl(pcie->appl_base + APPL_RADM_STATUS);
+	val |= APPL_PM_XMT_TURNOFF_STATE;
+	writel(val, pcie->appl_base + APPL_RADM_STATUS);
+
+	return readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG, val,
+				 val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
+				 1, PME_ACK_TIMEOUT);
+}
+
+static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
+{
+	struct pci_dev *pdev = NULL;
+	struct pci_bus *child;
+	struct pcie_port *pp = &pcie->pci.pp;
+
+	list_for_each_entry(child, &pp->bus->children, node) {
+		/* Bring downstream devices to D0 if they are not already in */
+		if (child->parent == pp->bus) {
+			pdev = pci_get_slot(child, PCI_DEVFN(0, 0));
+			pci_dev_put(pdev);
+			if (!pdev)
+				break;
+
+			if (pci_set_power_state(pdev, PCI_D0))
+				dev_err(pcie->dev, "D0 transition failed\n");
+		}
+	}
+}
+
+static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
+{
+	u32 data;
+	int err;
+
+	if (!tegra_pcie_dw_link_up(&pcie->pci)) {
+		dev_dbg(pcie->dev, "PCIe link is not up...!\n");
+		return;
+	}
+
+	if (tegra_pcie_try_link_l2(pcie)) {
+		dev_info(pcie->dev, "Link didn't transit to L2 state\n");
+		/* TX lane clock freq will reset to Gen1 only if link is in L2
+		 * or detect state.
+		 * So apply pex_rst to end point to force RP to go into detect
+		 * state
+		 */
+		data = readl(pcie->appl_base + APPL_PINMUX);
+		data &= ~APPL_PINMUX_PEX_RST;
+		writel(data, pcie->appl_base + APPL_PINMUX);
+
+		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
+						data,
+						((data &
+						APPL_DEBUG_LTSSM_STATE_MASK) >>
+						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
+						LTSSM_STATE_PRE_DETECT,
+						1, LTSSM_TIMEOUT);
+		if (err) {
+			dev_info(pcie->dev, "Link didn't go to detect state\n");
+		} else {
+			/* Disable LTSSM after link is in detect state */
+			data = readl(pcie->appl_base + APPL_CTRL);
+			data &= ~APPL_CTRL_LTSSM_EN;
+			writel(data, pcie->appl_base + APPL_CTRL);
+		}
+	}
+	/* DBI registers may not be accessible after this as PLL-E would be
+	 * down depending on how CLKREQ is pulled by end point
+	 */
+	data = readl(pcie->appl_base + APPL_PINMUX);
+	data |= (APPL_PINMUX_CLKREQ_OVERRIDE_EN | APPL_PINMUX_CLKREQ_OVERRIDE);
+	/* Cut REFCLK to slot */
+	data |= APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN;
+	data &= ~APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE;
+	writel(data, pcie->appl_base + APPL_PINMUX);
+}
+
+static int tegra_pcie_dw_remove(struct platform_device *pdev)
+{
+	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+
+	if (pcie->mode == DW_PCIE_RC_TYPE) {
+		if (!pcie->link_state && pcie->power_down_en)
+			return 0;
+
+		debugfs_remove_recursive(pcie->debugfs);
+		pm_runtime_put_sync(pcie->dev);
+		pm_runtime_disable(pcie->dev);
+	}
+
+	return 0;
+}
+
+static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
+					  int enable)
+{
+	struct mrq_uphy_request req;
+	struct mrq_uphy_response resp;
+	struct tegra_bpmp_message msg;
+	struct tegra_bpmp *bpmp;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+	memset(&resp, 0, sizeof(resp));
+
+	req.cmd = CMD_UPHY_PCIE_CONTROLLER_STATE;
+	req.controller_state.pcie_controller = pcie->cid;
+	req.controller_state.enable = enable;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_UPHY;
+	msg.tx.data = &req;
+	msg.tx.size = sizeof(req);
+	msg.rx.data = &resp;
+	msg.rx.size = sizeof(resp);
+
+	bpmp = tegra_bpmp_get(pcie->dev);
+	if (IS_ERR(bpmp))
+		return PTR_ERR(bpmp);
+
+	if (irqs_disabled())
+		err = tegra_bpmp_transfer_atomic(bpmp, &msg);
+	else
+		err = tegra_bpmp_transfer(bpmp, &msg);
+
+	tegra_bpmp_put(bpmp);
+
+	return err;
+}
+
+static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
+					bool en_hw_hot_rst)
+{
+	int ret;
+	u32 val;
+
+	if (pcie->cid != CTRL_5) {
+		ret = tegra_pcie_bpmp_set_ctrl_state(pcie, true);
+		if (ret) {
+			dev_err(pcie->dev, "Enabling controller-%d failed:%d\n",
+				pcie->cid, ret);
+			return ret;
+		}
+	}
+
+	config_plat_gpio(pcie, 1);
+
+	ret = regulator_enable(pcie->pex_ctl_reg);
+	if (ret < 0) {
+		dev_err(pcie->dev, "regulator enable failed: %d\n", ret);
+		goto fail_reg_en;
+	}
+
+	ret = clk_prepare_enable(pcie->core_clk);
+	if (ret) {
+		dev_err(pcie->dev, "Failed to enable core clock\n");
+		goto fail_core_clk;
+	}
+
+	reset_control_deassert(pcie->core_apb_rst);
+
+	if (en_hw_hot_rst) {
+		/* Enable HW_HOT_RST mode */
+		val = readl(pcie->appl_base + APPL_CTRL);
+		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
+			  APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		val |= APPL_CTRL_HW_HOT_RST_EN;
+		writel(val, pcie->appl_base + APPL_CTRL);
+	}
+
+	ret = tegra_pcie_enable_phy(pcie);
+	if (ret) {
+		dev_err(pcie->dev, "failed to enable phy\n");
+		goto fail_phy;
+	}
+
+	/* update CFG base address */
+	writel(pcie->dbi_res->start & APPL_CFG_BASE_ADDR_MASK,
+	       pcie->appl_base + APPL_CFG_BASE_ADDR);
+
+	/* configure this core for RP mode operation */
+	writel(APPL_DM_TYPE_RP, pcie->appl_base + APPL_DM_TYPE);
+
+	writel(0x0, pcie->appl_base + APPL_CFG_SLCG_OVERRIDE);
+
+	val = readl(pcie->appl_base + APPL_CTRL);
+	writel(val | APPL_CTRL_SYS_PRE_DET_STATE, pcie->appl_base + APPL_CTRL);
+
+	val = readl(pcie->appl_base + APPL_CFG_MISC);
+	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
+	writel(val, pcie->appl_base + APPL_CFG_MISC);
+
+	if (pcie->disable_clock_request) {
+		val = readl(pcie->appl_base + APPL_PINMUX);
+		val |= APPL_PINMUX_CLKREQ_OUT_OVRD_EN;
+		val |= APPL_PINMUX_CLKREQ_OUT_OVRD;
+		writel(val, pcie->appl_base + APPL_PINMUX);
+
+		/* Disable ASPM-L1SS adv as there is no CLKREQ routing */
+		disable_aspm_l11(pcie); /* Disable L1.1 */
+		disable_aspm_l12(pcie); /* Disable L1.2 */
+	}
+
+	/* update iATU_DMA base address */
+	writel(pcie->atu_dma_res->start & APPL_CFG_IATU_DMA_BASE_ADDR_MASK,
+	       pcie->appl_base + APPL_CFG_IATU_DMA_BASE_ADDR);
+
+	reset_control_deassert(pcie->core_rst);
+
+	return ret;
+
+fail_phy:
+	reset_control_assert(pcie->core_apb_rst);
+	clk_disable_unprepare(pcie->core_clk);
+fail_core_clk:
+	regulator_disable(pcie->pex_ctl_reg);
+fail_reg_en:
+	config_plat_gpio(pcie, 0);
+	if (pcie->cid != CTRL_5)
+		tegra_pcie_bpmp_set_ctrl_state(pcie, false);
+
+	return ret;
+}
+
+static int tegra_pcie_dw_runtime_suspend(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+
+	tegra_pcie_downstream_dev_to_D0(pcie);
+
+	pci_stop_root_bus(pcie->pci.pp.bus);
+	pci_remove_root_bus(pcie->pci.pp.bus);
+
+	tegra_pcie_dw_pme_turnoff(pcie);
+
+	reset_control_assert(pcie->core_rst);
+	tegra_pcie_disable_phy(pcie);
+	reset_control_assert(pcie->core_apb_rst);
+	clk_disable_unprepare(pcie->core_clk);
+	regulator_disable(pcie->pex_ctl_reg);
+	config_plat_gpio(pcie, 0);
+
+	if (pcie->cid != CTRL_5)
+		tegra_pcie_bpmp_set_ctrl_state(pcie, false);
+
+	return 0;
+}
+
+static int tegra_pcie_dw_runtime_resume(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	int ret = 0;
+
+	ret = tegra_pcie_config_controller(pcie, false);
+	if (ret < 0)
+		return ret;
+
+	/* program to use MPS of 256 whereever possible */
+	pcie_bus_config = PCIE_BUS_SAFE;
+
+	pp->root_bus_nr = -1;
+	pp->ops = &tegra_pcie_dw_host_ops;
+
+	/* Disable MSI interrupts for PME messages */
+	pcie_pme_disable_msi();
+
+	ret = dw_pcie_host_init(pp);
+	if (ret < 0) {
+		dev_err(pcie->dev, "PCIE : Add PCIe port failed: %d\n", ret);
+		goto fail_host_init;
+	}
+
+	return 0;
+
+fail_host_init:
+	reset_control_assert(pcie->core_rst);
+	tegra_pcie_disable_phy(pcie);
+	reset_control_assert(pcie->core_apb_rst);
+	clk_disable_unprepare(pcie->core_clk);
+	regulator_disable(pcie->pex_ctl_reg);
+	config_plat_gpio(pcie, 0);
+	if (pcie->cid != CTRL_5)
+		tegra_pcie_bpmp_set_ctrl_state(pcie, false);
+
+	return ret;
+}
+
+static int tegra_pcie_dw_suspend_late(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	u32 val;
+
+	if (!pcie->link_state)
+		return 0;
+
+	/* Enable HW_HOT_RST mode */
+	val = readl(pcie->appl_base + APPL_CTRL);
+	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
+		  APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	val |= APPL_CTRL_HW_HOT_RST_EN;
+	writel(val, pcie->appl_base + APPL_CTRL);
+
+	return 0;
+}
+
+static int tegra_pcie_dw_suspend_noirq(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (!pcie->link_state)
+		return 0;
+
+	/* save MSI interrutp vector*/
+	pcie->msi_ctrl_int = dw_pcie_readl_dbi(&pcie->pci,
+					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
+	tegra_pcie_downstream_dev_to_D0(pcie);
+	tegra_pcie_dw_pme_turnoff(pcie);
+	reset_control_assert(pcie->core_rst);
+	tegra_pcie_disable_phy(pcie);
+	reset_control_assert(pcie->core_apb_rst);
+	clk_disable_unprepare(pcie->core_clk);
+	regulator_disable(pcie->pex_ctl_reg);
+	config_plat_gpio(pcie, 0);
+	if (pcie->cid != CTRL_5) {
+		ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
+		if (ret) {
+			dev_err(pcie->dev, "Disabling ctrl-%d failed:%d\n",
+				pcie->cid, ret);
+			return ret;
+		}
+	}
+	if (gpio_is_valid(pcie->pex_wake) && device_may_wakeup(dev)) {
+		ret = enable_irq_wake(gpio_to_irq(pcie->pex_wake));
+		if (ret < 0)
+			dev_err(dev, "enable wake irq failed: %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int tegra_pcie_dw_resume_noirq(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	if (!pcie->link_state)
+		return 0;
+
+	if (gpio_is_valid(pcie->pex_wake) && device_may_wakeup(dev)) {
+		ret = disable_irq_wake(gpio_to_irq(pcie->pex_wake));
+		if (ret < 0)
+			dev_err(dev, "disable wake irq failed: %d\n", ret);
+	}
+
+	ret = tegra_pcie_config_controller(pcie, true);
+	if (ret < 0)
+		return ret;
+
+	ret = tegra_pcie_dw_host_init(&pcie->pci.pp);
+	if (ret < 0) {
+		dev_err(dev, "failed to init host: %d\n", ret);
+		goto fail_host_init;
+	}
+
+	/* restore MSI interrutp vector*/
+	dw_pcie_writel_dbi(&pcie->pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
+			   pcie->msi_ctrl_int);
+
+	tegra_pcie_dw_scan_bus(&pcie->pci.pp);
+
+	return 0;
+fail_host_init:
+	reset_control_assert(pcie->core_rst);
+	tegra_pcie_disable_phy(pcie);
+	reset_control_assert(pcie->core_apb_rst);
+	clk_disable_unprepare(pcie->core_clk);
+	regulator_disable(pcie->pex_ctl_reg);
+	config_plat_gpio(pcie, 0);
+	if (pcie->cid != CTRL_5)
+		tegra_pcie_bpmp_set_ctrl_state(pcie, false);
+
+	return ret;
+}
+
+static int tegra_pcie_dw_resume_early(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	u32 val;
+
+	if (!pcie->link_state)
+		return 0;
+
+	/* Disable HW_HOT_RST mode */
+	val = readl(pcie->appl_base + APPL_CTRL);
+	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
+		  APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	val |= APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST <<
+		APPL_CTRL_HW_HOT_RST_MODE_SHIFT;
+	val &= ~APPL_CTRL_HW_HOT_RST_EN;
+	writel(val, pcie->appl_base + APPL_CTRL);
+
+	return 0;
+}
+
+static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
+{
+	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+
+	if (pcie->mode == DW_PCIE_RC_TYPE) {
+		if (!pcie->link_state && pcie->power_down_en)
+			return;
+
+		debugfs_remove_recursive(pcie->debugfs);
+		tegra_pcie_downstream_dev_to_D0(pcie);
+
+		/* Disable interrupts */
+		disable_irq(pcie->pci.pp.irq);
+		if (IS_ENABLED(CONFIG_PCI_MSI))
+			disable_irq(pcie->pci.pp.msi_irq);
+
+		tegra_pcie_dw_pme_turnoff(pcie);
+
+		reset_control_assert(pcie->core_rst);
+		tegra_pcie_disable_phy(pcie);
+		reset_control_assert(pcie->core_apb_rst);
+		clk_disable_unprepare(pcie->core_clk);
+		regulator_disable(pcie->pex_ctl_reg);
+		config_plat_gpio(pcie, 0);
+		if (pcie->cid != CTRL_5)
+			tegra_pcie_bpmp_set_ctrl_state(pcie, false);
+	}
+}
+
+static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
+	.suspend_late = tegra_pcie_dw_suspend_late,
+	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
+	.resume_noirq = tegra_pcie_dw_resume_noirq,
+	.resume_early = tegra_pcie_dw_resume_early,
+	.runtime_suspend = tegra_pcie_dw_runtime_suspend,
+	.runtime_resume = tegra_pcie_dw_runtime_resume,
+};
+
+static struct platform_driver tegra_pcie_dw_driver = {
+	.probe = tegra_pcie_dw_probe,
+	.remove = tegra_pcie_dw_remove,
+	.shutdown = tegra_pcie_dw_shutdown,
+	.driver = {
+		.name	= "pcie-tegra",
+#ifdef CONFIG_PM
+		.pm = &tegra_pcie_dw_pm_ops,
+#endif
+		.of_match_table = tegra_pcie_dw_of_match,
+	},
+};
+module_platform_driver(tegra_pcie_dw_driver);
+
+MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

