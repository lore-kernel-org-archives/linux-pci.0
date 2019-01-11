Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5CFC43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C86E20872
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DWm0UOWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbfAKSdy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:33:54 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:34054 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387628AbfAKSdy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2019 13:33:54 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2B82124E0FE1;
        Fri, 11 Jan 2019 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547231633; bh=xk2arTy4Gguny3WATBRZq5sbTjy5N6cNb4ojU8fI4vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=DWm0UOWtu8xEt/fECoWpJ4dywefuN8yeVqjuqKCWBUY2i1HhGFnYKdkLRqWq+bIQz
         LgzVVj9eFc3Aj62ametoKvI0I0pTEIzdphhD9odv98ndD64n6nwtisPv6shiLkR0xx
         wB8py3V9/edj7du6ACYfUXdwv35eygd9mIRnHyM1uUqpC329Mg0Fa9ay7p/pXONdJG
         Pa/++r0zhHMUhlaLR/TA/MfEwYI6uzt99IXw/cc7HjuyJEKE4NQ2pQmuj20NJCOa0r
         D40eRoQmHgpFHxTx3RmrQ9kBv7s5HqhYK8sadrdytWargyl0oWUzjqBUaVyCff8oV7
         x6937K3rsRjDA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id DDD233EFB;
        Fri, 11 Jan 2019 10:33:52 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 197323EDAC;
        Fri, 11 Jan 2019 19:33:51 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: [RFC v3 5/7] dmaengine: Add Synopsys eDMA IP PCIe glue-logic
Date:   Fri, 11 Jan 2019 19:33:41 +0100
Message-Id: <a70d096e96f34cd9ea773da519965076d74d12ec.1547230339.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Synopsys eDMA IP is normally distributed along with Synopsys PCIe
EndPoint IP (depends of the use and licensing agreement).

This IP requires some basic configurations, such as:
 - eDMA registers BAR
 - eDMA registers offset
 - eDMA registers size
 - eDMA linked list memory BAR
 - eDMA linked list memory offset
 - eDMA linked list memory sze
 - eDMA data memory BAR
 - eDMA data memory offset
 - eDMA data memory size
 - eDMA version
 - eDMA mode
 - IRQs available for eDMA

As a working example, PCIe glue-logic will attach to a Synopsys PCIe
EndPoint IP prototype kit (Vendor ID = 0x16c3, Device ID = 0xedda),
which has built-in an eDMA IP with this default configuration:
 - eDMA registers BAR = 0
 - eDMA registers offset = 0x00001000 (4 Kbytes)
 - eDMA registers size = 0x00002000 (8 Kbytes)
 - eDMA linked list memory BAR = 2
 - eDMA linked list memory offset = 0x00000000 (0 Kbytes)
 - eDMA linked list memory size = 0x00800000 (8 Mbytes)
 - eDMA data memory BAR = 2
 - eDMA data memory offset = 0x00800000 (8 Mbytes)
 - eDMA data memory size = 0x03800000 (56 Mbytes)
 - eDMA version = 0
 - eDMA mode = EDMA_MODE_UNROLL
 - IRQs = 1

This driver can be compile as built-in or external module in kernel.

To enable this driver just select DW_EDMA_PCIE option in kernel
configuration, however it requires and selects automatically DW_EDMA
option too.

Changes:
RFC v1->RFC v2:
 - Replace comments // (C99 style) by /**/
 - Merge two pcim_iomap_regions() calls into just one call
 - Remove pci_try_set_mwi() call
 - Replace some dev_info() by dev_dbg() to reduce *noise*
 - Remove pci_name(pdev) call after being call dw_edma_remove()
 - Remove all power management support
 - Fix the headers of the .c and .h files according to the most recent
   convention
 - Fix errors and checks pointed out by checkpatch with --strict option
 - Replace patch small description tag from dma by dmaengine
RFC v2->RFC v3:
 - Fix printk variable of phys_addr_t type
 - Fix missing variable initialization (chan->configured)
 - Change linked list size to 512 Kbytes
 - Add data memory information
 - Add register size information
 - Add comments or improve existing ones
 - Add possibility to work with multiple IRQs feature
 - Replace MSI and MSI-X enable condition by pci_dev_msi_enabled()
 - Replace code to acquire MSI(-X) address and data by
   get_cached_msi_msg()

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Eugeniy Paltsev <paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jose Abreu <jose.abreu@synopsys.com>
Cc: Luis Oliveira <lolivei@synopsys.com>
Cc: Vitor Soares <vitor.soares@synopsys.com>
Cc: Nelson Costa <nelson.costa@synopsys.com>
Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
---
 drivers/dma/dw-edma/Kconfig        |   9 ++
 drivers/dma/dw-edma/Makefile       |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c | 254 +++++++++++++++++++++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 drivers/dma/dw-edma/dw-edma-pcie.c

diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
index 3016bed..c0838ce 100644
--- a/drivers/dma/dw-edma/Kconfig
+++ b/drivers/dma/dw-edma/Kconfig
@@ -7,3 +7,12 @@ config DW_EDMA
 	help
 	  Support the Synopsys DesignWare eDMA controller, normally
 	  implemented on endpoints SoCs.
+
+config DW_EDMA_PCIE
+	tristate "Synopsys DesignWare eDMA PCIe driver"
+	depends on PCI && PCI_MSI
+	select DW_EDMA
+	help
+	  Provides a glue-logic between the Synopsys DesignWare
+	  eDMA controller and an endpoint PCIe device. This also serves
+	  as a reference design to whom desires to use this IP.
diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 0c53033..8d45c0d 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
 dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
 dw-edma-objs			:= dw-edma-core.o \
 					dw-edma-v0-core.o $(dw-edma-y)
+obj-$(CONFIG_DW_EDMA_PCIE)	+= dw-edma-pcie.o
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
new file mode 100644
index 0000000..b96b3c4
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA PCIe driver
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/dma/edma.h>
+#include <linux/msi.h>
+
+#include "dw-edma-core.h"
+
+enum dw_edma_pcie_bar {
+	BAR_0,
+	BAR_1,
+	BAR_2,
+	BAR_3,
+	BAR_4,
+	BAR_5
+};
+
+struct dw_edma_pcie_data {
+	/* eDMA registers location */
+	enum dw_edma_pcie_bar		rg_bar;
+	off_t				rg_off;
+	size_t				rg_sz;
+	/* eDMA memory linked list location */
+	enum dw_edma_pcie_bar		ll_bar;
+	off_t				ll_off;
+	size_t				ll_sz;
+	/* eDMA memory data location */
+	enum dw_edma_pcie_bar		dt_bar;
+	off_t				dt_off;
+	size_t				dt_sz;
+	/* Other */
+	u32				version;
+	enum dw_edma_mode		mode;
+	u8				irqs_cnt;
+};
+
+static const struct dw_edma_pcie_data snps_edda_data = {
+	/* eDMA registers location */
+	.rg_bar				= BAR_0,
+	.rg_off				= 0x00001000,	/*  4 Kbytes */
+	.rg_sz				= 0x00002000,	/*  8 Kbytes */
+	/* eDMA memory linked list location */
+	.ll_bar				= BAR_2,
+	.ll_off				= 0x00000000,	/*  0 Kbytes */
+	.ll_sz				= 0x00800000,	/*  8 Mbytes */
+	/* eDMA memory data location */
+	.dt_bar				= BAR_2,
+	.dt_off				= 0x00800000,	/*  8 Mbytes */
+	.dt_sz				= 0x03800000,	/* 56 Mbytes */
+	/* Other */
+	.version			= 0,
+	.mode				= EDMA_MODE_UNROLL,
+	.irqs_cnt			= 1,
+};
+
+static bool disable_msix;
+module_param(disable_msix, bool, 0644);
+MODULE_PARM_DESC(disable_msix, "Disable MSI-X interrupts");
+
+static int dw_edma_pcie_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *pid)
+{
+	const struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
+	struct device *dev = &pdev->dev;
+	struct dw_edma_chip *chip;
+	struct dw_edma *dw;
+	unsigned int irq_flags = PCI_IRQ_MSI;
+	int err, nr_irqs, i;
+
+	if (!pdata) {
+		dev_err(dev, "%s missing data structure\n", pci_name(pdev));
+		return -EFAULT;
+	}
+
+	/* Enable PCI device */
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "%s enabling device failed\n", pci_name(pdev));
+		return err;
+	}
+
+	/* Mapping PCI BAR regions */
+	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar) |
+				       BIT(pdata->ll_bar) |
+				       BIT(pdata->dt_bar),
+				 pci_name(pdev));
+	if (err) {
+		dev_err(dev, "%s eDMA BAR I/O remapping failed\n",
+			pci_name(pdev));
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	/* DMA configuration */
+	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(dev, "%s DMA mask set failed\n", pci_name(pdev));
+		return err;
+	}
+
+	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(dev, "%s consistent DMA mask set failed\n",
+			pci_name(pdev));
+		return err;
+	}
+
+	/* Data structure allocation */
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	/* IRQs allocation */
+	if (!disable_msix)
+		irq_flags |= PCI_IRQ_MSIX;
+
+	nr_irqs = pci_alloc_irq_vectors(pdev, 1, pdata->irqs_cnt, irq_flags);
+	if (nr_irqs < 1) {
+		dev_err(dev, "%s failed to alloc IRQ vector (Number of IRQs=%u)\n",
+			pci_name(pdev), nr_irqs);
+		return -EPERM;
+	}
+
+	/* Data structure initialization */
+	chip->dw = dw;
+	chip->dev = dev;
+	chip->id = pdev->devfn;
+	chip->irq = pdev->irq;
+
+	if (!pcim_iomap_table(pdev))
+		return -EACCES;
+
+	dw->rg_region.vaddr = (dma_addr_t)pcim_iomap_table(pdev)[pdata->rg_bar];
+	dw->rg_region.vaddr += pdata->rg_off;
+	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
+	dw->rg_region.paddr += pdata->rg_off;
+	dw->rg_region.sz = pdata->rg_sz;
+
+	dw->ll_region.vaddr = (dma_addr_t)pcim_iomap_table(pdev)[pdata->ll_bar];
+	dw->ll_region.vaddr += pdata->ll_off;
+	dw->ll_region.paddr = pdev->resource[pdata->ll_bar].start;
+	dw->ll_region.paddr += pdata->ll_off;
+	dw->ll_region.sz = pdata->ll_sz;
+
+	dw->dt_region.vaddr = (dma_addr_t)pcim_iomap_table(pdev)[pdata->dt_bar];
+	dw->dt_region.vaddr += pdata->dt_off;
+	dw->dt_region.paddr = pdev->resource[pdata->dt_bar].start;
+	dw->dt_region.paddr += pdata->dt_off;
+	dw->dt_region.sz = pdata->dt_sz;
+
+	dw->version = pdata->version;
+	dw->mode = pdata->mode;
+	dw->nr_irqs = nr_irqs;
+
+	/* Debug info */
+	dev_dbg(dev, "Version:\t%u\n", dw->version);
+
+	dev_dbg(dev, "Mode:\t%s\n",
+		dw->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
+
+	dev_dbg(dev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%pa, p=%pa)\n",
+		pdata->rg_bar, pdata->rg_off, pdata->rg_sz,
+		&dw->rg_region.vaddr, &dw->rg_region.paddr);
+
+	dev_dbg(dev, "L. List:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%pa, p=%pa)\n",
+		pdata->ll_bar, pdata->ll_off, pdata->ll_sz,
+		&dw->ll_region.vaddr, &dw->ll_region.paddr);
+
+	dev_dbg(dev, "Data:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%pa, p=%pa)\n",
+		pdata->dt_bar, pdata->dt_off, pdata->dt_sz,
+		&dw->dt_region.vaddr, &dw->dt_region.paddr);
+
+	dev_dbg(dev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
+
+	/* Validating if PCI interrupts were enabled */
+	if (!pci_dev_msi_enabled(pdev)) {
+		dev_err(dev, "%s enable interrupt failed\n", pci_name(pdev));
+		return -EPERM;
+	}
+
+	/*
+	 * Acquiring PCI MSI(-X) configuration (address and data) for
+	 * setting it later on eDMA interrupt registers
+	 */
+	dw->msi = devm_kcalloc(dev, nr_irqs, sizeof(*dw->msi), GFP_KERNEL);
+	if (!dw->msi)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_irqs; i++)
+		get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), i),
+				   &dw->msi[i]);
+
+	/* Starting eDMA driver */
+	err = dw_edma_probe(chip);
+	if (err) {
+		dev_err(dev, "%s eDMA probe failed\n", pci_name(pdev));
+		return err;
+	}
+
+	/* Saving data structure reference */
+	pci_set_drvdata(pdev, chip);
+
+	dev_info(dev, "DesignWare eDMA PCIe driver loaded completely\n");
+
+	return 0;
+}
+
+static void dw_edma_pcie_remove(struct pci_dev *pdev)
+{
+	struct dw_edma_chip *chip = pci_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int err;
+
+	/* Stopping eDMA driver */
+	err = dw_edma_remove(chip);
+	if (err)
+		dev_warn(dev, "can't remove device properly: %d\n", err);
+
+	/* Freeing IRQs */
+	pci_free_irq_vectors(pdev);
+
+	dev_info(dev, "DesignWare eDMA PCIe driver unloaded completely\n");
+}
+
+static const struct pci_device_id dw_edma_pcie_id_table[] = {
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
+
+static struct pci_driver dw_edma_pcie_driver = {
+	.name		= "dw-edma-pcie",
+	.id_table	= dw_edma_pcie_id_table,
+	.probe		= dw_edma_pcie_probe,
+	.remove		= dw_edma_pcie_remove,
+};
+
+module_pci_driver(dw_edma_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Synopsys DesignWare eDMA PCIe driver");
+MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
-- 
2.7.4

