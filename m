Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36556 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbeHAIsd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 04:48:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so8339148plb.3
        for <linux-pci@vger.kernel.org>; Wed, 01 Aug 2018 00:04:21 -0700 (PDT)
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH 1/1] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver compile support
Date: Wed,  1 Aug 2018 03:04:07 -0400
Message-Id: <1533107047-16704-1-git-send-email-l.subrahmanya@mobiveil.co.in>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds missing support for compilation of Mobiveil PCIe Host
Bridge IP driver.

Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
 drivers/pci/controller/Kconfig  | 6 ++++++
 drivers/pci/controller/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index cc9fa02..ce26d7a 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -186,6 +186,12 @@ config PCIE_ALTERA_MSI
 	  Say Y here if you want PCIe MSI support for the Altera FPGA.
 	  This MSI driver supports Altera MSI to GIC controller IP.
 
+config PCIE_MOBIVEIL
+       bool "Mobiveil AXI PCIe host bridge support"
+       help
+         Say 'Y' here if you want kernel to support the Mobiveil AXI PCIe
+         Host Bridge driver.
+
 config PCI_HOST_THUNDER_PEM
 	bool "Cavium Thunder PCIe controller to off-chip devices"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 24322b9..7c20553 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
 obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
+obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
 obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
 obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
-- 
1.8.3.1
