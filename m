Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FABECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A29D206B7
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LTkQUKCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A29D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeIUQM7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51450 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390105AbeIUQM6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:58 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAMqtL033026;
        Fri, 21 Sep 2018 05:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525372;
        bh=Z+MFySZyPRhvCA1QI7nKFOZmPGi/x8HAq8zzjQbKEVk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LTkQUKCOlagYUO0TbDd/8oJIqhCEMMNILOSnKMNyymUCzPUuyqaHt9vLy54a1/DSy
         vLp9NKWLoesgXIfbkij005h7LCCN5AU9Y0mm7JgVsQCme/XfM9hIKFoYpkyRRtoilJ
         8e3y9Pgk4MpxNHMpJWqIjxhxJOMtFyJWLqzHPJoo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMq79017745;
        Fri, 21 Sep 2018 05:22:52 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:22:51 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:22:51 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtB032280;
        Fri, 21 Sep 2018 05:22:47 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <Gustavo.Pimentel@synopsys.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 07/40] PCI: keystone: Merge pci-keystone-dw.c and pci-keystone.c
Date:   Fri, 21 Sep 2018 15:51:22 +0530
Message-ID: <20180921102155.22839-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No functional change. Having two different files for keystone PCI driver
doesn't serve any purpose. Merge pci-keystone-dw.c and pci-keystone.c
into a single pci-keystone.c file and remove pci-keystone.h

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
The "CHECK:" warnings here by checkpatch.pl will be fixed in the later
part of the series.
 MAINTAINERS                                  |   2 +-
 drivers/pci/controller/dwc/Makefile          |   2 +-
 drivers/pci/controller/dwc/pci-keystone-dw.c | 488 ------------------
 drivers/pci/controller/dwc/pci-keystone.c    | 493 ++++++++++++++++++-
 drivers/pci/controller/dwc/pci-keystone.h    |  57 ---
 5 files changed, 494 insertions(+), 548 deletions(-)
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone-dw.c
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..3101b2fa3449 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11172,7 +11172,7 @@ M:	Murali Karicheri <m-karicheri2@ti.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/pci/controller/dwc/*keystone*
+F:	drivers/pci/controller/dwc/pci-keystone.c
 
 PCI ENDPOINT SUBSYSTEM
 M:	Kishon Vijay Abraham I <kishon@ti.com>
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 5d2ce72c7a52..fcf91eacfc63 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
-obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
+obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
diff --git a/drivers/pci/controller/dwc/pci-keystone-dw.c b/drivers/pci/controller/dwc/pci-keystone-dw.c
deleted file mode 100644
index ce399232cd99..000000000000
--- a/drivers/pci/controller/dwc/pci-keystone-dw.c
+++ /dev/null
@@ -1,488 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DesignWare application register space functions for Keystone PCI controller
- *
- * Copyright (C) 2013-2014 Texas Instruments., Ltd.
- *		http://www.ti.com
- *
- * Author: Murali Karicheri <m-karicheri2@ti.com>
- */
-
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/irqreturn.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_pci.h>
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-
-#include "pcie-designware.h"
-#include "pci-keystone.h"
-
-/* Application register defines */
-#define LTSSM_EN_VAL		        BIT(0)
-#define LTSSM_STATE_MASK		0x1f
-#define LTSSM_STATE_L0			0x11
-#define DBI_CS2_EN_VAL			0x20
-#define OB_XLAT_EN_VAL		        2
-
-/* Application registers */
-#define CMD_STATUS			0x004
-#define CFG_SETUP			0x008
-#define OB_SIZE				0x030
-#define CFG_PCIM_WIN_SZ_IDX		3
-#define CFG_PCIM_WIN_CNT		32
-#define SPACE0_REMOTE_CFG_OFFSET	0x1000
-#define OB_OFFSET_INDEX(n)		(0x200 + (8 * n))
-#define OB_OFFSET_HI(n)			(0x204 + (8 * n))
-
-/* IRQ register defines */
-#define IRQ_EOI				0x050
-#define IRQ_STATUS			0x184
-#define IRQ_ENABLE_SET			0x188
-#define IRQ_ENABLE_CLR			0x18c
-
-#define MSI_IRQ				0x054
-#define MSI0_IRQ_STATUS			0x104
-#define MSI0_IRQ_ENABLE_SET		0x108
-#define MSI0_IRQ_ENABLE_CLR		0x10c
-#define IRQ_STATUS			0x184
-#define MSI_IRQ_OFFSET			4
-
-/* Error IRQ bits */
-#define ERR_AER		BIT(5)	/* ECRC error */
-#define ERR_AXI		BIT(4)	/* AXI tag lookup fatal error */
-#define ERR_CORR	BIT(3)	/* Correctable error */
-#define ERR_NONFATAL	BIT(2)	/* Non-fatal error */
-#define ERR_FATAL	BIT(1)	/* Fatal error */
-#define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
-#define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
-			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
-#define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
-#define ERR_IRQ_STATUS_RAW		0x1c0
-#define ERR_IRQ_STATUS			0x1c4
-#define ERR_IRQ_ENABLE_SET		0x1c8
-#define ERR_IRQ_ENABLE_CLR		0x1cc
-
-/* Config space registers */
-#define DEBUG0				0x728
-
-#define to_keystone_pcie(x)	dev_get_drvdata((x)->dev)
-
-static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
-					     u32 *bit_pos)
-{
-	*reg_offset = offset % 8;
-	*bit_pos = offset >> 3;
-}
-
-phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	return ks_pcie->app.start + MSI_IRQ;
-}
-
-static u32 ks_dw_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
-{
-	return readl(ks_pcie->va_app_base + offset);
-}
-
-static void ks_dw_app_writel(struct keystone_pcie *ks_pcie, u32 offset, u32 val)
-{
-	writel(val, ks_pcie->va_app_base + offset);
-}
-
-void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	u32 pending, vector;
-	int src, virq;
-
-	pending = ks_dw_app_readl(ks_pcie, MSI0_IRQ_STATUS + (offset << 4));
-
-	/*
-	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
-	 * shows 1, 9, 17, 25 and so forth
-	 */
-	for (src = 0; src < 4; src++) {
-		if (BIT(src) & pending) {
-			vector = offset + (src << 3);
-			virq = irq_linear_revmap(pp->irq_domain, vector);
-			dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n",
-				src, vector, virq);
-			generic_handle_irq(virq);
-		}
-	}
-}
-
-void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
-{
-	u32 reg_offset, bit_pos;
-	struct keystone_pcie *ks_pcie;
-	struct dw_pcie *pci;
-
-	pci = to_dw_pcie_from_pp(pp);
-	ks_pcie = to_keystone_pcie(pci);
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-
-	ks_dw_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
-			 BIT(bit_pos));
-	ks_dw_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
-}
-
-void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
-{
-	u32 reg_offset, bit_pos;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
-			 BIT(bit_pos));
-}
-
-void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
-{
-	u32 reg_offset, bit_pos;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
-			 BIT(bit_pos));
-}
-
-int ks_dw_pcie_msi_host_init(struct pcie_port *pp)
-{
-	return dw_pcie_allocate_domains(pp);
-}
-
-void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
-{
-	int i;
-
-	for (i = 0; i < PCI_NUM_INTX; i++)
-		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
-}
-
-void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-	u32 pending;
-	int virq;
-
-	pending = ks_dw_app_readl(ks_pcie, IRQ_STATUS + (offset << 4));
-
-	if (BIT(0) & pending) {
-		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
-		generic_handle_irq(virq);
-	}
-
-	/* EOI the INTx interrupt */
-	ks_dw_app_writel(ks_pcie, IRQ_EOI, offset);
-}
-
-void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
-{
-	ks_dw_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
-}
-
-irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
-{
-	u32 status;
-
-	status = ks_dw_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
-	if (!status)
-		return IRQ_NONE;
-
-	if (status & ERR_FATAL_IRQ)
-		dev_err(ks_pcie->pci->dev, "fatal error (status %#010x)\n",
-			status);
-
-	/* Ack the IRQ; status bits are RW1C */
-	ks_dw_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
-	return IRQ_HANDLED;
-}
-
-static void ks_dw_pcie_ack_legacy_irq(struct irq_data *d)
-{
-}
-
-static void ks_dw_pcie_mask_legacy_irq(struct irq_data *d)
-{
-}
-
-static void ks_dw_pcie_unmask_legacy_irq(struct irq_data *d)
-{
-}
-
-static struct irq_chip ks_dw_pcie_legacy_irq_chip = {
-	.name = "Keystone-PCI-Legacy-IRQ",
-	.irq_ack = ks_dw_pcie_ack_legacy_irq,
-	.irq_mask = ks_dw_pcie_mask_legacy_irq,
-	.irq_unmask = ks_dw_pcie_unmask_legacy_irq,
-};
-
-static int ks_dw_pcie_init_legacy_irq_map(struct irq_domain *d,
-				unsigned int irq, irq_hw_number_t hw_irq)
-{
-	irq_set_chip_and_handler(irq, &ks_dw_pcie_legacy_irq_chip,
-				 handle_level_irq);
-	irq_set_chip_data(irq, d->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops ks_dw_pcie_legacy_irq_domain_ops = {
-	.map = ks_dw_pcie_init_legacy_irq_map,
-	.xlate = irq_domain_xlate_onetwocell,
-};
-
-/**
- * ks_dw_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
- * registers
- *
- * Since modification of dbi_cs2 involves different clock domain, read the
- * status back to ensure the transition is complete.
- */
-static void ks_dw_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
-
-	do {
-		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	} while (!(val & DBI_CS2_EN_VAL));
-}
-
-/**
- * ks_dw_pcie_clear_dbi_mode() - Disable DBI mode
- *
- * Since modification of dbi_cs2 involves different clock domain, read the
- * status back to ensure the transition is complete.
- */
-static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
-
-	do {
-		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	} while (val & DBI_CS2_EN_VAL);
-}
-
-void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	u32 start = pp->mem->start, end = pp->mem->end;
-	int i, tr_size;
-	u32 val;
-
-	/* Disable BARs for inbound access */
-	ks_dw_pcie_set_dbi_mode(ks_pcie);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
-	ks_dw_pcie_clear_dbi_mode(ks_pcie);
-
-	/* Set outbound translation size per window division */
-	ks_dw_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
-
-	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
-
-	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
-	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
-		ks_dw_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
-		ks_dw_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
-		start += tr_size;
-	}
-
-	/* Enable OB translation */
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
-}
-
-/**
- * ks_pcie_cfg_setup() - Set up configuration space address for a device
- *
- * @ks_pcie: ptr to keystone_pcie structure
- * @bus: Bus number the device is residing on
- * @devfn: device, function number info
- *
- * Forms and returns the address of configuration space mapped in PCIESS
- * address space 0.  Also configures CFG_SETUP for remote configuration space
- * access.
- *
- * The address space has two regions to access configuration - local and remote.
- * We access local region for bus 0 (as RC is attached on bus 0) and remote
- * region for others with TYPE 1 access when bus > 1.  As for device on bus = 1,
- * we will do TYPE 0 access as it will be on our secondary bus (logical).
- * CFG_SETUP is needed only for remote configuration access.
- */
-static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
-				       unsigned int devfn)
-{
-	u8 device = PCI_SLOT(devfn), function = PCI_FUNC(devfn);
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	u32 regval;
-
-	if (bus == 0)
-		return pci->dbi_base;
-
-	regval = (bus << 16) | (device << 8) | function;
-
-	/*
-	 * Since Bus#1 will be a virtual bus, we need to have TYPE0
-	 * access only.
-	 * TYPE 1
-	 */
-	if (bus != 1)
-		regval |= BIT(24);
-
-	ks_dw_app_writel(ks_pcie, CFG_SETUP, regval);
-	return pp->va_cfg0_base;
-}
-
-int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-			     unsigned int devfn, int where, int size, u32 *val)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u8 bus_num = bus->number;
-	void __iomem *addr;
-
-	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
-
-	return dw_pcie_read(addr + where, size, val);
-}
-
-int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-			     unsigned int devfn, int where, int size, u32 val)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u8 bus_num = bus->number;
-	void __iomem *addr;
-
-	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
-
-	return dw_pcie_write(addr + where, size, val);
-}
-
-/**
- * ks_dw_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
- *
- * This sets BAR0 to enable inbound access for MSI_IRQ register
- */
-void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	/* Configure and set up BAR0 */
-	ks_dw_pcie_set_dbi_mode(ks_pcie);
-
-	/* Enable BAR0 */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
-
-	ks_dw_pcie_clear_dbi_mode(ks_pcie);
-
-	 /*
-	  * For BAR0, just setting bus address for inbound writes (MSI) should
-	  * be sufficient.  Use physical address to avoid any conflicts.
-	  */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
-}
-
-/**
- * ks_dw_pcie_link_up() - Check if link up
- */
-int ks_dw_pcie_link_up(struct dw_pcie *pci)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(pci, DEBUG0);
-	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
-}
-
-void ks_dw_pcie_stop_link(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	/* Disable Link training */
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	val &= ~LTSSM_EN_VAL;
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
-}
-
-void ks_dw_pcie_start_link(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	/* Initiate Link Training */
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
-}
-
-/**
- * ks_dw_pcie_host_init() - initialize host for v3_65 dw hardware
- *
- * Ioremap the register resources, initialize legacy irq domain
- * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
- * PCI host controller.
- */
-int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res;
-
-	/* Index 0 is the config reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
-
-	/*
-	 * We set these same and is used in pcie rd/wr_other_conf
-	 * functions
-	 */
-	pp->va_cfg0_base = pci->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
-	pp->va_cfg1_base = pp->va_cfg0_base;
-
-	/* Index 1 is the application reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ks_pcie->va_app_base))
-		return PTR_ERR(ks_pcie->va_app_base);
-
-	ks_pcie->app = *res;
-
-	/* Create legacy IRQ domain */
-	ks_pcie->legacy_irq_domain =
-			irq_domain_add_linear(ks_pcie->legacy_intc_np,
-					PCI_NUM_INTX,
-					&ks_dw_pcie_legacy_irq_domain_ops,
-					NULL);
-	if (!ks_pcie->legacy_irq_domain) {
-		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
-		return -EINVAL;
-	}
-
-	return dw_pcie_host_init(pp);
-}
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 24afc691443b..65ff7a5566b4 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -25,13 +25,62 @@
 #include <linux/signal.h>
 
 #include "pcie-designware.h"
-#include "pci-keystone.h"
 
 #define DRIVER_NAME	"keystone-pcie"
 
 /* DEV_STAT_CTRL */
 #define PCIE_CAP_BASE		0x70
 
+/* Application register defines */
+#define LTSSM_EN_VAL		        BIT(0)
+#define LTSSM_STATE_MASK		0x1f
+#define LTSSM_STATE_L0			0x11
+#define DBI_CS2_EN_VAL			0x20
+#define OB_XLAT_EN_VAL		        2
+
+/* Application registers */
+#define CMD_STATUS			0x004
+#define CFG_SETUP			0x008
+#define OB_SIZE				0x030
+#define CFG_PCIM_WIN_SZ_IDX		3
+#define CFG_PCIM_WIN_CNT		32
+#define SPACE0_REMOTE_CFG_OFFSET	0x1000
+#define OB_OFFSET_INDEX(n)		(0x200 + (8 * n))
+#define OB_OFFSET_HI(n)			(0x204 + (8 * n))
+
+/* IRQ register defines */
+#define IRQ_EOI				0x050
+#define IRQ_STATUS			0x184
+#define IRQ_ENABLE_SET			0x188
+#define IRQ_ENABLE_CLR			0x18c
+
+#define MSI_IRQ				0x054
+#define MSI0_IRQ_STATUS			0x104
+#define MSI0_IRQ_ENABLE_SET		0x108
+#define MSI0_IRQ_ENABLE_CLR		0x10c
+#define IRQ_STATUS			0x184
+#define MSI_IRQ_OFFSET			4
+
+/* Error IRQ bits */
+#define ERR_AER		BIT(5)	/* ECRC error */
+#define ERR_AXI		BIT(4)	/* AXI tag lookup fatal error */
+#define ERR_CORR	BIT(3)	/* Correctable error */
+#define ERR_NONFATAL	BIT(2)	/* Non-fatal error */
+#define ERR_FATAL	BIT(1)	/* Fatal error */
+#define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
+#define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
+			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
+#define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
+#define ERR_IRQ_STATUS_RAW		0x1c0
+#define ERR_IRQ_STATUS			0x1c4
+#define ERR_IRQ_ENABLE_SET		0x1c8
+#define ERR_IRQ_ENABLE_CLR		0x1cc
+
+/* Config space registers */
+#define DEBUG0				0x728
+
+#define MAX_MSI_HOST_IRQS		8
+
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK		0xb008
 #define PCIE_RC_K2E		0xb009
@@ -43,6 +92,448 @@
 static int ks_pcie_start_link(struct dw_pcie *pci);
 static void ks_pcie_stop_link(struct dw_pcie *pci);
 
+struct keystone_pcie {
+	struct dw_pcie		*pci;
+	struct	clk		*clk;
+	/* PCI Device ID */
+	u32			device_id;
+	int			num_legacy_host_irqs;
+	int			legacy_host_irqs[PCI_NUM_INTX];
+	struct			device_node *legacy_intc_np;
+
+	int			num_msi_host_irqs;
+	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
+	struct			device_node *msi_intc_np;
+	struct irq_domain	*legacy_irq_domain;
+	struct device_node	*np;
+
+	int error_irq;
+
+	/* Application register space */
+	void __iomem		*va_app_base;	/* DT 1st resource */
+	struct resource		app;
+};
+
+static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
+					     u32 *bit_pos)
+{
+	*reg_offset = offset % 8;
+	*bit_pos = offset >> 3;
+}
+
+static phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	return ks_pcie->app.start + MSI_IRQ;
+}
+
+static u32 ks_dw_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
+{
+	return readl(ks_pcie->va_app_base + offset);
+}
+
+static void ks_dw_app_writel(struct keystone_pcie *ks_pcie, u32 offset, u32 val)
+{
+	writel(val, ks_pcie->va_app_base + offset);
+}
+
+static void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
+{
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
+	u32 pending, vector;
+	int src, virq;
+
+	pending = ks_dw_app_readl(ks_pcie, MSI0_IRQ_STATUS + (offset << 4));
+
+	/*
+	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
+	 * shows 1, 9, 17, 25 and so forth
+	 */
+	for (src = 0; src < 4; src++) {
+		if (BIT(src) & pending) {
+			vector = offset + (src << 3);
+			virq = irq_linear_revmap(pp->irq_domain, vector);
+			dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n",
+				src, vector, virq);
+			generic_handle_irq(virq);
+		}
+	}
+}
+
+static void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
+{
+	u32 reg_offset, bit_pos;
+	struct keystone_pcie *ks_pcie;
+	struct dw_pcie *pci;
+
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
+	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
+
+	ks_dw_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
+			 BIT(bit_pos));
+	ks_dw_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
+}
+
+static void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
+{
+	u32 reg_offset, bit_pos;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
+	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
+			 BIT(bit_pos));
+}
+
+static void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
+{
+	u32 reg_offset, bit_pos;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
+	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
+			 BIT(bit_pos));
+}
+
+static int ks_dw_pcie_msi_host_init(struct pcie_port *pp)
+{
+	return dw_pcie_allocate_domains(pp);
+}
+
+static void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
+{
+	int i;
+
+	for (i = 0; i < PCI_NUM_INTX; i++)
+		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
+}
+
+static void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
+					 int offset)
+{
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 pending;
+	int virq;
+
+	pending = ks_dw_app_readl(ks_pcie, IRQ_STATUS + (offset << 4));
+
+	if (BIT(0) & pending) {
+		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
+		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
+		generic_handle_irq(virq);
+	}
+
+	/* EOI the INTx interrupt */
+	ks_dw_app_writel(ks_pcie, IRQ_EOI, offset);
+}
+
+static void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
+{
+	ks_dw_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
+}
+
+static irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
+{
+	u32 status;
+
+	status = ks_dw_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & ERR_FATAL_IRQ)
+		dev_err(ks_pcie->pci->dev, "fatal error (status %#010x)\n",
+			status);
+
+	/* Ack the IRQ; status bits are RW1C */
+	ks_dw_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
+	return IRQ_HANDLED;
+}
+
+static void ks_dw_pcie_ack_legacy_irq(struct irq_data *d)
+{
+}
+
+static void ks_dw_pcie_mask_legacy_irq(struct irq_data *d)
+{
+}
+
+static void ks_dw_pcie_unmask_legacy_irq(struct irq_data *d)
+{
+}
+
+static struct irq_chip ks_dw_pcie_legacy_irq_chip = {
+	.name = "Keystone-PCI-Legacy-IRQ",
+	.irq_ack = ks_dw_pcie_ack_legacy_irq,
+	.irq_mask = ks_dw_pcie_mask_legacy_irq,
+	.irq_unmask = ks_dw_pcie_unmask_legacy_irq,
+};
+
+static int ks_dw_pcie_init_legacy_irq_map(struct irq_domain *d,
+				unsigned int irq, irq_hw_number_t hw_irq)
+{
+	irq_set_chip_and_handler(irq, &ks_dw_pcie_legacy_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, d->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ks_dw_pcie_legacy_irq_domain_ops = {
+	.map = ks_dw_pcie_init_legacy_irq_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+/**
+ * ks_dw_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
+ * registers
+ *
+ * Since modification of dbi_cs2 involves different clock domain, read the
+ * status back to ensure the transition is complete.
+ */
+static void ks_dw_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+
+	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+	ks_dw_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
+
+	do {
+		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+	} while (!(val & DBI_CS2_EN_VAL));
+}
+
+/**
+ * ks_dw_pcie_clear_dbi_mode() - Disable DBI mode
+ *
+ * Since modification of dbi_cs2 involves different clock domain, read the
+ * status back to ensure the transition is complete.
+ */
+static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+
+	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+	ks_dw_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
+
+	do {
+		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+	} while (val & DBI_CS2_EN_VAL);
+}
+
+static void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
+{
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	u32 start = pp->mem->start, end = pp->mem->end;
+	int i, tr_size;
+	u32 val;
+
+	/* Disable BARs for inbound access */
+	ks_dw_pcie_set_dbi_mode(ks_pcie);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
+	ks_dw_pcie_clear_dbi_mode(ks_pcie);
+
+	/* Set outbound translation size per window division */
+	ks_dw_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
+
+	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
+
+	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
+	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
+		ks_dw_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
+		ks_dw_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
+		start += tr_size;
+	}
+
+	/* Enable OB translation */
+	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+	ks_dw_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
+}
+
+/**
+ * ks_pcie_cfg_setup() - Set up configuration space address for a device
+ *
+ * @ks_pcie: ptr to keystone_pcie structure
+ * @bus: Bus number the device is residing on
+ * @devfn: device, function number info
+ *
+ * Forms and returns the address of configuration space mapped in PCIESS
+ * address space 0.  Also configures CFG_SETUP for remote configuration space
+ * access.
+ *
+ * The address space has two regions to access configuration - local and remote.
+ * We access local region for bus 0 (as RC is attached on bus 0) and remote
+ * region for others with TYPE 1 access when bus > 1.  As for device on bus = 1,
+ * we will do TYPE 0 access as it will be on our secondary bus (logical).
+ * CFG_SETUP is needed only for remote configuration access.
+ */
+static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
+				       unsigned int devfn)
+{
+	u8 device = PCI_SLOT(devfn), function = PCI_FUNC(devfn);
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	u32 regval;
+
+	if (bus == 0)
+		return pci->dbi_base;
+
+	regval = (bus << 16) | (device << 8) | function;
+
+	/*
+	 * Since Bus#1 will be a virtual bus, we need to have TYPE0
+	 * access only.
+	 * TYPE 1
+	 */
+	if (bus != 1)
+		regval |= BIT(24);
+
+	ks_dw_app_writel(ks_pcie, CFG_SETUP, regval);
+	return pp->va_cfg0_base;
+}
+
+static int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				    unsigned int devfn, int where, int size,
+				    u32 *val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	u8 bus_num = bus->number;
+	void __iomem *addr;
+
+	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
+
+	return dw_pcie_read(addr + where, size, val);
+}
+
+static int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				    unsigned int devfn, int where, int size,
+				    u32 val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	u8 bus_num = bus->number;
+	void __iomem *addr;
+
+	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
+
+	return dw_pcie_write(addr + where, size, val);
+}
+
+/**
+ * ks_dw_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
+ *
+ * This sets BAR0 to enable inbound access for MSI_IRQ register
+ */
+static void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	/* Configure and set up BAR0 */
+	ks_dw_pcie_set_dbi_mode(ks_pcie);
+
+	/* Enable BAR0 */
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
+
+	ks_dw_pcie_clear_dbi_mode(ks_pcie);
+
+	 /*
+	  * For BAR0, just setting bus address for inbound writes (MSI) should
+	  * be sufficient.  Use physical address to avoid any conflicts.
+	  */
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+}
+
+/**
+ * ks_dw_pcie_link_up() - Check if link up
+ */
+static int ks_dw_pcie_link_up(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, DEBUG0);
+	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
+}
+
+static void ks_dw_pcie_stop_link(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+
+	/* Disable Link training */
+	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+	val &= ~LTSSM_EN_VAL;
+	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+}
+
+static void ks_dw_pcie_start_link(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+
+	/* Initiate Link Training */
+	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+}
+
+/**
+ * ks_dw_pcie_host_init() - initialize host for v3_65 dw hardware
+ *
+ * Ioremap the register resources, initialize legacy irq domain
+ * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
+ * PCI host controller.
+ */
+static int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie)
+{
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+
+	/* Index 0 is the config reg. space address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	/*
+	 * We set these same and is used in pcie rd/wr_other_conf
+	 * functions
+	 */
+	pp->va_cfg0_base = pci->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
+	pp->va_cfg1_base = pp->va_cfg0_base;
+
+	/* Index 1 is the application reg. space address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ks_pcie->va_app_base))
+		return PTR_ERR(ks_pcie->va_app_base);
+
+	ks_pcie->app = *res;
+
+	/* Create legacy IRQ domain */
+	ks_pcie->legacy_irq_domain =
+			irq_domain_add_linear(ks_pcie->legacy_intc_np,
+					PCI_NUM_INTX,
+					&ks_dw_pcie_legacy_irq_domain_ops,
+					NULL);
+	if (!ks_pcie->legacy_irq_domain) {
+		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
+		return -EINVAL;
+	}
+
+	return dw_pcie_host_init(pp);
+}
+
 static void quirk_limit_mrrs(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
diff --git a/drivers/pci/controller/dwc/pci-keystone.h b/drivers/pci/controller/dwc/pci-keystone.h
deleted file mode 100644
index a66deab626aa..000000000000
--- a/drivers/pci/controller/dwc/pci-keystone.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Keystone PCI Controller's common includes
- *
- * Copyright (C) 2013-2014 Texas Instruments., Ltd.
- *		http://www.ti.com
- *
- * Author: Murali Karicheri <m-karicheri2@ti.com>
- */
-
-#define MAX_MSI_HOST_IRQS		8
-
-struct keystone_pcie {
-	struct dw_pcie		*pci;
-	struct	clk		*clk;
-	/* PCI Device ID */
-	u32			device_id;
-	int			num_legacy_host_irqs;
-	int			legacy_host_irqs[PCI_NUM_INTX];
-	struct			device_node *legacy_intc_np;
-
-	int			num_msi_host_irqs;
-	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
-	struct			device_node *msi_intc_np;
-	struct irq_domain	*legacy_irq_domain;
-	struct device_node	*np;
-
-	int error_irq;
-
-	/* Application register space */
-	void __iomem		*va_app_base;	/* DT 1st resource */
-	struct resource		app;
-};
-
-/* Keystone DW specific MSI controller APIs/definitions */
-void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset);
-phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
-
-/* Keystone specific PCI controller APIs */
-void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie);
-void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset);
-void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie);
-irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie);
-int  ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie);
-int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-		unsigned int devfn, int where, int size, u32 val);
-int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-		unsigned int devfn, int where, int size, u32 *val);
-void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie);
-void ks_dw_pcie_start_link(struct keystone_pcie *ks_pcie);
-void ks_dw_pcie_stop_link(struct keystone_pcie *ks_pcie);
-void ks_dw_pcie_msi_irq_ack(int i, struct pcie_port *pp);
-void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq);
-void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq);
-void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp);
-int ks_dw_pcie_msi_host_init(struct pcie_port *pp);
-int ks_dw_pcie_link_up(struct dw_pcie *pci);
-- 
2.17.1

