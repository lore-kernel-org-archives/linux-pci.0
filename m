Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34449 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbcDIVu5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Apr 2016 17:50:57 -0400
Received: by mail-lf0-f47.google.com with SMTP id j11so114548867lfb.1
        for <linux-pci@vger.kernel.org>; Sat, 09 Apr 2016 14:50:55 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>
Cc: linux-pci@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts when probing
Date: Sat,  9 Apr 2016 23:50:23 +0200
Message-Id: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some devices (e.g. Northstar ones) may have bridges that forward
harmless errors to the ARM core. In such case we need an option to
add a handler ignoring them.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt         |  6 ++++++
 drivers/pci/host/pcie-iproc-platform.c                  |  2 ++
 drivers/pci/host/pcie-iproc.c                           | 17 +++++++++++++++++
 drivers/pci/host/pcie-iproc.h                           |  1 +
 4 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index 01b88f4..c91b20a 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -22,6 +22,12 @@ Optional properties:
 
 - brcm,pcie-ob: Some iProc SoCs do not have the outbound address mapping done
 by the ASIC after power on reset. In this case, SW needs to configure it
+- brcm,pcie-hook-abort-handler: During PCI bus probing (device enumeration)
+  there can be errors that are expected and harmless. Unfortunately some bridges
+  can't be configured to ignore them and they forward them to the ARM core
+  triggering die().
+  This property should be set in such case, it will make driver add its own
+  handler ignoring such errors.
 
 If the brcm,pcie-ob property is present, the following properties become
 effective:
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 1738c52..7a6eb09 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -100,6 +100,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		pcie->need_ob_cfg = true;
 	}
 
+	pcie->hook_abort_handler = of_property_read_bool(np, "brcm,pcie-hook-abort-handler");
+
 	/* PHY use is optional */
 	pcie->phy = devm_phy_get(&pdev->dev, "pcie-phy");
 	if (IS_ERR(pcie->phy)) {
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index a576aee..a5b3816 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -433,6 +433,17 @@ static int iproc_pcie_map_ranges(struct iproc_pcie *pcie,
 	return 0;
 }
 
+#ifdef CONFIG_ARM
+static int iproc_pcie_abort_handler(unsigned long addr, unsigned int fsr,
+				    struct pt_regs *regs)
+{
+	if (fsr == 0x1406)
+		return 0;
+
+	return 1;
+}
+#endif
+
 static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
 {
 	struct device_node *msi_node;
@@ -498,6 +509,12 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	}
 
 #ifdef CONFIG_ARM
+	if (pcie->hook_abort_handler)
+		hook_fault_code(16 + 6, iproc_pcie_abort_handler, SIGBUS,
+				BUS_OBJERR, "imprecise external abort");
+#endif
+
+#ifdef CONFIG_ARM
 	pcie->sysdata.private_data = pcie;
 	sysdata = &pcie->sysdata;
 #else
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index e84d93c..9a0b58d 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -72,6 +72,7 @@ struct iproc_pcie {
 	struct phy *phy;
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	bool need_ob_cfg;
+	bool hook_abort_handler;
 	struct iproc_pcie_ob ob;
 	struct iproc_msi *msi;
 };
-- 
1.8.4.5

