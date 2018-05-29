Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:53400 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965398AbeE2RbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 May 2018 13:31:08 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: dwc: Do not let PCIE_DW_PLAT_HOST default to yes
Date: Tue, 29 May 2018 19:31:05 +0200
Message-Id: <1527615065-31389-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIE_DW_PLAT_HOST does not have any platform dependency, so it should
not default to yes.

Fixes: 1d906b22076e12cf ("PCI: dwc: Add support for EP mode")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/dwc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 16f52c626b4bd510..91b0194240a57e8f 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -58,7 +58,6 @@ config PCIE_DW_PLAT_HOST
 	depends on PCI && PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCIE_DW_PLAT
-	default y
 	help
 	  Enables support for the PCIe controller in the Designware IP to
 	  work in host mode. There are two instances of PCIe controller in
-- 
2.7.4
