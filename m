Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:21603 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbbCYGjy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 02:39:54 -0400
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Scott Branden <sbranden@broadcom.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH 2/2] pci: iproc: change PCIE_IPROC_PLTFM to PCIE_IPROC_PLATFORM
Date: Tue, 24 Mar 2015 23:42:24 -0700
Message-ID: <1427265744-27590-3-git-send-email-rjui@broadcom.com>
In-Reply-To: <1427265744-27590-1-git-send-email-rjui@broadcom.com>
References: <1427265744-27590-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change the config name of the iProc PCIe platform bus driver from
PCIE_IPROC_PLTFM to PCIE_IPROC_PLATFORM

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/Kconfig  |    2 +-
 drivers/pci/host/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 963b507..1dfb567 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -115,7 +115,7 @@ config PCIE_IPROC
 	  iProc family of SoCs. An appropriate bus interface driver also needs
 	  to be enabled
 
-config PCIE_IPROC_PLTFM
+config PCIE_IPROC_PLATFORM
 	tristate "Broadcom iProc PCIe platform bus driver"
 	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
 	depends on OF
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 2e02d20..43e31d8 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -14,4 +14,4 @@ obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
 obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
-obj-$(CONFIG_PCIE_IPROC_PLTFM) += pcie-iproc-pltfm.o
+obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-pltfm.o
-- 
1.7.9.5

