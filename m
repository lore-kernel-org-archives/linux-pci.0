Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33449 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbdEOM01 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 08:26:27 -0400
From: Peter Robinson <pbrobinson@gmail.com>
To: kishon@ti.com, bhelgaas@google.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] pci: dwc: dra7xx: Depend on appropriate SoC or compile test
Date: Mon, 15 May 2017 13:26:17 +0100
Message-Id: <20170515122617.20706-1-pbrobinson@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI controller attached to a SoC isn't much use if the core SoC isn't
enabled, unless of course it's compile testing, so add appropriate dependency.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/pci/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index b7e15526d676..d34b6dfbb351 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -16,6 +16,7 @@ config PCIE_DW_EP
 
 config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
+	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on (PCI && PCI_MSI_IRQ_DOMAIN) || PCI_ENDPOINT
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	help
-- 
2.13.0
