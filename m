Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48769 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbcKBWgE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Nov 2016 18:36:04 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Graf <agraf@suse.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/2] pci: export pcie_find_root_port
Date: Wed,  2 Nov 2016 16:35:51 -0600
Message-Id: <20161102223552.14776-1-jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Export pcie_find_root_port() so we can use it outside of PCIe-AER error
injection.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/pci/pcie/aer/aer_inject.c | 14 --------------
 include/linux/pci.h               | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index db553dc..2b6a592 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -307,20 +307,6 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	return 0;
 }
 
-static struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
-{
-	while (1) {
-		if (!pci_is_pcie(dev))
-			break;
-		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-			return dev;
-		if (!dev->bus->self)
-			break;
-		dev = dev->bus->self;
-	}
-	return NULL;
-}
-
 static int find_aer_device_iter(struct device *device, void *data)
 {
 	struct pcie_device **result = data;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e49f70..a38772a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1928,6 +1928,20 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
 	return (pcie_caps_reg(dev) & PCI_EXP_FLAGS_TYPE) >> 4;
 }
 
+static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
+{
+	while (1) {
+		if (!pci_is_pcie(dev))
+			break;
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+			return dev;
+		if (!dev->bus->self)
+			break;
+		dev = dev->bus->self;
+	}
+	return NULL;
+}
+
 void pci_request_acs(void);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
-- 
2.10.0

