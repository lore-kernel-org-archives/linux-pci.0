Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996ABC67839
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A162084E
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SrmqJR80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A162084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeLLLN5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:13:57 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:35100 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeLLLN5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 06:13:57 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A16F910C1804;
        Wed, 12 Dec 2018 03:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544613236; bh=7TGnoCVaV+g4IamKonl5z3SzoCxj2tCUAEzmyLA2Lt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SrmqJR80Qnx+LJfGqf4ZHYg40jyz4vy8xImfBL3uJ1aPyEZ0eIJgi2WF32Atm7/yn
         nWey9uLh1DRXEnAHbT7JK5z3dC7fe8tdb9asE/KdonMij40oDekmVSfb4b48ETQSZX
         7aKMfMwnAS6KBbgd3DteKlW5kQRY7+EQRCHEtyVZlwLyYv+aglcZo1KIqcVLDQWL6m
         M6Cw943dWbxCsxwMK5utit68YGCfbwW0wqq8RangVZOFW5S7mRYIL9QS/HS8W0nW7s
         9hoT8sDzYG1BCPwSwsmy0sy3Kmf2Ak6AUPhNUxiKvp4bDRMfaN/xh+CZ2ReJ85rBcJ
         mwhuxgDrideyw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 673513E22;
        Wed, 12 Dec 2018 03:13:56 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 9BCE63BDDD;
        Wed, 12 Dec 2018 12:13:55 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [RFC 4/6] dma: Add Synopsys eDMA IP PCIe glue-logic
Date:   Wed, 12 Dec 2018 12:13:24 +0100
Message-Id: <b3cf38fc1cb81f9f14df96e2332e612e23ebf918.1544610287.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Synopsys eDMA IP is normally distributed along with Synopsys PCIe
EndPoint IP (depends of the use and licensing agreement).

This IP requires some basic configurations, such as:
 - eDMA registers BAR
 - eDMA registers offset
 - eDMA linked list BAR
 - eDMA linked list offset
 - eDMA linked list size
 - eDMA version
 - eDMA mode

As a working example, PCIe glue-logic will attach to a Synopsys PCIe
EndPoint IP prototype kit (Vendor ID = 0x16c3, Device ID = 0xedda),
which has built-in an eDMA IP with this default configuration:
 - eDMA registers BAR = 0
 - eDMA registers offset = 0x1000 (4 Kbytes)
 - eDMA linked list BAR = 2
 - eDMA linked list offset = 0x0 (0 Kbytes)
 - eDMA linked list size = 0x20000 (128 Kbytes)
 - eDMA version = 0
 - eDMA mode = EDMA_MODE_UNROLL

This driver can be compile as built-in or external module in kernel.

To enable this driver just select DW_EDMA_PCIE option in kernel
configuration, however it requires and selects automatically DW_EDMA
option too.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Eugeniy Paltsev <paltsev@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joao Pinto <jpinto@synopsys.com>
---
 drivers/dma/dw-edma/Kconfig        |   9 ++
 drivers/dma/dw-edma/Makefile       |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c | 302 +++++++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+)
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
index 0000000..f29a861
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+// Synopsys DesignWare eDMA PCIe driver
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/dma/edma.h>
+
+#include "dw-edma-core.h"
+
+#define DRV_PCIE_NAME			"dw-edma-pcie"
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
+	enum dw_edma_pcie_bar		regs_bar;
+	u64				regs_off;
+	enum dw_edma_pcie_bar		ll_bar;
+	u64				ll_off;
+	size_t				ll_sz;
+	u32				version;
+	enum dw_edma_mode		mode;
+};
+
+static const struct dw_edma_pcie_data snps_edda_data = {
+	// eDMA registers location
+	.regs_bar			= BAR_0,
+	.regs_off			= 0x1000,	//   4 KBytes
+	// eDMA memory linked list location
+	.ll_bar				= BAR_2,
+	.ll_off				= 0,		//   0 KBytes
+	.ll_sz				= 0x20000,	// 128 KBytes
+	// Other
+	.version			= 0,
+	.mode				= EDMA_MODE_UNROLL,
+};
+
+static int dw_edma_pcie_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *pid)
+{
+	const struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
+	struct device *dev = &pdev->dev;
+	struct dw_edma_chip *chip;
+	struct dw_edma *dw;
+	void __iomem *reg;
+	int err, irq = -1;
+	u32 addr_hi, addr_lo;
+	u16 flags;
+	u8 cap_off;
+
+	if (!pdata) {
+		dev_err(dev, "%s missing data struture\n",
+			pci_name(pdev));
+		return -EFAULT;
+	}
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "%s enabling device failed\n",
+			pci_name(pdev));
+		return err;
+	}
+
+	err = pcim_iomap_regions(pdev, 1 << pdata->regs_bar, pci_name(pdev));
+	if (err) {
+		dev_err(dev, "%s eDMA register BAR I/O memory remapping failed\n",
+			pci_name(pdev));
+		return err;
+	}
+
+	err = pcim_iomap_regions(pdev, 1 << pdata->ll_bar, pci_name(pdev));
+	if (err) {
+		dev_err(dev, "%s eDMA linked list BAR I/O remapping failed\n",
+			pci_name(pdev));
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	err = pci_try_set_mwi(pdev);
+	if (err) {
+		dev_err(dev, "%s DMA memory write invalidate\n",
+			pci_name(pdev));
+		return err;
+	}
+
+	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(dev, "%s DMA mask set failed\n",
+			pci_name(pdev));
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
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (irq < 0) {
+		dev_err(dev, "%s failed to alloc IRQ vector\n",
+			pci_name(pdev));
+		return -EPERM;
+	}
+
+	chip->dw = dw;
+	chip->dev = dev;
+	chip->id = pdev->devfn;
+	chip->irq = pdev->irq;
+
+	dw->regs = pcim_iomap_table(pdev)[pdata->regs_bar];
+	dw->regs += pdata->regs_off;
+
+	dw->va_ll = pcim_iomap_table(pdev)[pdata->ll_bar];
+	dw->va_ll += pdata->ll_off;
+	dw->pa_ll = pdev->resource[pdata->ll_bar].start;
+	dw->pa_ll += pdata->ll_off;
+	dw->ll_sz = pdata->ll_sz;
+
+	dw->msi_addr = 0;
+	dw->msi_data = 0;
+
+	dw->version = pdata->version;
+	dw->mode = pdata->mode;
+
+	dev_info(dev, "Version:\t%u\n", dw->version);
+
+	dev_info(dev, "Mode:\t%s\n",
+		 dw->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
+
+	dev_info(dev, "Registers:\tBAR=%u, off=0x%.16llx B, addr=0x%.8lx\n",
+		 pdata->regs_bar, pdata->regs_off,
+		 (unsigned long) dw->regs);
+
+	dev_info(dev,
+		"L. List:\tBAR=%u, off=0x%.16llx B, sz=0x%.8x B, vaddr=0x%.8lx, paddr=0x%.8lx",
+		 pdata->ll_bar, pdata->ll_off, pdata->ll_sz,
+		 (unsigned long) dw->va_ll,
+		 (unsigned long) dw->pa_ll);
+
+	if (pdev->msi_cap && pdev->msi_enabled) {
+		cap_off = pdev->msi_cap + PCI_MSI_FLAGS;
+		pci_read_config_word(pdev, cap_off, &flags);
+		if (flags & PCI_MSI_FLAGS_ENABLE) {
+			cap_off = pdev->msi_cap + PCI_MSI_ADDRESS_LO;
+			pci_read_config_dword(pdev, cap_off, &addr_lo);
+
+			if (flags & PCI_MSI_FLAGS_64BIT) {
+				cap_off = pdev->msi_cap + PCI_MSI_ADDRESS_HI;
+				pci_read_config_dword(pdev, cap_off, &addr_hi);
+				cap_off = pdev->msi_cap + PCI_MSI_DATA_64;
+			} else {
+				addr_hi = 0;
+				cap_off = pdev->msi_cap + PCI_MSI_DATA_32;
+			}
+
+			dw->msi_addr = addr_hi;
+			dw->msi_addr <<= 32;
+			dw->msi_addr |= addr_lo;
+
+			pci_read_config_dword(pdev, cap_off, &(dw->msi_data));
+			dw->msi_data &= 0xffff;
+
+			dev_info(dev,
+				 "MSI:\t\taddr=0x%.16llx, data=0x%.8x, nr=%d\n",
+				 dw->msi_addr, dw->msi_data, pdev->irq);
+		}
+	}
+
+	if (pdev->msix_cap && pdev->msix_enabled) {
+		u32 offset;
+		u8 bir;
+
+		cap_off = pdev->msix_cap + PCI_MSIX_FLAGS;
+		pci_read_config_word(pdev, cap_off, &flags);
+
+		if (flags & PCI_MSIX_FLAGS_ENABLE) {
+			cap_off = pdev->msix_cap + PCI_MSIX_TABLE;
+			pci_read_config_dword(pdev, cap_off, &offset);
+
+			bir = offset & PCI_MSIX_TABLE_BIR;
+			offset &= PCI_MSIX_TABLE_OFFSET;
+
+			reg = pcim_iomap_table(pdev)[bir];
+			reg += offset;
+
+			addr_lo = readl(reg + PCI_MSIX_ENTRY_LOWER_ADDR);
+			addr_hi = readl(reg + PCI_MSIX_ENTRY_UPPER_ADDR);
+			dw->msi_addr = addr_hi;
+			dw->msi_addr <<= 32;
+			dw->msi_addr |= addr_lo;
+
+			dw->msi_data = readl(reg + PCI_MSIX_ENTRY_DATA);
+
+			dev_info(dev,
+				 "MSI-X:\taddr=0x%.16llx, data=0x%.8x, nr=%d\n",
+				 dw->msi_addr, dw->msi_data, pdev->irq);
+		}
+	}
+
+	if (!pdev->msi_enabled && !pdev->msix_enabled) {
+		dev_err(dev, "%s enable interrupt failed\n",
+			pci_name(pdev));
+		return -EPERM;
+	}
+
+	err = dw_edma_probe(chip);
+	if (err) {
+		dev_err(dev, "%s eDMA probe failed\n",
+			pci_name(pdev));
+		return err;
+	}
+
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
+	err = dw_edma_remove(chip);
+	if (err) {
+		dev_warn(dev, "%s can't remove device properly: %d\n",
+			pci_name(pdev), err);
+	}
+
+	pci_free_irq_vectors(pdev);
+
+	dev_info(dev, "DesignWare eDMA PCIe driver unloaded completely\n");
+}
+
+#ifdef CONFIG_PM_SLEEP
+
+static int dw_edma_pcie_suspend_late(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct dw_edma_chip *chip = pci_get_drvdata(pci);
+
+	return dw_edma_disable(chip);
+};
+
+static int dw_edma_pcie_resume_early(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct dw_edma_chip *chip = pci_get_drvdata(pci);
+
+	return dw_edma_enable(chip);
+};
+
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops dw_edma_pcie_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_edma_pcie_suspend_late,
+				     dw_edma_pcie_resume_early)
+};
+
+static const struct pci_device_id dw_edma_pcie_id_table[] = {
+	{ PCI_DEVICE_DATA(SYNOPSYS, 0xedda, &snps_edda_data) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
+
+static struct pci_driver dw_edma_pcie_driver = {
+	.name		= DRV_PCIE_NAME,
+	.id_table	= dw_edma_pcie_id_table,
+	.probe		= dw_edma_pcie_probe,
+	.remove		= dw_edma_pcie_remove,
+	.driver	= {
+		.pm	= &dw_edma_pcie_dev_pm_ops,
+	},
+};
+
+module_pci_driver(dw_edma_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Synopsys DesignWare eDMA PCIe driver");
+MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
-- 
2.7.4

