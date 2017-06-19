Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35478 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753795AbdFSJwN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 05:52:13 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: kishon@ti.com, bhelgaas@google.com
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] PCI: dwc: dra7xx: Fix incorrect usage of IRQSTATUS_* registers
Date: Mon, 19 Jun 2017 15:21:36 +0530
Message-Id: <9ebe7f77c2fd10219f78ecbae3c672064102444d.1497865713.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

'commit 47ff3de911a7 ("PCI: dra7xx: Add TI DRA7xx PCIe driver")' in order to clear
MSI and MAIN interrupts requests wrote '0' to PCIECTRL_TI_CONF_IRQSTATUS_MSI
and PCIECTRL_TI_CONF_IRQSTATUS_MAIN registers. However the TRM has mentioned to
write '1' to clear pending event in these two registers. Fix it here.

This also helps to get rid of the following compilation warning:
drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_msi_interrupts’:
drivers/pci/dwc/pci-dra7xx.c:177:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
       ~LEG_EP_INTERRUPTS & ~MSI);
       ^
drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_wrapper_interrupts’:
drivers/pci/dwc/pci-dra7xx.c:187:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
       ~INTERRUPTS);

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 8decf46..668dc15 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -174,7 +174,7 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
 static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 {
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
-			   ~LEG_EP_INTERRUPTS & ~MSI);
+			   LEG_EP_INTERRUPTS | MSI);
 
 	dra7xx_pcie_writel(dra7xx,
 			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
@@ -184,7 +184,7 @@ static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
 {
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
-			   ~INTERRUPTS);
+			   INTERRUPTS);
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
 			   INTERRUPTS);
 }
-- 
1.9.1
