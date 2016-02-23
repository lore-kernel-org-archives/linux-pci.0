Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47969 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522AbcBWArD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 19:47:03 -0500
Subject: [PATCH v4 05/11] FIXME need bugzilla link
To: Hannes Reinecke <hare@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Feb 2016 18:47:00 -0600
Message-ID: <20160223004700.10635.41496.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Babu Moger <babu.moger@oracle.com>

PCI: Prevent VPD access for buggy devices

On some devices, reading or writing VPD data causes a system panic.
This can be easily reproduced by running "lspci -vvv" or
"cat /sys/bus/devices/XX../vpd".

Blacklist these devices so we don't access VPD data at all.

[bhelgaas: changelog, comment, drop pci/access.c changes]
Signed-off-by: Babu Moger <babu.moger@oracle.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
---
 drivers/pci/quirks.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0575a1e..626c3b2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2135,6 +2135,35 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
 
 /*
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
+		dev_warn(&dev->dev, FW_BUG "VPD access disabled\n");
+	}
+}
+
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
+
+/*
  * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
  * VPD end tag will hang the device.  This problem was initially
  * observed when a vpd entry was created in sysfs

