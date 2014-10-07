Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cmexedge1.emulex.com ([138.239.224.99]:32506 "EHLO
	CMEXEDGE1.ext.emulex.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751214AbaJGHCd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Oct 2014 03:02:33 -0400
From: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
To: <linux-pci@vger.kernel.org>
CC: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
Subject: [PATCH] pci: Limit VPD length of Emulex adapters to the actual length supported.
Date: Tue, 7 Oct 2014 12:30:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c67cd7f4-8d8f-48fc-a63c-dbdafde873a2@CMEXHTCAS1.ad.emulex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

By default pci utilities/subsystem tries to read 32k bytes of vpd data no matter
what the device supports. This can lead to unexpected behavior depending
on how each of the devices handle this condition. This patch fixes the
problem for Emulex adapter family.

Signed-off-by: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
---
 drivers/pci/quirks.c    |   35 +++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |   17 +++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 80c2d01..21b439f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3832,3 +3832,38 @@ void pci_dev_specific_enable_acs(struct pci_dev *dev)
 		}
 	}
 }
+
+#define SLI_INTF_REG_OFFSET     0x58
+#define SLI_INTF_FT_MASK        0x00000001
+static void quirk_elx_limit_vpd(struct pci_dev *dev)
+{
+	int virtfn;
+	u32 sli_intf;
+
+	pci_read_config_dword(dev, SLI_INTF_REG_OFFSET, &sli_intf);
+	virtfn = (sli_intf & SLI_INTF_FT_MASK) ? 1 : 0;
+
+	if (dev->vpd) {
+		if (virtfn)
+			dev->vpd->len = 0x200;
+		else
+			dev->vpd->len = 0x400;
+	}
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BE, PCI_DEVICE_ID_BE_ID1,
+			quirk_elx_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BE, PCI_DEVICE_ID_BE_ID2,
+			quirk_elx_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BE, PCI_DEVICE_ID_OC_BE2,
+			quirk_elx_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BE, PCI_DEVICE_ID_OC_BE3,
+			quirk_elx_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_OC_LANCER,
+			quirk_elx_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_OC_VF_LANCER,
+			quirk_elx_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_OC_SKYHAWK,
+			quirk_elx_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_OC_VF_SKYHAWK,
+			quirk_elx_limit_vpd);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 6ed0bb7..888041d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2971,4 +2971,21 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
+#define PCI_VENDOR_ID_BE		0x19a2
+#define PCI_VENDOR_ID_EMULEX		0x10df
+#define PCI_DEVICE_ID_BE_ID1		0x211
+#define PCI_DEVICE_ID_BE_ID2		0x221
+/* Device Id for BE2 cards */
+#define PCI_DEVICE_ID_OC_BE2		0x700
+/* Device Id for BE3 cards */
+#define PCI_DEVICE_ID_OC_BE3		0x710
+/* Device id for Lancer cards */
+#define PCI_DEVICE_ID_OC_LANCER		0xe220
+/* Device id for VF in Lancer */
+#define PCI_DEVICE_ID_OC_VF_LANCER	0xe228
+/* Device id for SkyHawk cards */
+#define PCI_DEVICE_ID_OC_SKYHAWK	0x720
+/* Device id for VF in SkyHawk */
+#define PCI_DEVICE_ID_OC_VF_SKYHAWK	0x728
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
1.7.1

