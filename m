Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdHWE4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 00:56:20 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V12 3/5] PCI: Factor out pci_bus_wait_crs()
Date: Wed, 23 Aug 2017 00:56:09 -0400
Message-Id: <1503464171-6471-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
References: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Configuration Request Retry Status (CRS) was previously hidden inside
pci_bus_read_dev_vendor_id().  We want to add support for CRS in other
situations, such as waiting for a device to become ready after a Function
Level Reset.

Move CRS handling into pci_bus_wait_crs() so it can be called from other
places.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 46 ++++++++++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7fa583a..56d2515 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -239,6 +239,7 @@ static inline bool pci_bus_crs_visibility_pending(u32 l)
 {
 	return (l & 0xffff) == 0x0001;
 }
+bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 l, int timeout);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
 int pci_setup_device(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2849e0e..93b89dd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1824,30 +1824,23 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_alloc_dev);
 
-bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
-				int crs_timeout)
+bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 l, int timeout)
 {
 	int delay = 1;
 
-	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
-		return false;
+	if ((l & 0xffff) != 0x0001)
+		return true;	/* not a CRS completion */
 
-	/* some broken boards return 0 or ~0 if a slot is empty: */
-	if (*l == 0xffffffff || *l == 0x00000000 ||
-	    *l == 0x0000ffff || *l == 0xffff0000)
-		return false;
+	if (!timeout)
+		return false;	/* CRS, but caller doesn't want to wait */
 
 	/*
-	 * Configuration Request Retry Status.  Some root ports return the
-	 * actual device ID instead of the synthetic ID (0xFFFF) required
-	 * by the PCIe spec.  Ignore the device ID and only check for
-	 * (vendor id == 1).
+	 * We got the reserved Vendor ID that indicates a completion with
+	 * Configuration Request Retry Status (CRS).  Retry until we get a
+	 * valid Vendor ID or we time out.
 	 */
-	while ((*l & 0xffff) == 0x0001) {
-		if (!crs_timeout)
-			return false;
-
-		if (delay > crs_timeout) {
+	while ((l & 0xffff) == 0x0001) {
+		if (delay > timeout) {
 			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
 			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
 			       PCI_FUNC(devfn));
@@ -1857,12 +1850,29 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 		msleep(delay);
 		delay *= 2;
 
-		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
+		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
 			return false;
 	}
 
 	return true;
 }
+
+bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+				int timeout)
+{
+	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
+		return false;
+
+	/* some broken boards return 0 or ~0 if a slot is empty: */
+	if (*l == 0xffffffff || *l == 0x00000000 ||
+	    *l == 0x0000ffff || *l == 0xffff0000)
+		return false;
+
+	if (pci_bus_crs_visibility_pending(*l))
+		return pci_bus_wait_crs(bus, devfn, *l, timeout);
+
+	return true;
+}
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
 /*
-- 
1.9.1
