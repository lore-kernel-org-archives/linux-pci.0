Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 3/4] PCI/VPD: Move VPD quirks to vpd.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 17:26:53 -0500
Message-ID: <152098001296.37832.11829580700523667028.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Move the VPD-related quirks from quirks.c to vpd.c, which removes the need
for struct pci_vpd outside vpd.c.  The goal is to encapsulate all the VPD
code and structures in vpd.c.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |  121 --------------------------------------------------
 drivers/pci/vpd.c    |  120 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 121 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fc734014206f..fbe1127086c8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1967,31 +1967,6 @@ static void quirk_netmos(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NETMOS, PCI_ANY_ID,
 			 PCI_CLASS_COMMUNICATION_SERIAL, 8, quirk_netmos);
 
-/*
- * Quirk non-zero PCI functions to route VPD access through function 0 for
- * devices that share VPD resources between functions.  The functions are
- * expected to be identical devices.
- */
-static void quirk_f0_vpd_link(struct pci_dev *dev)
-{
-	struct pci_dev *f0;
-
-	if (!PCI_FUNC(dev->devfn))
-		return;
-
-	f0 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
-	if (!f0)
-		return;
-
-	if (f0->vpd && dev->class == f0->class &&
-	    dev->vendor == f0->vendor && dev->device == f0->device)
-		dev->dev_flags |= PCI_DEV_FLAGS_VPD_REF_F0;
-
-	pci_dev_put(f0);
-}
-DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
-			      PCI_CLASS_NETWORK_ETHERNET, 8, quirk_f0_vpd_link);
-
 static void quirk_e100_interrupt(struct pci_dev *dev)
 {
 	u16 command, pmcsr;
@@ -2182,83 +2157,6 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
 
-/*
- * If a device follows the VPD format spec, the PCI core will not read or
- * write past the VPD End Tag.  But some vendors do not follow the VPD
- * format spec, so we can't tell how much data is safe to access.  Devices
- * may behave unpredictably if we access too much.  Blacklist these devices
- * so we don't touch VPD at all.
- */
-static void quirk_blacklist_vpd(struct pci_dev *dev)
-{
-	if (dev->vpd) {
-		dev->vpd->len = 0;
-		pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
-	}
-}
-
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
-		quirk_blacklist_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
-
-/*
- * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
- * VPD end tag will hang the device.  This problem was initially
- * observed when a vpd entry was created in sysfs
- * ('/sys/bus/pci/devices/<id>/vpd').   A read to this sysfs entry
- * will dump 32k of data.  Reading a full 32k will cause an access
- * beyond the VPD end tag causing the device to hang.  Once the device
- * is hung, the bnx2 driver will not be able to reset the device.
- * We believe that it is legal to read beyond the end tag and
- * therefore the solution is to limit the read/write length.
- */
-static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
-{
-	/*
-	 * Only disable the VPD capability for 5706, 5706S, 5708,
-	 * 5708S and 5709 rev. A
-	 */
-	if ((dev->device == PCI_DEVICE_ID_NX2_5706) ||
-	    (dev->device == PCI_DEVICE_ID_NX2_5706S) ||
-	    (dev->device == PCI_DEVICE_ID_NX2_5708) ||
-	    (dev->device == PCI_DEVICE_ID_NX2_5708S) ||
-	    ((dev->device == PCI_DEVICE_ID_NX2_5709) &&
-	     (dev->revision & 0xf0) == 0x0)) {
-		if (dev->vpd)
-			dev->vpd->len = 0x80;
-	}
-}
-
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5706,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5706S,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5708,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5708S,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5709,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5709S,
-			quirk_brcm_570x_limit_vpd);
-
 static void quirk_brcm_5719_limit_mrrs(struct pci_dev *dev)
 {
 	u32 rev;
@@ -3417,25 +3315,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
 			quirk_thunderbolt_hotplug_msi);
 
-static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
-{
-	pci_set_vpd_size(dev, 8192);
-}
-
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x20, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x21, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x22, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x23, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x24, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x25, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x26, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x30, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x31, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x32, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x35, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x36, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x37, quirk_chelsio_extend_vpd);
-
 #ifdef CONFIG_ACPI
 /*
  * Apple: Shutdown Cactus Ridge Thunderbolt controller.
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 55477f24d8b9..901b0bedcc5d 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -497,3 +497,123 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 	return -ENOENT;
 }
 EXPORT_SYMBOL_GPL(pci_vpd_find_info_keyword);
+
+#ifdef CONFIG_PCI_QUIRKS
+/*
+ * Quirk non-zero PCI functions to route VPD access through function 0 for
+ * devices that share VPD resources between functions.  The functions are
+ * expected to be identical devices.
+ */
+static void quirk_f0_vpd_link(struct pci_dev *dev)
+{
+	struct pci_dev *f0;
+
+	if (!PCI_FUNC(dev->devfn))
+		return;
+
+	f0 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	if (!f0)
+		return;
+
+	if (f0->vpd && dev->class == f0->class &&
+	    dev->vendor == f0->vendor && dev->device == f0->device)
+		dev->dev_flags |= PCI_DEV_FLAGS_VPD_REF_F0;
+
+	pci_dev_put(f0);
+}
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+			      PCI_CLASS_NETWORK_ETHERNET, 8, quirk_f0_vpd_link);
+
+/*
+ * If a device follows the VPD format spec, the PCI core will not read or
+ * write past the VPD End Tag.  But some vendors do not follow the VPD
+ * format spec, so we can't tell how much data is safe to access.  Devices
+ * may behave unpredictably if we access too much.  Blacklist these devices
+ * so we don't touch VPD at all.
+ */
+static void quirk_blacklist_vpd(struct pci_dev *dev)
+{
+	if (dev->vpd) {
+		dev->vpd->len = 0;
+		pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
+
+/*
+ * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
+ * VPD end tag will hang the device.  This problem was initially
+ * observed when a vpd entry was created in sysfs
+ * ('/sys/bus/pci/devices/<id>/vpd').   A read to this sysfs entry
+ * will dump 32k of data.  Reading a full 32k will cause an access
+ * beyond the VPD end tag causing the device to hang.  Once the device
+ * is hung, the bnx2 driver will not be able to reset the device.
+ * We believe that it is legal to read beyond the end tag and
+ * therefore the solution is to limit the read/write length.
+ */
+static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
+{
+	/*
+	 * Only disable the VPD capability for 5706, 5706S, 5708,
+	 * 5708S and 5709 rev. A
+	 */
+	if ((dev->device == PCI_DEVICE_ID_NX2_5706) ||
+	    (dev->device == PCI_DEVICE_ID_NX2_5706S) ||
+	    (dev->device == PCI_DEVICE_ID_NX2_5708) ||
+	    (dev->device == PCI_DEVICE_ID_NX2_5708S) ||
+	    ((dev->device == PCI_DEVICE_ID_NX2_5709) &&
+	     (dev->revision & 0xf0) == 0x0)) {
+		if (dev->vpd)
+			dev->vpd->len = 0x80;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
+			PCI_DEVICE_ID_NX2_5706,
+			quirk_brcm_570x_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
+			PCI_DEVICE_ID_NX2_5706S,
+			quirk_brcm_570x_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
+			PCI_DEVICE_ID_NX2_5708,
+			quirk_brcm_570x_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
+			PCI_DEVICE_ID_NX2_5708S,
+			quirk_brcm_570x_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
+			PCI_DEVICE_ID_NX2_5709,
+			quirk_brcm_570x_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
+			PCI_DEVICE_ID_NX2_5709S,
+			quirk_brcm_570x_limit_vpd);
+
+static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
+{
+	pci_set_vpd_size(dev, 8192);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x20, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x21, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x22, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x23, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x24, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x25, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x26, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x30, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x31, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x32, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x35, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x36, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x37, quirk_chelsio_extend_vpd);
+#endif
