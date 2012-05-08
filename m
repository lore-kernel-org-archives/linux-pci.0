Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:63303 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab2EHXqH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2012 19:46:07 -0400
Received: by yhgm50 with SMTP id m50so854179yhg.1
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2012 16:46:06 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 6B0061E004D
	for <linux-pci@vger.kernel.org>; Tue,  8 May 2012 16:46:06 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 195D0180170
	for <linux-pci@vger.kernel.org>; Tue,  8 May 2012 16:46:06 -0700 (PDT)
Subject: [PATCH 1/3] PCI: remove pci_bus_find_ext_capability() (unused)
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 08 May 2012 17:46:05 -0600
Message-ID: <20120508234605.2085.32267.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_bus_find_ext_capability() is unused, and this patch removes it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   |   43 -------------------------------------------
 include/linux/pci.h |    2 --
 2 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 111569c..69c21f0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -328,49 +328,6 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_ext_capability);
 
-/**
- * pci_bus_find_ext_capability - find an extended capability
- * @bus:   the PCI bus to query
- * @devfn: PCI device to query
- * @cap:   capability code
- *
- * Like pci_find_ext_capability() but works for pci devices that do not have a
- * pci_dev structure set up yet.
- *
- * Returns the address of the requested capability structure within the
- * device's PCI configuration space or 0 in case the device does not
- * support it.
- */
-int pci_bus_find_ext_capability(struct pci_bus *bus, unsigned int devfn,
-				int cap)
-{
-	u32 header;
-	int ttl;
-	int pos = PCI_CFG_SPACE_SIZE;
-
-	/* minimum 8 bytes per capability */
-	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
-
-	if (!pci_bus_read_config_dword(bus, devfn, pos, &header))
-		return 0;
-	if (header == 0xffffffff || header == 0)
-		return 0;
-
-	while (ttl-- > 0) {
-		if (PCI_EXT_CAP_ID(header) == cap)
-			return pos;
-
-		pos = PCI_EXT_CAP_NEXT(header);
-		if (pos < PCI_CFG_SPACE_SIZE)
-			break;
-
-		if (!pci_bus_read_config_dword(bus, devfn, pos, &header))
-			break;
-	}
-
-	return 0;
-}
-
 static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
 {
 	int rc, ttl = PCI_FIND_CAP_TTL;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e444f5b..0e0c489 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -707,8 +707,6 @@ enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *dev);
 int pci_find_capability(struct pci_dev *dev, int cap);
 int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
 int pci_find_ext_capability(struct pci_dev *dev, int cap);
-int pci_bus_find_ext_capability(struct pci_bus *bus, unsigned int devfn,
-				int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);

