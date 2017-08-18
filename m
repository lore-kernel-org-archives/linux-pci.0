Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v11 0/4] PCI: Use CRS Software Visibility to wait for device
 to become ready
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 18 Aug 2017 16:31:56 -0500
Message-ID: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

This is another rev of Sinan's series to fix an FLR issue seen with an
Intel 750 NVMe drive.  It seems that the 750 requires more time than we
currently allow after the FLR to become ready for use.

The biggest remaining issue is that I *think* this does not fix the issue
on systems where CRS Software Visibility is not supported or disabled.

Differences from v10:
  - Move 0x0001 test inside pci_bus_wait_crs()
  - Fix pre-existing "valid response before timeout" bug
  - Add message if a device becomes ready after we printed "waiting"
  - Reorder messages so we print "giving up after X" instead of
    "not ready after X; giving up after X"

---

Bjorn Helgaas (1):
      PCI: Don't ignore valid response before CRS timeout

Sinan Kaya (3):
      PCI: Factor out pci_bus_wait_crs()
      PCI: Handle CRS ("device not ready") returned by device after FLR
      PCI: Warn periodically while waiting for device to become ready


 drivers/pci/pci.c   |   19 ++++++++++++++--
 drivers/pci/pci.h   |    1 +
 drivers/pci/probe.c |   61 +++++++++++++++++++++++++++++++++------------------
 3 files changed, 57 insertions(+), 24 deletions(-)


Incremental diff from Sinan's v10 posting:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c853551bc8d1..34c0aa1f37aa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3824,22 +3824,18 @@ static void pci_flr_wait(struct pci_dev *dev)
 	bool ret;
 
 	/*
-	 * Don't touch the HW before waiting 100ms. HW has to finish
-	 * within 100ms according to PCI Express Base Specification
-	 * Revision 3.1 Section 6.6.2: Function-Level Reset (FLR).
+	 * Per PCIe r3.1, sec 6.6.2, the device should finish FLR within
+	 * 100ms, but even after that, it may respond to config requests
+	 * with CRS status if it requires more time.
 	 */
 	msleep(100);
 
-	if (pci_bus_read_config_dword(dev->bus, dev->devfn, PCI_VENDOR_ID,
-				      &id))
+	if (pci_bus_read_config_dword(dev->bus, dev->devfn, PCI_VENDOR_ID, &id))
 		return;
 
-	/* See if we can find a device via CRS first. */
-	if ((id & 0xffff) == 0x0001) {
-		ret = pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
-		if (ret)
-			return;
-	}
+	ret = pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
+	if (ret)
+		return;
 
 	do {
 		msleep(100);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1bbe85190183..b0857052c04a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -235,8 +235,7 @@ enum pci_bar_type {
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
 
-bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
-		      int crs_timeout);
+bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l, int timeout);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
 int pci_setup_device(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f4cf7d0e25e..99799cc1de22 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1824,42 +1824,50 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_alloc_dev);
 
-bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l, int crs_timeout)
+bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l, int timeout)
 {
 	int delay = 1;
 
+	if ((*l & 0xffff) != 0x0001)
+		return true;	/* not a CRS completion */
+
+	if (!timeout)
+		return false;	/* CRS, but caller doesn't want to wait */
+
 	/*
-	 * Configuration Request Retry Status.  Some root ports return the
-	 * actual device ID instead of the synthetic ID (0xFFFF) required
-	 * by the PCIe spec.  Ignore the device ID and only check for
-	 * (vendor id == 1).
+	 * We got the reserved Vendor ID that indicates a completion with
+	 * Configuration Request Retry Status (CRS).  Retry until we get a
+	 * valid Vendor ID or we time out.
 	 */
-	do {
+	while ((*l & 0xffff) == 0x0001) {
 		msleep(delay);
 		delay *= 2;
-		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
+
+		if (delay > timeout) {
+			pr_warn("pci %04x:%02x:%02x.%d: not ready after %dms; giving up\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
 			return false;
+		}
 
 		if (delay >= 1000)
-			pr_info("pci %04x:%02x:%02x.%d: not responding since %dms still polling\n",
+			pr_info("pci %04x:%02x:%02x.%d: not ready after %dms; waiting\n",
 				pci_domain_nr(bus), bus->number,
-				PCI_SLOT(devfn), PCI_FUNC(devfn), delay);
+				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
 
-		/* Card hasn't responded in 60 seconds?  Must be stuck. */
-		if (delay > crs_timeout) {
-			pr_warn("pci %04x:%02x:%02x.%d: not responding %dms timeout reached\n",
-			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
-			       PCI_FUNC(devfn), crs_timeout);
+		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
 			return false;
-		}
-	} while ((*l & 0xffff) == 0x0001);
+	}
 
+	if (delay >= 1000)
+		pr_info("pci %04x:%02x:%02x.%d: ready after %dms\n",
+			pci_domain_nr(bus), bus->number,
+			PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
 	return true;
 }
-EXPORT_SYMBOL(pci_bus_wait_crs);
 
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
-				int crs_timeout)
+				int timeout)
 {
 	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
 		return false;
@@ -1869,20 +1877,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 	    *l == 0x0000ffff || *l == 0xffff0000)
 		return false;
 
-	/*
-	 * Configuration Request Retry Status.  Some root ports return the
-	 * actual device ID instead of the synthetic ID (0xFFFF) required
-	 * by the PCIe spec.  Ignore the device ID and only check for
-	 * (vendor id == 1).
-	 */
-	if ((*l & 0xffff) == 0x0001) {
-		if (!crs_timeout)
-			return false;
-
-		return pci_bus_wait_crs(bus, devfn, l, crs_timeout);
-	}
-
-	return true;
+	return pci_bus_wait_crs(bus, devfn, l, timeout);
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
