Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:39611 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdKTNd1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2017 08:33:27 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/18] PCI: dwc: dra7xx: Help compiler to remove unused code
Date: Mon, 20 Nov 2017 14:32:12 +0100
Message-Id: <20171120133222.27771-10-niklas.cassel@axis.com>
In-Reply-To: <20171120133222.27771-1-niklas.cassel@axis.com>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dra7xx driver supports both host and ep mode.
When enabling support for only one of the modes, help the compiler
to remove code for the mode that we have not enabled in the driver.

By adding if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) return -ENODEV;
anything after that statement will get silently dropped by the compiler,
including static functions and structures that are referenced indirectly
from there.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 07c74ae3614e..224ff8affdce 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -694,6 +694,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
+		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
+			ret = -ENODEV;
+			goto err_gpio;
+		}
+
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_RC);
 		ret = dra7xx_add_pcie_port(dra7xx, pdev);
@@ -701,6 +706,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 			goto err_gpio;
 		break;
 	case DW_PCIE_EP_TYPE:
+		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_EP)) {
+			ret = -ENODEV;
+			goto err_gpio;
+		}
+
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_EP);
 
-- 
2.14.2
