Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v11 2/4] PCI: Factor out pci_bus_wait_crs()
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 18 Aug 2017 16:32:10 -0500
Message-ID: <20170818213210.15145.15340.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Sinan Kaya <okaya@codeaurora.org>

Configuration Request Retry Status (CRS) was previously hidden inside
pci_bus_read_dev_vendor_id().  We want to add support for CRS in other
situations, such as waiting for a device to become ready after a Function
Level Reset.

Move CRS handling into pci_bus_wait_crs() so it can be called from other
places.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
[bhelgaas: move CRS reserved Vendor ID test into pci_bus_wait_crs(), remove
EXPORT_SYMBOL]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h   |    1 +
 drivers/pci/probe.c |   39 +++++++++++++++++++++++----------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 22e061738c6f..b0857052c04a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -235,6 +235,7 @@ enum pci_bar_type {
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
 
+bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l, int timeout);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
 int pci_setup_device(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 08ea844ac4ba..342a86640c6b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1824,33 +1824,26 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_alloc_dev);
 
-bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
-				int crs_timeout)
+bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l, int timeout)
 {
 	int delay = 1;
 
-	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
-		return false;
+	if ((*l & 0xffff) != 0x0001)
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
 	while ((*l & 0xffff) == 0x0001) {
-		if (!crs_timeout)
-			return false;
-
 		msleep(delay);
 		delay *= 2;
 
-		if (delay > crs_timeout) {
+		if (delay > timeout) {
 			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
 			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
 			       PCI_FUNC(devfn));
@@ -1863,6 +1856,20 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 
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
+	return pci_bus_wait_crs(bus, devfn, l, timeout);
+}
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
 /*


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
