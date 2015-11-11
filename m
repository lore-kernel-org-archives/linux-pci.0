Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:25847 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbbKKPzP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2015 10:55:15 -0500
From: Babu Moger <babu.moger@oracle.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pci: Limit VPD length for megaraid_sas adapter
Date: Wed, 11 Nov 2015 10:54:57 -0500
Message-Id: <1447257297-198460-1-git-send-email-babu.moger@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes since v1 -> v2
Removed the changes in pci_id.h. Kept all the vendor
ids in quirks.c

Reading or Writing of PCI VPD data causes system panic.
We saw this problem by running "lspci -vvv" in the beginning.
However this can be easily reproduced by running
 cat /sys/bus/devices/XX../vpd

VPD length has been set as 32768 by default. Accessing vpd
will trigger read/write of 32k. This causes problem as we
could read data beyond the VPD end tag. Behaviour is un-
predictable when this happens. I see some other adapter doing
similar quirks(commit id bffadffd43d438c3143b8d172a463de89345b836)

I see there is an attempt to fix this right way.
https://patchwork.ozlabs.org/patch/534843/ or
https://lkml.org/lkml/2015/10/23/97

Tried to fix it this way, but problem is I dont see the proper
start/end TAGs(at least for this adapter) at all. The data is
mostly junk or zeros. This patch fixes the issue by setting the
vpd length to 0.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 drivers/pci/quirks.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b03373f..f739e47 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2123,6 +2123,44 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
 
 /*
+ * A read/write to sysfs entry ('/sys/bus/pci/devices/<id>/vpd')
+ * will dump 32k of data. The default length is set as 32768.
+ * Reading a full 32k will cause an access beyond the VPD end tag.
+ * The system behaviour at that point is mostly unpredictable.
+ * Also I dont believe vendors have implemented this VPD headers properly.
+ * Atleast I dont see it in following megaraid sas controller.
+ * That is why adding the quirk here.
+ */
+static void quirk_megaraid_sas_limit_vpd(struct pci_dev *dev)
+{
+	if (dev->vpd)
+		dev->vpd->len = 0;
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f,
+		quirk_megaraid_sas_limit_vpd);
+
+/*
  * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
  * VPD end tag will hang the device.  This problem was initially
  * observed when a vpd entry was created in sysfs
-- 
1.7.1

