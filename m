Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:53188 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab2GMV5q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jul 2012 17:57:46 -0400
Received: by mail-vb0-f74.google.com with SMTP id l22so388170vbn.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 14:57:45 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 8BB4C1E0043
	for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 14:57:45 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 4A7EC18004F
	for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 14:57:45 -0700 (PDT)
Subject: [PATCH 1/2] PCI: add pci_find_next_ext_capability()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 13 Jul 2012 15:57:45 -0600
Message-ID: <20120713215745.21756.79478.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120713215258.21756.42132.stgit@bhelgaas.mtv.corp.google.com>
References: <20120713215258.21756.42132.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some extended capabilities, e.g., the vendor-specific capability, can
occur several times.  The existing pci_find_ext_capability() always finds
the first occurrence.  This adds pci_find_next_ext_capability(), which can
iterate through all of them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   |   40 ++++++++++++++++++++++++++++++----------
 include/linux/pci.h |    3 +--
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 447e834..fa0aa94 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -278,20 +278,17 @@ int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap)
 }
 
 /**
- * pci_find_ext_capability - Find an extended capability
+ * pci_find_next_ext_capability - Find an extended capability
  * @dev: PCI device to query
+ * @start: address at which to start looking (0 to start at beginning of list)
  * @cap: capability code
  *
- * Returns the address of the requested extended capability structure
+ * Returns the address of the next matching extended capability structure
  * within the device's PCI configuration space or 0 if the device does
- * not support it.  Possible values for @cap:
- *
- *  %PCI_EXT_CAP_ID_ERR		Advanced Error Reporting
- *  %PCI_EXT_CAP_ID_VC		Virtual Channel
- *  %PCI_EXT_CAP_ID_DSN		Device Serial Number
- *  %PCI_EXT_CAP_ID_PWR		Power Budgeting
+ * not support it.  Some capabilities can occur several times, e.g., the
+ * vendor-specific capability, and this provides a way to find them all.
  */
-int pci_find_ext_capability(struct pci_dev *dev, int cap)
+int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
 {
 	u32 header;
 	int ttl;
@@ -303,6 +300,9 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
 	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
 		return 0;
 
+	if (start)
+		pos = start;
+
 	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
 		return 0;
 
@@ -314,7 +314,7 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
 		return 0;
 
 	while (ttl-- > 0) {
-		if (PCI_EXT_CAP_ID(header) == cap)
+		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
 			return pos;
 
 		pos = PCI_EXT_CAP_NEXT(header);
@@ -327,6 +327,26 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
+
+/**
+ * pci_find_ext_capability - Find an extended capability
+ * @dev: PCI device to query
+ * @cap: capability code
+ *
+ * Returns the address of the requested extended capability structure
+ * within the device's PCI configuration space or 0 if the device does
+ * not support it.  Possible values for @cap:
+ *
+ *  %PCI_EXT_CAP_ID_ERR		Advanced Error Reporting
+ *  %PCI_EXT_CAP_ID_VC		Virtual Channel
+ *  %PCI_EXT_CAP_ID_DSN		Device Serial Number
+ *  %PCI_EXT_CAP_ID_PWR		Power Budgeting
+ */
+int pci_find_ext_capability(struct pci_dev *dev, int cap)
+{
+	return pci_find_next_ext_capability(dev, 0, cap);
+}
 EXPORT_SYMBOL_GPL(pci_find_ext_capability);
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d8c379d..39d2fe0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -714,8 +714,7 @@ enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *dev);
 int pci_find_capability(struct pci_dev *dev, int cap);
 int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
 int pci_find_ext_capability(struct pci_dev *dev, int cap);
-int pci_bus_find_ext_capability(struct pci_bus *bus, unsigned int devfn,
-				int cap);
+int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);

