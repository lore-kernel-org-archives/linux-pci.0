Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbdHKQ4o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2017 12:56:44 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 1/3] PCI: introduce pci_bus_wait_crs() function
Date: Fri, 11 Aug 2017 12:56:34 -0400
Message-Id: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Kernel is hiding Configuration Request Retry Status (CRS) inside
pci_bus_read_dev_vendor_id() function. We are looking to add support for
Function Level Reset (FLR) where vendor id read returns ~0.

Move CRS handling into its own function so that it can be called from other
places as well.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.h   |  2 ++
 drivers/pci/probe.c | 44 ++++++++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 22e0617..1bbe851 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -235,6 +235,8 @@ enum pci_bar_type {
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
 
+bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
+		      int crs_timeout);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
 int pci_setup_device(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c31310d..b1cb7bd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1824,29 +1824,17 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_alloc_dev);
 
-bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
-				int crs_timeout)
+bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l, int crs_timeout)
 {
 	int delay = 1;
 
-	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
-		return false;
-
-	/* some broken boards return 0 or ~0 if a slot is empty: */
-	if (*l == 0xffffffff || *l == 0x00000000 ||
-	    *l == 0x0000ffff || *l == 0xffff0000)
-		return false;
-
 	/*
 	 * Configuration Request Retry Status.  Some root ports return the
 	 * actual device ID instead of the synthetic ID (0xFFFF) required
 	 * by the PCIe spec.  Ignore the device ID and only check for
 	 * (vendor id == 1).
 	 */
-	while ((*l & 0xffff) == 0x0001) {
-		if (!crs_timeout)
-			return false;
-
+	do {
 		msleep(delay);
 		delay *= 2;
 		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
@@ -1858,6 +1846,34 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 			       PCI_FUNC(devfn));
 			return false;
 		}
+	} while ((*l & 0xffff) == 0x0001);
+
+	return true;
+}
+EXPORT_SYMBOL(pci_bus_wait_crs);
+
+bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+				int crs_timeout)
+{
+	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
+		return false;
+
+	/* some broken boards return 0 or ~0 if a slot is empty: */
+	if (*l == 0xffffffff || *l == 0x00000000 ||
+	    *l == 0x0000ffff || *l == 0xffff0000)
+		return false;
+
+	/*
+	 * Configuration Request Retry Status.  Some root ports return the
+	 * actual device ID instead of the synthetic ID (0xFFFF) required
+	 * by the PCIe spec.  Ignore the device ID and only check for
+	 * (vendor id == 1).
+	 */
+	if ((*l & 0xffff) == 0x0001) {
+		if (!crs_timeout)
+			return false;
+
+		return pci_bus_wait_crs(bus, devfn, l, crs_timeout);
 	}
 
 	return true;
-- 
1.9.1
