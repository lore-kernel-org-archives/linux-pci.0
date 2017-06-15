Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35822 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdFOGWq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2017 02:22:46 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: kishon@ti.com, bhelgaas@google.com
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: dwc: dra7xx: Fix compilation warning.
Date: Thu, 15 Jun 2017 11:52:13 +0530
Message-Id: <673ccda2e1a722fa1b511a9c3bf1af6fbfc262a3.1497507582.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_msi_interrupts’:
drivers/pci/dwc/pci-dra7xx.c:177:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
       ~LEG_EP_INTERRUPTS & ~MSI);
       ^
drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_wrapper_interrupts’:
drivers/pci/dwc/pci-dra7xx.c:187:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
       ~INTERRUPTS);

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Changes in v2:
             Add casts in the definitions.
---
 drivers/pci/dwc/pci-dra7xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 8decf46..0286d6d 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -48,7 +48,7 @@
 #define	LINK_UP_EVT					BIT(12)
 #define	CFG_BME_EVT					BIT(13)
 #define	CFG_MSE_EVT					BIT(14)
-#define	INTERRUPTS (ERR_SYS | ERR_FATAL | ERR_NONFATAL | ERR_COR | ERR_AXI | \
+#define	INTERRUPTS (u32)(ERR_SYS | ERR_FATAL | ERR_NONFATAL | ERR_COR | ERR_AXI | \
 			ERR_ECRC | PME_TURN_OFF | PME_TO_ACK | PM_PME | \
 			LINK_REQ_RST | LINK_UP_EVT | CFG_BME_EVT | CFG_MSE_EVT)
 
@@ -58,8 +58,8 @@
 #define	INTB						BIT(1)
 #define	INTC						BIT(2)
 #define	INTD						BIT(3)
-#define	MSI						BIT(4)
-#define	LEG_EP_INTERRUPTS (INTA | INTB | INTC | INTD)
+#define	MSI						(u32)(BIT(4))
+#define	LEG_EP_INTERRUPTS (u32)(INTA | INTB | INTC | INTD)
 
 #define	PCIECTRL_TI_CONF_DEVICE_TYPE			0x0100
 #define	DEVICE_TYPE_EP					0x0
-- 
1.9.1
