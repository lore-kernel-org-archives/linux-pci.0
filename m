Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44184 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417Ab3EFSDf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 May 2013 14:03:35 -0400
From: Jon Mason <jon.mason@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Workaround for NTB BAR size issue
Date: Mon,  6 May 2013 11:03:33 -0700
Message-Id: <1367863413-30087-1-git-send-email-jon.mason@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Certain NTB devices have a hardware errata where, regardless of
pre-configured value, reading the BAR size returns 4096.  To work around
this issue, add a PCI quirk to read the appropriate values from an
alternative register in PCI config space and move the resource endpoints
to the appropriate location.

Signed-off-by: Jon Mason <jon.mason@intel.com>
---
 drivers/pci/quirks.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7d68aee..a57a93b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2865,6 +2865,30 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f9, quirk_intel_mc_errata);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65fa, quirk_intel_mc_errata);
 
 
+/* Ivytown NTB BAR sizes are misreported by the hardware due to an errata.  To
+ * work around this, query the size it should be configured to by the device and
+ * modify the resource end to correspond to this new size.
+ */
+static void quirk_intel_ntb(struct pci_dev *dev)
+{
+	int rc;
+	u8 val;
+
+	rc = pci_read_config_byte(dev, 0x00D0, &val);
+	if (rc)
+		return;
+
+	dev->resource[2].end = dev->resource[2].start + ((u64) 1 << val) - 1;
+
+	rc = pci_read_config_byte(dev, 0x00D1, &val);
+	if (rc)
+		return;
+
+	dev->resource[4].end = dev->resource[4].start + ((u64) 1 << val) - 1;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e08, quirk_intel_ntb);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
+
 static ktime_t fixup_debug_start(struct pci_dev *dev,
 				 void (*fn)(struct pci_dev *dev))
 {
-- 
1.7.9.5

