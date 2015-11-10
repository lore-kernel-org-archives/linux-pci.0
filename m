Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:16773 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbbKJVTr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2015 16:19:47 -0500
From: Babu Moger <babu.moger@oracle.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: Limit VPD length for megaraid_sas adapter
Date: Tue, 10 Nov 2015 16:19:32 -0500
Message-Id: <1447190372-149109-1-git-send-email-babu.moger@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resending again. Sorry if it is duplicate. My email client 
seems to have some issues.

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
 drivers/pci/quirks.c    |   49 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |   12 +++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b03373f..c32cd07 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2123,6 +2123,55 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
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
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_SAS1078R,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_SAS1078DE,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_VERDE_ZCR,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_SAS1078GEN2,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_SAS0079GEN2,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_SAS0073SKINNY,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_SAS0071SKINNY,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_FUSION,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_PLASMA,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_INVADER,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_LSI_FURY,
+		quirk_megaraid_sas_limit_vpd);
+
+/*
  * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
  * VPD end tag will hang the device.  This problem was initially
  * observed when a vpd entry was created in sysfs
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d9ba49c..20c5103 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -213,6 +213,18 @@
 #define PCI_DEVICE_ID_LSI_SAS1068E	0x0058
 #define PCI_DEVICE_ID_LSI_SAS1078	0x0060
 
+#define PCI_DEVICE_ID_LSI_SAS1078R              0x0060
+#define PCI_DEVICE_ID_LSI_SAS1078DE             0x007C
+#define PCI_DEVICE_ID_LSI_VERDE_ZCR             0x0413
+#define PCI_DEVICE_ID_LSI_SAS1078GEN2           0x0078
+#define PCI_DEVICE_ID_LSI_SAS0079GEN2           0x0079
+#define PCI_DEVICE_ID_LSI_SAS0073SKINNY         0x0073
+#define PCI_DEVICE_ID_LSI_SAS0071SKINNY         0x0071
+#define PCI_DEVICE_ID_LSI_FUSION                0x005b
+#define PCI_DEVICE_ID_LSI_PLASMA                0x002f
+#define PCI_DEVICE_ID_LSI_INVADER               0x005d
+#define PCI_DEVICE_ID_LSI_FURY                  0x005f
+
 #define PCI_VENDOR_ID_ATI		0x1002
 /* Mach64 */
 #define PCI_DEVICE_ID_ATI_68800		0x4158
-- 
1.7.1

