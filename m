Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BE0ECDE46
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCE621477
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 15:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCE621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJRXi6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:38:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37059 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbeJRXi6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Oct 2018 19:38:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 25DC420DE2; Thu, 18 Oct 2018 17:37:23 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id E5ECE20618;
        Thu, 18 Oct 2018 17:37:22 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@arm.linux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zachary Zhang <zhangzg@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 4/4] PCI: aardvark: Implement emulated root PCI bridge config space
Date:   Thu, 18 Oct 2018 17:37:19 +0200
Message-Id: <20181018153719.23115-5-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018153719.23115-1-thomas.petazzoni@bootlin.com>
References: <20181018153719.23115-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Zachary Zhang <zhangzg@marvell.com>

The PCI controller in the Marvell Armada 3720 does not implement a
software-accessible root port PCI bridge configuration space. This
causes a number of problems when using PCIe switches or when the Max
Payload size needs to be aligned between the root complex and the
endpoint.

Implementing an emulated root PCI bridge, like is already done in the
pci-mvebu driver for older Marvell platforms allows to solve those
issues, and also to support features such as ASR, PME, VC, HP.

Signed-off-by: Zachary Zhang <zhangzg@marvell.com>
[Thomas: convert to the common emulated PCI bridge logic.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/Kconfig        |   1 +
 drivers/pci/controller/pci-aardvark.c | 129 +++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 6d0f9930be7f..5d76ef51532d 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -16,6 +16,7 @@ config PCI_AARDVARK
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_BRIDGE_EMUL
 	help
 	 Add support for Aardvark 64bit PCIe Host Controller. This
 	 controller is part of the South Bridge of the Marvel Armada
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 6b4555ff2548..750081c1cb48 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -20,12 +20,16 @@
 #include <linux/of_pci.h>
 
 #include "../pci.h"
+#include "../pci-bridge-emul.h"
 
 /* PCIe core registers */
+#define PCIE_CORE_DEV_ID_REG					0x0
 #define PCIE_CORE_CMD_STATUS_REG				0x4
 #define     PCIE_CORE_CMD_IO_ACCESS_EN				BIT(0)
 #define     PCIE_CORE_CMD_MEM_ACCESS_EN				BIT(1)
 #define     PCIE_CORE_CMD_MEM_IO_REQ_EN				BIT(2)
+#define PCIE_CORE_DEV_REV_REG					0x8
+#define PCIE_CORE_PCIEXP_CAP					0xc0
 #define PCIE_CORE_DEV_CTRL_STATS_REG				0xc8
 #define     PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE	(0 << 4)
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT	5
@@ -41,7 +45,10 @@
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN			BIT(6)
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK			BIT(7)
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV			BIT(8)
-
+#define     PCIE_CORE_INT_A_ASSERT_ENABLE			1
+#define     PCIE_CORE_INT_B_ASSERT_ENABLE			2
+#define     PCIE_CORE_INT_C_ASSERT_ENABLE			3
+#define     PCIE_CORE_INT_D_ASSERT_ENABLE			4
 /* PIO registers base address and register offsets */
 #define PIO_BASE_ADDR				0x4000
 #define PIO_CTRL				(PIO_BASE_ADDR + 0x0)
@@ -93,7 +100,9 @@
 #define     PCIE_CORE_CTRL2_STRICT_ORDER_ENABLE	BIT(5)
 #define     PCIE_CORE_CTRL2_OB_WIN_ENABLE	BIT(6)
 #define     PCIE_CORE_CTRL2_MSI_ENABLE		BIT(10)
+#define PCIE_MSG_LOG_REG			(CONTROL_BASE_ADDR + 0x30)
 #define PCIE_ISR0_REG				(CONTROL_BASE_ADDR + 0x40)
+#define PCIE_MSG_PM_PME_MASK			BIT(7)
 #define PCIE_ISR0_MASK_REG			(CONTROL_BASE_ADDR + 0x44)
 #define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
 #define     PCIE_ISR0_INTX_ASSERT(val)		BIT(16 + (val))
@@ -189,6 +198,7 @@ struct advk_pcie {
 	struct mutex msi_used_lock;
 	u16 msi_msg;
 	int root_bus_nr;
+	struct pci_bridge_emul bridge;
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -390,6 +400,109 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+
+static pci_bridge_emul_read_status_t
+advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
+				    int reg, u32 *value)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+
+	switch (reg) {
+	case PCI_EXP_SLTCTL:
+		*value = PCI_EXP_SLTSTA_PDS << 16;
+		return PCI_BRIDGE_EMUL_HANDLED;
+
+	case PCI_EXP_RTCTL: {
+		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+		*value = (val & PCIE_MSG_PM_PME_MASK) ? PCI_EXP_RTCTL_PMEIE : 0;
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
+	case PCI_EXP_RTSTA: {
+		u32 isr0 = advk_readl(pcie, PCIE_ISR0_REG);
+		u32 msglog = advk_readl(pcie, PCIE_MSG_LOG_REG);
+		*value = (isr0 & PCIE_MSG_PM_PME_MASK) << 16 | (msglog >> 16);
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
+	case PCI_CAP_LIST_ID:
+	case PCI_EXP_DEVCAP:
+	case PCI_EXP_DEVCTL:
+	case PCI_EXP_LNKCAP:
+	case PCI_EXP_LNKCTL:
+		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
+		return PCI_BRIDGE_EMUL_HANDLED;
+	default:
+		return PCI_BRIDGE_EMUL_NOT_HANDLED;
+	}
+
+}
+
+static void
+advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
+				     int reg, u32 old, u32 new, u32 mask)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+	switch (reg) {
+	case PCI_EXP_DEVCTL:
+	case PCI_EXP_LNKCTL:
+		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
+		break;
+
+	case PCI_EXP_RTCTL:
+		new = (new & PCI_EXP_RTCTL_PMEIE) << 3;
+		advk_writel(pcie, new, PCIE_ISR0_MASK_REG);
+		break;
+
+	case PCI_EXP_RTSTA:
+		new = (new & PCI_EXP_RTSTA_PME) >> 9;
+		advk_writel(pcie, new, PCIE_ISR0_REG);
+		break;
+
+	default:
+		break;
+	}
+}
+
+struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
+	.read_pcie = advk_pci_bridge_emul_pcie_conf_read,
+	.write_pcie = advk_pci_bridge_emul_pcie_conf_write,
+};
+
+/*
+ * Initialize the configuration space of the PCI-to-PCI bridge
+ * associated with the given PCIe interface.
+ */
+static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
+{
+	struct pci_bridge_emul *bridge = &pcie->bridge;
+
+	bridge->conf.vendor = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff;
+	bridge->conf.device = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16;
+	bridge->conf.class_revision =
+		advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;
+
+	/* Support 32 bits I/O addressing */
+	bridge->conf.iobase = PCI_IO_RANGE_TYPE_32;
+	bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
+
+	/* Support 64 bits memory pref */
+	bridge->conf.pref_mem_base = PCI_PREF_RANGE_TYPE_64;
+	bridge->conf.pref_mem_limit = PCI_PREF_RANGE_TYPE_64;
+
+	/* Support interrupt A for MSI feature */
+	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
+
+	bridge->has_pcie = true;
+	bridge->data = pcie;
+	bridge->ops = &advk_pci_bridge_emul_ops;
+
+	pci_bridge_emul_init(bridge);
+
+}
+
 static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
 				  int devfn)
 {
@@ -411,6 +524,10 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
+	if (bus->number == pcie->root_bus_nr)
+		return pci_bridge_emul_conf_read(&pcie->bridge, where,
+						 size, val);
+
 	/* Start PIO */
 	advk_writel(pcie, 0, PIO_START);
 	advk_writel(pcie, 1, PIO_ISR);
@@ -418,7 +535,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
 	reg &= ~PIO_CTRL_TYPE_MASK;
-	if (bus->number ==  pcie->root_bus_nr)
+	if (bus->primary ==  pcie->root_bus_nr)
 		reg |= PCIE_CONFIG_RD_TYPE0;
 	else
 		reg |= PCIE_CONFIG_RD_TYPE1;
@@ -463,6 +580,10 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (!advk_pcie_valid_device(pcie, bus, devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	if (bus->number == pcie->root_bus_nr)
+		return pci_bridge_emul_conf_write(&pcie->bridge, where,
+						  size, val);
+
 	if (where % size)
 		return PCIBIOS_SET_FAILED;
 
@@ -473,7 +594,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
 	reg &= ~PIO_CTRL_TYPE_MASK;
-	if (bus->number == pcie->root_bus_nr)
+	if (bus->primary == pcie->root_bus_nr)
 		reg |= PCIE_CONFIG_WR_TYPE0;
 	else
 		reg |= PCIE_CONFIG_WR_TYPE1;
@@ -875,6 +996,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	advk_pcie_setup_hw(pcie);
 
+	advk_sw_pci_bridge_init(pcie);
+
 	ret = advk_pcie_init_irq_domain(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to initialize irq\n");
-- 
2.14.4

