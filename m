Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933999AbcJZSBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 14:01:23 -0400
Subject: [PATCH 2/5] PCI: Extract link speed & width retrieval from
 pcie_get_minimum_link()
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Oct 2016 12:01:22 -0600
Message-ID: <20161026180122.23495.26258.stgit@gimli.home>
In-Reply-To: <20161026175156.23495.12980.stgit@gimli.home>
References: <20161026175156.23495.12980.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c   |   26 ++++++++++++++++++++------
 include/linux/pci.h |    2 ++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b901ee7..6d6cf89 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4729,6 +4729,25 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
+int pcie_get_link(struct pci_dev *dev, enum pci_bus_speed *speed,
+		  enum pcie_link_width *width)
+{
+	int ret;
+	u16 lnksta;
+
+	ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	if (ret)
+		return ret;
+
+	if (speed)
+		*speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
+	if (width)
+		*width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
+					PCI_EXP_LNKSTA_NLW_SHIFT;
+
+	return 0;
+}
+
 /**
  * pcie_get_minimum_link - determine minimum link settings of a PCI device
  * @dev: PCI device to query
@@ -4747,18 +4766,13 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 	*width = PCIE_LNK_WIDTH_UNKNOWN;
 
 	while (dev) {
-		u16 lnksta;
 		enum pci_bus_speed next_speed;
 		enum pcie_link_width next_width;
 
-		ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		ret = pcie_get_link(dev, &next_speed, &next_width);
 		if (ret)
 			return ret;
 
-		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
-		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
-			PCI_EXP_LNKSTA_NLW_SHIFT;
-
 		if (next_speed < *speed)
 			*speed = next_speed;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c3248d5..fbfbb40 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1026,6 +1026,8 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 int pcie_set_mps(struct pci_dev *dev, int mps);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
+int pcie_get_link(struct pci_dev *dev, enum pci_bus_speed *speed,
+		  enum pcie_link_width *width);
 int __pci_reset_function(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);

