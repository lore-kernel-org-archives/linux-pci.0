Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:33691 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753110AbaA3Kts (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 05:49:48 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <arnd@arndb.de>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	<spear-devel@list.st.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH V3 7/8] pcie: SPEAr13xx: Add designware pcie support
Date: Thu, 30 Jan 2014 16:18:49 +0530
Message-ID: <1c7f0dd04e9af55886dc74789bfcf92ce900e131.1391077731.git.mohit.kumar@st.com>
In-Reply-To: <cover.1391077731.git.mohit.kumar@st.com>
References: <cover.1391077731.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

SPEAr1310 and SPEAr1340 SOC uses designware PCIe controller. Add
SPEAr13xx PCIe driver based on designware controller driver.

SPEAr1310 has 3 PCIe ports and SPEAr1340 has 1, which are multiplexed
with ahci/sata pins. By default evaluation board of both controller
works for ahci mode.
To use these patches on SPEAr1340/1310 evaluation board, do the
necessary modifications on board and enable (okay) pcie and miphy
from respective evb dtsi file.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: linux-pci@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/pci/spear13xx-pcie.txt     |    7 +
 arch/arm/boot/dts/spear1310.dtsi                   |   51 +++
 arch/arm/boot/dts/spear1340.dtsi                   |   17 +
 arch/arm/boot/dts/spear13xx.dtsi                   |    5 +-
 arch/arm/configs/spear13xx_defconfig               |    2 +
 arch/arm/mach-spear/Kconfig                        |    1 +
 drivers/pci/host/Kconfig                           |    5 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-spear13xx.c                  |  407 ++++++++++++++++++++
 drivers/phy/phy-spear13xx-sata-pcie.c              |  176 +++++++++
 10 files changed, 670 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
 create mode 100644 drivers/pci/host/pcie-spear13xx.c

diff --git a/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt b/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
new file mode 100644
index 0000000..dc8ae44
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
@@ -0,0 +1,7 @@
+Required properties:
+- compatible : should be "st,spear1340-pcie", "snps,dw-pcie".
+- pcie_is_gen1: pass <1> if forced gen1 initialization is needed to work with
+  some buggy cards else pass <0>.
+- phys		    : phandle to phy node associated with pcie controller
+- phy-names	    : must be "pcie-phy"
+- All other definitions as per generic PCI bindings
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 0d62418..5a9bc58 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -80,6 +80,57 @@
 			status = "disabled";
 		};
 
+		pcie0: pcie@b1000000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb1000000 0x4000>;
+			interrupts = <0 68 0x4>;
+			pcie_is_gen1 = <0>;
+			num-lanes = <1>;
+			phys = <&miphy0 1 0>;
+			phy-names = "pcie-phy";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
+		pcie1: pcie@b1800000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb1800000 0x4000>;
+			interrupts = <0 69 0x4>;
+			pcie_is_gen1 = <0>;
+			num-lanes = <1>;
+			phys = <&miphy1 1 1>;
+			phy-names = "pcie-phy";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x90000000 0x90000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0  0x90020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x90030000 0x90030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
+		pcie2: pcie@b4000000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb4000000 0x4000>;
+			interrupts = <0 70 0x4>;
+			pcie_is_gen1 = <0>;
+			num-lanes = <1>;
+			phys = <&miphy2 1 2>;
+			phy-names = "pcie-phy";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0xc0000000 0xc0000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0xc0020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0xc0030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
 		gmac1: eth@5c400000 {
 			compatible = "st,spear600-gmac";
 			reg = <0x5c400000 0x8000>;
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index c6b0e34..32fb001 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -48,6 +48,23 @@
 			status = "disabled";
 		};
 
+		pcie0: pcie@b1000000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb1000000 0x4000>;
+			interrupts = <0 68 0x4>;
+			pcie_is_gen1 = <0>;
+			num-lanes = <1>;
+			phys = <&miphy0 1 0>;
+			phy-names = "pcie-phy";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
 		i2s-play@b2400000 {
 			compatible = "snps,designware-i2s";
 			reg = <0xb2400000 0x10000>;
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 3a72508..ec7feaf 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -83,8 +83,8 @@
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		ranges = <0x50000000 0x50000000 0x10000000
-			  0xb0000000 0xb0000000 0x10000000
-			  0xd0000000 0xd0000000 0x02000000
+			  0x80000000 0x80000000 0x20000000
+			  0xb0000000 0xb0000000 0x22000000
 			  0xd8000000 0xd8000000 0x01000000
 			  0xe0000000 0xe0000000 0x10000000>;
 
@@ -338,6 +338,7 @@
 				reg = <0xe07008c4 0x4>;
 				thermal_flags = <0x7000>;
 			};
+
 		};
 	};
 };
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 0cf87d0..41cfb4f 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -11,6 +11,8 @@ CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
 # CONFIG_SWP_EMULATE is not set
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_SPEAR13XX=y
 CONFIG_SMP=y
 # CONFIG_SMP_ON_UP is not set
 # CONFIG_ARM_CPU_TOPOLOGY is not set
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index 44d8543..6dddca7 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -28,6 +28,7 @@ config ARCH_SPEAR13XX
 	select USE_OF
 	select MFD_SYSCON
 	select PHY_SPEAR13XX_SATA_PCIE
+	select PCI
 	help
 	  Supports for ARM's SPEAR13XX family
 
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 47d46c6..df52fad 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -33,4 +33,9 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
+config PCIE_SPEAR13XX
+	bool "STMicroelectronics SPEAr PCIe controller"
+	depends on ARCH_SPEAR13XX
+	select PCIEPORTBUS
+	select PCIE_DW
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 13fb333..42a491d 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
+obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
new file mode 100644
index 0000000..f2bcf0b
--- /dev/null
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -0,0 +1,407 @@
+/*
+ * PCIe host controller driver for ST Microelectronics SPEAr13xx SoCs
+ *
+ * SPEAr13xx PCIe Glue Layer Source Code
+ *
+ * Copyright (C) 2010-2014 ST Microelectronics
+ * Pratyush Anand <pratyush.anand@st.com>
+ *
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+
+#include "pcie-designware.h"
+
+struct spear13xx_pcie {
+	void __iomem		*app_base;
+	struct phy		*phy;
+	struct clk		*clk;
+	struct pcie_port	pp;
+	int			is_gen1;
+};
+
+struct pcie_app_reg {
+	u32	app_ctrl_0;		/*cr0*/
+	u32	app_ctrl_1;		/*cr1*/
+	u32	app_status_0;		/*cr2*/
+	u32	app_status_1;		/*cr3*/
+	u32	msg_status;		/*cr4*/
+	u32	msg_payload;		/*cr5*/
+	u32	int_sts;		/*cr6*/
+	u32	int_clr;		/*cr7*/
+	u32	int_mask;		/*cr8*/
+	u32	mst_bmisc;		/*cr9*/
+	u32	phy_ctrl;		/*cr10*/
+	u32	phy_status;		/*cr11*/
+	u32	cxpl_debug_info_0;	/*cr12*/
+	u32	cxpl_debug_info_1;	/*cr13*/
+	u32	ven_msg_ctrl_0;		/*cr14*/
+	u32	ven_msg_ctrl_1;		/*cr15*/
+	u32	ven_msg_data_0;		/*cr16*/
+	u32	ven_msg_data_1;		/*cr17*/
+	u32	ven_msi_0;		/*cr18*/
+	u32	ven_msi_1;		/*cr19*/
+	u32	mst_rmisc;		/*cr 20*/
+};
+
+/*CR0 ID*/
+#define RX_LANE_FLIP_EN_ID			0
+#define TX_LANE_FLIP_EN_ID			1
+#define SYS_AUX_PWR_DET_ID			2
+#define APP_LTSSM_ENABLE_ID			3
+#define SYS_ATTEN_BUTTON_PRESSED_ID		4
+#define SYS_MRL_SENSOR_STATE_ID			5
+#define SYS_PWR_FAULT_DET_ID			6
+#define SYS_MRL_SENSOR_CHGED_ID			7
+#define SYS_PRE_DET_CHGED_ID			8
+#define SYS_CMD_CPLED_INT_ID			9
+#define APP_INIT_RST_0_ID			11
+#define APP_REQ_ENTR_L1_ID			12
+#define APP_READY_ENTR_L23_ID			13
+#define APP_REQ_EXIT_L1_ID			14
+#define DEVICE_TYPE_EP				(0 << 25)
+#define DEVICE_TYPE_LEP				(1 << 25)
+#define DEVICE_TYPE_RC				(4 << 25)
+#define SYS_INT_ID				29
+#define MISCTRL_EN_ID				30
+#define REG_TRANSLATION_ENABLE			31
+
+/*CR1 ID*/
+#define APPS_PM_XMT_TURNOFF_ID			2
+#define APPS_PM_XMT_PME_ID			5
+
+/*CR3 ID*/
+#define XMLH_LTSSM_STATE_DETECT_QUIET		0x00
+#define XMLH_LTSSM_STATE_DETECT_ACT		0x01
+#define XMLH_LTSSM_STATE_POLL_ACTIVE		0x02
+#define XMLH_LTSSM_STATE_POLL_COMPLIANCE	0x03
+#define XMLH_LTSSM_STATE_POLL_CONFIG		0x04
+#define XMLH_LTSSM_STATE_PRE_DETECT_QUIET	0x05
+#define XMLH_LTSSM_STATE_DETECT_WAIT		0x06
+#define XMLH_LTSSM_STATE_CFG_LINKWD_START	0x07
+#define XMLH_LTSSM_STATE_CFG_LINKWD_ACEPT	0x08
+#define XMLH_LTSSM_STATE_CFG_LANENUM_WAIT	0x09
+#define XMLH_LTSSM_STATE_CFG_LANENUM_ACEPT	0x0A
+#define XMLH_LTSSM_STATE_CFG_COMPLETE		0x0B
+#define XMLH_LTSSM_STATE_CFG_IDLE		0x0C
+#define XMLH_LTSSM_STATE_RCVRY_LOCK		0x0D
+#define XMLH_LTSSM_STATE_RCVRY_SPEED		0x0E
+#define XMLH_LTSSM_STATE_RCVRY_RCVRCFG		0x0F
+#define XMLH_LTSSM_STATE_RCVRY_IDLE		0x10
+#define XMLH_LTSSM_STATE_L0			0x11
+#define XMLH_LTSSM_STATE_L0S			0x12
+#define XMLH_LTSSM_STATE_L123_SEND_EIDLE	0x13
+#define XMLH_LTSSM_STATE_L1_IDLE		0x14
+#define XMLH_LTSSM_STATE_L2_IDLE		0x15
+#define XMLH_LTSSM_STATE_L2_WAKE		0x16
+#define XMLH_LTSSM_STATE_DISABLED_ENTRY		0x17
+#define XMLH_LTSSM_STATE_DISABLED_IDLE		0x18
+#define XMLH_LTSSM_STATE_DISABLED		0x19
+#define XMLH_LTSSM_STATE_LPBK_ENTRY		0x1A
+#define XMLH_LTSSM_STATE_LPBK_ACTIVE		0x1B
+#define XMLH_LTSSM_STATE_LPBK_EXIT		0x1C
+#define XMLH_LTSSM_STATE_LPBK_EXIT_TIMEOUT	0x1D
+#define XMLH_LTSSM_STATE_HOT_RESET_ENTRY	0x1E
+#define XMLH_LTSSM_STATE_HOT_RESET		0x1F
+#define XMLH_LTSSM_STATE_MASK			0x3F
+#define XMLH_LINK_UP				(1 << 6)
+
+/*CR4 ID*/
+#define CFG_MSI_EN_ID				18
+
+/*CR6*/
+#define INTA_CTRL_INT				(1 << 7)
+#define INTB_CTRL_INT				(1 << 8)
+#define INTC_CTRL_INT				(1 << 9)
+#define INTD_CTRL_INT				(1 << 10)
+#define MSI_CTRL_INT				(1 << 26)
+
+/*CR19 ID*/
+#define VEN_MSI_REQ_ID				11
+#define VEN_MSI_FUN_NUM_ID			8
+#define VEN_MSI_TC_ID				5
+#define VEN_MSI_VECTOR_ID			0
+#define VEN_MSI_REQ_EN		((u32)0x1 << VEN_MSI_REQ_ID)
+#define VEN_MSI_FUN_NUM_MASK	((u32)0x7 << VEN_MSI_FUN_NUM_ID)
+#define VEN_MSI_TC_MASK		((u32)0x7 << VEN_MSI_TC_ID)
+#define VEN_MSI_VECTOR_MASK	((u32)0x1F << VEN_MSI_VECTOR_ID)
+
+#define PCI_CAP_ID_EXP_OFFSET			0x70
+
+#define to_spear13xx_pcie(x)	container_of(x, struct spear13xx_pcie, pp)
+
+static int spear13xx_pcie_establish_link(struct pcie_port *pp)
+{
+	u32 val;
+	int count = 0;
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	u32 exp_cap_off = PCI_CAP_ID_EXP_OFFSET;
+
+	if (dw_pcie_link_up(pp)) {
+		dev_err(pp->dev, "Link already up\n");
+		return 0;
+	}
+
+	/* setup root complex */
+	dw_pcie_setup_rc(pp);
+
+	/*
+	 * this controller support only 128 bytes read size, however its
+	 * default value in capability register is 512 bytes. So force
+	 * it to 128 here.
+	 */
+	dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, &val);
+	val &= ~PCI_EXP_DEVCTL_READRQ;
+	dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, val);
+
+	/* program vid and did for RC */
+	dw_pcie_cfg_write(pp->dbi_base, PCI_VENDOR_ID, 2, 0x104A);
+	dw_pcie_cfg_write(pp->dbi_base, PCI_DEVICE_ID, 2, 0xCD80);
+
+	/*
+	 * if is_gen1 is set then handle it, so that some buggy card
+	 * also works
+	 */
+	if (spear13xx_pcie->is_gen1) {
+		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCAP, 4,
+				&val);
+		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
+			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
+			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
+					PCI_EXP_LNKCAP, 4, val);
+		}
+
+		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCTL2, 4,
+				&val);
+		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
+			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
+			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
+					PCI_EXP_LNKCTL2, 4, val);
+		}
+	}
+
+	/* enable ltssm */
+	writel(DEVICE_TYPE_RC | (1 << MISCTRL_EN_ID)
+			| (1 << APP_LTSSM_ENABLE_ID)
+			| ((u32)1 << REG_TRANSLATION_ENABLE),
+			&app_reg->app_ctrl_0);
+
+	/* check if the link is up or not */
+	while (!dw_pcie_link_up(pp)) {
+		mdelay(100);
+		count++;
+		if (count == 10) {
+			dev_err(pp->dev, "Link Fail\n");
+			return -EINVAL;
+		}
+	}
+	dev_info(pp->dev, "Link up\n");
+
+	return 0;
+}
+
+static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	unsigned int status;
+
+	status = readl(&app_reg->int_sts);
+
+	if (status & MSI_CTRL_INT) {
+		if (!IS_ENABLED(CONFIG_PCI_MSI))
+			BUG();
+		dw_handle_msi_irq(pp);
+	}
+
+	writel(status, &app_reg->int_clr);
+
+	return IRQ_HANDLED;
+}
+
+static void spear13xx_pcie_enable_interrupts(struct pcie_port *pp)
+{
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+
+	/* Enable MSI interrupt */
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		dw_pcie_msi_init(pp);
+		writel(readl(&app_reg->int_mask) |
+				MSI_CTRL_INT, &app_reg->int_mask);
+	}
+
+	return;
+}
+
+static int spear13xx_pcie_link_up(struct pcie_port *pp)
+{
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+
+	if (readl(&app_reg->app_status_1) & XMLH_LINK_UP)
+		return 1;
+
+	return 0;
+}
+
+static void spear13xx_pcie_host_init(struct pcie_port *pp)
+{
+	spear13xx_pcie_establish_link(pp);
+	spear13xx_pcie_enable_interrupts(pp);
+}
+
+static struct pcie_host_ops spear13xx_pcie_host_ops = {
+	.link_up = spear13xx_pcie_link_up,
+	.host_init = spear13xx_pcie_host_init,
+};
+
+static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pp->irq = platform_get_irq(pdev, 0);
+	if (!pp->irq) {
+		dev_err(dev, "failed to get irq\n");
+		return -ENODEV;
+	}
+	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
+				IRQF_SHARED, "spear1340-pcie", pp);
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		return ret;
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &spear13xx_pcie_host_ops;
+
+	spin_lock_init(&pp->conf_lock);
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init spear13xx_pcie_probe(struct platform_device *pdev)
+{
+	struct spear13xx_pcie *spear13xx_pcie;
+	struct pcie_port *pp;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *dbi_base;
+	int ret;
+
+	spear13xx_pcie = devm_kzalloc(dev, sizeof(*spear13xx_pcie),
+				GFP_KERNEL);
+	if (!spear13xx_pcie) {
+		dev_err(dev, "no memory for SPEAr13xx pcie\n");
+		return -ENOMEM;
+	}
+
+	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
+	if (IS_ERR(spear13xx_pcie->phy)) {
+		dev_err(dev, "Could not get PHY\n");
+		return -EPROBE_DEFER;
+	}
+
+	phy_init(spear13xx_pcie->phy);
+
+	spear13xx_pcie->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(spear13xx_pcie->clk)) {
+		dev_err(dev, "couldn't get clk for pcie\n");
+		return PTR_ERR(spear13xx_pcie->clk);
+	}
+	ret = clk_prepare_enable(spear13xx_pcie->clk);
+	if (ret) {
+		dev_err(dev, "couldn't enable clk for pcie\n");
+		return ret;
+	}
+
+	pp = &spear13xx_pcie->pp;
+
+	pp->dev = dev;
+
+	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	if (IS_ERR(pp->dbi_base)) {
+		dev_err(dev, "couldn't remap dbi base\n");
+		ret = PTR_ERR(pp->dbi_base);
+		goto fail_clk;
+	}
+	spear13xx_pcie->app_base = pp->dbi_base + 0x2000;
+
+	of_property_read_u32(np, "pcie_is_gen1", &spear13xx_pcie->is_gen1);
+
+	ret = add_pcie_port(pp, pdev);
+	if (ret < 0)
+		goto fail_clk;
+
+	platform_set_drvdata(pdev, spear13xx_pcie);
+	return 0;
+
+fail_clk:
+	clk_disable_unprepare(spear13xx_pcie->clk);
+
+	return ret;
+}
+
+static int __exit spear13xx_pcie_remove(struct platform_device *pdev)
+{
+	struct spear13xx_pcie *spear13xx_pcie = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(spear13xx_pcie->clk);
+
+	phy_exit(spear13xx_pcie->phy);
+
+	return 0;
+}
+
+static const struct of_device_id spear13xx_pcie_of_match[] = {
+	{ .compatible = "st,spear1340-pcie", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
+
+static struct platform_driver spear13xx_pcie_driver = {
+	.remove		= __exit_p(spear13xx_pcie_remove),
+	.driver = {
+		.name	= "spear-pcie",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
+	},
+};
+
+/* SPEAr13xx PCIe driver does not allow module unload */
+
+static int __init pcie_init(void)
+{
+
+	return platform_driver_probe(&spear13xx_pcie_driver,
+				spear13xx_pcie_probe);
+}
+subsys_initcall(pcie_init);
+
+MODULE_DESCRIPTION("ST Microelectronics SPEAr13xx PCIe host controller driver");
+MODULE_AUTHOR("Pratyush Anand <pratyush.anand@st.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/phy-spear13xx-sata-pcie.c b/drivers/phy/phy-spear13xx-sata-pcie.c
index 6adfa64..5eabf51 100644
--- a/drivers/phy/phy-spear13xx-sata-pcie.c
+++ b/drivers/phy/phy-spear13xx-sata-pcie.c
@@ -71,6 +71,80 @@
 	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
 			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
 			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
+/* SPEAr1310 Registers */
+#define SPEAR1310_PCIE_SATA_CFG			0x3A4
+	#define SPEAR1310_PCIE_SATA2_SEL_PCIE		(0 << 31)
+	#define SPEAR1310_PCIE_SATA1_SEL_PCIE		(0 << 30)
+	#define SPEAR1310_PCIE_SATA0_SEL_PCIE		(0 << 29)
+	#define SPEAR1310_PCIE_SATA2_SEL_SATA		(1 << 31)
+	#define SPEAR1310_PCIE_SATA1_SEL_SATA		(1 << 30)
+	#define SPEAR1310_PCIE_SATA0_SEL_SATA		(1 << 29)
+	#define SPEAR1310_SATA2_CFG_TX_CLK_EN		(1 << 27)
+	#define SPEAR1310_SATA2_CFG_RX_CLK_EN		(1 << 26)
+	#define SPEAR1310_SATA2_CFG_POWERUP_RESET	(1 << 25)
+	#define SPEAR1310_SATA2_CFG_PM_CLK_EN		(1 << 24)
+	#define SPEAR1310_SATA1_CFG_TX_CLK_EN		(1 << 23)
+	#define SPEAR1310_SATA1_CFG_RX_CLK_EN		(1 << 22)
+	#define SPEAR1310_SATA1_CFG_POWERUP_RESET	(1 << 21)
+	#define SPEAR1310_SATA1_CFG_PM_CLK_EN		(1 << 20)
+	#define SPEAR1310_SATA0_CFG_TX_CLK_EN		(1 << 19)
+	#define SPEAR1310_SATA0_CFG_RX_CLK_EN		(1 << 18)
+	#define SPEAR1310_SATA0_CFG_POWERUP_RESET	(1 << 17)
+	#define SPEAR1310_SATA0_CFG_PM_CLK_EN		(1 << 16)
+	#define SPEAR1310_PCIE2_CFG_DEVICE_PRESENT	(1 << 11)
+	#define SPEAR1310_PCIE2_CFG_POWERUP_RESET	(1 << 10)
+	#define SPEAR1310_PCIE2_CFG_CORE_CLK_EN		(1 << 9)
+	#define SPEAR1310_PCIE2_CFG_AUX_CLK_EN		(1 << 8)
+	#define SPEAR1310_PCIE1_CFG_DEVICE_PRESENT	(1 << 7)
+	#define SPEAR1310_PCIE1_CFG_POWERUP_RESET	(1 << 6)
+	#define SPEAR1310_PCIE1_CFG_CORE_CLK_EN		(1 << 5)
+	#define SPEAR1310_PCIE1_CFG_AUX_CLK_EN		(1 << 4)
+	#define SPEAR1310_PCIE0_CFG_DEVICE_PRESENT	(1 << 3)
+	#define SPEAR1310_PCIE0_CFG_POWERUP_RESET	(1 << 2)
+	#define SPEAR1310_PCIE0_CFG_CORE_CLK_EN		(1 << 1)
+	#define SPEAR1310_PCIE0_CFG_AUX_CLK_EN		(1 << 0)
+
+	#define SPEAR1310_PCIE_CFG_MASK(x) ((0xF << (x * 4)) | (1 << (x + 29)))
+	#define SPEAR1310_SATA_CFG_MASK(x) ((0xF << (x * 4 + 16)) | \
+			(1 << (x + 29)))
+	#define SPEAR1310_PCIE_CFG_VAL(x) \
+			(SPEAR1310_PCIE_SATA##x##_SEL_PCIE | \
+			SPEAR1310_PCIE##x##_CFG_AUX_CLK_EN | \
+			SPEAR1310_PCIE##x##_CFG_CORE_CLK_EN | \
+			SPEAR1310_PCIE##x##_CFG_POWERUP_RESET | \
+			SPEAR1310_PCIE##x##_CFG_DEVICE_PRESENT)
+	#define SPEAR1310_SATA_CFG_VAL(x) \
+			(SPEAR1310_PCIE_SATA##x##_SEL_SATA | \
+			SPEAR1310_SATA##x##_CFG_PM_CLK_EN | \
+			SPEAR1310_SATA##x##_CFG_POWERUP_RESET | \
+			SPEAR1310_SATA##x##_CFG_RX_CLK_EN | \
+			SPEAR1310_SATA##x##_CFG_TX_CLK_EN)
+
+#define SPEAR1310_PCIE_MIPHY_CFG_1		0x3A8
+	#define SPEAR1310_MIPHY_DUAL_OSC_BYPASS_EXT	(1 << 31)
+	#define SPEAR1310_MIPHY_DUAL_CLK_REF_DIV2	(1 << 28)
+	#define SPEAR1310_MIPHY_DUAL_PLL_RATIO_TOP(x)	(x << 16)
+	#define SPEAR1310_MIPHY_SINGLE_OSC_BYPASS_EXT	(1 << 15)
+	#define SPEAR1310_MIPHY_SINGLE_CLK_REF_DIV2	(1 << 12)
+	#define SPEAR1310_MIPHY_SINGLE_PLL_RATIO_TOP(x)	(x << 0)
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_SATA_MASK (0xFFFF)
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK (0xFFFF << 16)
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_SATA \
+			(SPEAR1310_MIPHY_DUAL_OSC_BYPASS_EXT | \
+			SPEAR1310_MIPHY_DUAL_CLK_REF_DIV2 | \
+			SPEAR1310_MIPHY_DUAL_PLL_RATIO_TOP(60) | \
+			SPEAR1310_MIPHY_SINGLE_OSC_BYPASS_EXT | \
+			SPEAR1310_MIPHY_SINGLE_CLK_REF_DIV2 | \
+			SPEAR1310_MIPHY_SINGLE_PLL_RATIO_TOP(60))
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK \
+			(SPEAR1310_MIPHY_SINGLE_PLL_RATIO_TOP(120))
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE \
+			(SPEAR1310_MIPHY_DUAL_OSC_BYPASS_EXT | \
+			SPEAR1310_MIPHY_DUAL_PLL_RATIO_TOP(25) | \
+			SPEAR1310_MIPHY_SINGLE_OSC_BYPASS_EXT | \
+			SPEAR1310_MIPHY_SINGLE_PLL_RATIO_TOP(25))
+
+#define SPEAR1310_PCIE_MIPHY_CFG_2		0x3AC
 
 enum phy_mode {
 	SATA,
@@ -154,6 +228,104 @@ static int sata_miphy_resume(struct spear13xx_phy_priv *phypriv)
 	return sata_miphy_init(phypriv);
 }
 
+static int spear1340_pcie_miphy_init(struct spear13xx_phy_priv *phypriv)
+{
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			SPEAR1340_PCIE_MIPHY_CFG_MASK,
+			SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE);
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_SATA_CFG,
+			SPEAR1340_PCIE_SATA_CFG_MASK, SPEAR1340_PCIE_CFG_VAL);
+
+	return 0;
+}
+
+static int spear1340_pcie_miphy_exit(struct spear13xx_phy_priv *phypriv)
+{
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);
+	regmap_update_bits(phypriv->misc, SPEAR1340_PCIE_SATA_CFG,
+			SPEAR1340_PCIE_SATA_CFG_MASK, 0);
+
+	return 0;
+}
+
+static int spear1310_pcie_miphy_init(struct spear13xx_phy_priv *phypriv)
+{
+	u32 mask, val;
+
+	regmap_update_bits(phypriv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
+			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK,
+			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE);
+
+	switch (phypriv->id) {
+	case 0:
+		mask = SPEAR1310_PCIE_CFG_MASK(0);
+		val = SPEAR1310_PCIE_CFG_VAL(0);
+		break;
+	case 1:
+		mask = SPEAR1310_PCIE_CFG_MASK(1);
+		val = SPEAR1310_PCIE_CFG_VAL(1);
+		break;
+	case 2:
+		mask = SPEAR1310_PCIE_CFG_MASK(2);
+		val = SPEAR1310_PCIE_CFG_VAL(2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(phypriv->misc, SPEAR1310_PCIE_SATA_CFG, mask, val);
+
+	return 0;
+}
+
+static int spear1310_pcie_miphy_exit(struct spear13xx_phy_priv *phypriv)
+{
+	u32 mask;
+
+	switch (phypriv->id) {
+	case 0:
+		mask = SPEAR1310_PCIE_CFG_MASK(0);
+		break;
+	case 1:
+		mask = SPEAR1310_PCIE_CFG_MASK(1);
+		break;
+	case 2:
+		mask = SPEAR1310_PCIE_CFG_MASK(2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(phypriv->misc, SPEAR1310_PCIE_SATA_CFG,
+			SPEAR1310_PCIE_CFG_MASK(phypriv->id), 0);
+
+	regmap_update_bits(phypriv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
+			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK, 0);
+
+	return 0;
+}
+
+static int pcie_miphy_init(struct spear13xx_phy_priv *phypriv)
+{
+	if (of_machine_is_compatible("st,spear1340"))
+		return spear1340_pcie_miphy_init(phypriv);
+	else if (of_machine_is_compatible("st,spear1310"))
+		return spear1310_pcie_miphy_init(phypriv);
+	else
+		return -EINVAL;
+}
+
+static int pcie_miphy_exit(struct spear13xx_phy_priv *phypriv)
+{
+	if (of_machine_is_compatible("st,spear1340"))
+		return spear1340_pcie_miphy_exit(phypriv);
+	else if (of_machine_is_compatible("st,spear1310"))
+		return spear1310_pcie_miphy_exit(phypriv);
+	else
+		return -EINVAL;
+}
+
 static int miphy_init(struct phy *phy)
 {
 	struct spear13xx_phy_priv *phypriv = phy_get_drvdata(phy);
@@ -161,6 +333,8 @@ static int miphy_init(struct phy *phy)
 	switch (phypriv->mode) {
 	case SATA:
 		return sata_miphy_init(phypriv);
+	case PCIE:
+		return pcie_miphy_init(phypriv);
 	default:
 		return -EINVAL;
 	}
@@ -173,6 +347,8 @@ static int miphy_exit(struct phy *phy)
 	switch (phypriv->mode) {
 	case SATA:
 		return sata_miphy_exit(phypriv);
+	case PCIE:
+		return pcie_miphy_exit(phypriv);
 	default:
 		return -EINVAL;
 	}
-- 
1.7.0.1

