Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, alex.williamson@redhat.com
Subject: [PATCH V13 2/4] PCI: Factor out pci_bus_wait_crs()
Date: Sun, 27 Aug 2017 13:40:49 -0400
Message-Id: <1503855651-17409-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1503855651-17409-1-git-send-email-okaya@codeaurora.org>
References: <1503855651-17409-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Configuration Request Retry Status (CRS) was previously hidden inside
pci_bus_read_dev_vendor_id().  We want to add support for CRS in other
situations, such as waiting for a device to become ready after a Function
Level Reset.

Move CRS handling into pci_bus_wait_crs() so it can be called from other
places and also introduce pci_bus_crs_visibility_pending() to determine
when we should wait.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/probe.c | 52 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2849e0e..d834a20 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1824,30 +1824,29 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_alloc_dev);
 
-bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
-				int crs_timeout)
+static inline bool pci_bus_crs_visibility_pending(u32 l)
+{
+	return (l & 0xffff) == 0x0001;
+}
+
+static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 l,
+			     int timeout)
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
@@ -1857,12 +1856,29 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
