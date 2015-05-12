Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49883 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964808AbbELVbL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 May 2015 17:31:11 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: rjui@broadcom.com, bhelgaas@google.com, arnd@arndb.de
Cc: linux-pci@vger.kernel.org, sbranden@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, zajec5@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] PCI: iproc: make of_irq_parse_and_map_pci() configurable
Date: Tue, 12 May 2015 23:23:00 +0200
Message-Id: <1431465781-10753-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch makes the generic code not use the function
of_irq_parse_and_map_pci() always to get the irqs, but to take a
function the actual driver has provided.  This is needed to make this
function work with drivers not using device tree.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/pci/host/pcie-iproc-platform.c | 2 ++
 drivers/pci/host/pcie-iproc.c          | 2 +-
 drivers/pci/host/pcie-iproc.h          | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index afad6c2..c8aa06f 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -71,6 +71,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 
 	pcie->resources = &res;
 
+	pcie->map_irq = of_irq_parse_and_map_pci;
+
 	ret = iproc_pcie_setup(pcie);
 	if (ret) {
 		dev_err(pcie->dev, "PCIe controller setup failed\n");
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 329e1b5..cef31f6 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -229,7 +229,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
 
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
 	pci_bus_add_devices(bus);
 
 	return 0;
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index e28075e..a333d4b 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -34,6 +34,7 @@ struct iproc_pcie {
 	struct pci_bus *root_bus;
 	struct phy *phy;
 	int irqs[IPROC_PCIE_MAX_NUM_IRQS];
+	int (*map_irq)(const struct pci_dev *, u8, u8);
 };
 
 int iproc_pcie_setup(struct iproc_pcie *pcie);
-- 
2.1.4

