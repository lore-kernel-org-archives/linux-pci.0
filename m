Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48175 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757019AbcAMLZi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jan 2016 06:25:38 -0500
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 4/4] pci: Blacklist vpd access for buggy devices
Date: Wed, 13 Jan 2016 12:25:35 +0100
Message-Id: <1452684335-46107-5-git-send-email-hare@suse.de>
In-Reply-To: <1452684335-46107-1-git-send-email-hare@suse.de>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Babu Moger <babu.moger@oracle.com>

Reading or Writing of PCI VPD data causes system panic.
We saw this problem by running "lspci -vvv" in the beginning.
However this can be easily reproduced by running
 cat /sys/bus/devices/XX../vpd

As even a simple read on any VPD data triggers a system
lockup on certain cards this patch implements a PCI quirk
to disabling VPD acces altogether by setting the vpd length
to '0'.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/access.c |  5 ++++-
 drivers/pci/quirks.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 914e023..82f41a8 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -396,7 +396,7 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
 	if (pos < 0)
 		return -EINVAL;
 
-	if (!vpd->valid) {
+	if (!vpd->valid && vpd->base.len > 0) {
 		vpd->valid = true;
 		vpd->base.len = pci_vpd_pci22_size(dev);
 	}
@@ -459,6 +459,9 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
 	loff_t end = pos + count;
 	int ret = 0;
 
+	if (vpd->base.len == 0)
+		return -EIO;
+
 	if (!vpd->valid)
 		return -EAGAIN;
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7e32730..af0f8a1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2123,6 +2123,47 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
 
 /*
+ * A read/write to sysfs entry ('/sys/bus/pci/devices/<id>/vpd')
+ * will dump 32k of data. The default length is set as 32768.
+ * Reading a full 32k will cause an access beyond the VPD end tag.
+ * The system behaviour at that point is mostly unpredictable.
+ * Apparently, some vendors have not implemented this VPD headers properly.
+ * Adding a generic function disable vpd data for these buggy adapters
+ * Add the DECLARE_PCI_FIXUP_FINAL line below with the specific with
+ * vendor and device of interest to use this quirk.
+ */
+static void quirk_blacklist_vpd(struct pci_dev *dev)
+{
+	if (dev->vpd) {
+		dev->vpd->len = 0;
+		dev_warn(&dev->dev, "PCI vpd access has been disabled due to firmware bug\n");
+	}
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f,
+		quirk_blacklist_vpd);
+
+/*
  * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
  * VPD end tag will hang the device.  This problem was initially
  * observed when a vpd entry was created in sysfs
-- 
1.8.5.6

