Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cmexedge1.emulex.com ([138.239.224.99]:20492 "EHLO
	CMEXEDGE1.ext.emulex.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751287AbaJPItN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Oct 2014 04:49:13 -0400
From: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
To: <linux-pci@vger.kernel.org>
CC: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
Subject: [PATCH v1] pci: Limit VPD length of Emulex adapters to the actual length supported.
Date: Thu, 16 Oct 2014 14:16:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1f6d7b6c-7189-4fe3-926b-42609724cab9@CMEXHTCAS2.ad.emulex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

By default pci utilities/subsystem tries to read 32k bytes of vpd data no matter
what the device supports. This can lead to unexpected behavior depending
on how each of the devices handle this condition. This patch fixes the
problem for Emulex adapter family.

v1:
Addressed Bjorn's comments
1. Removed Vendor id and Device id macros from pci_ids.h and
   using the Vendor and Device id values directly in DECLARE_PCI_FIXUP_FINAL() lines.

Signed-off-by: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
---
 drivers/pci/quirks.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 80c2d01..95d88f3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3832,3 +3832,36 @@ void pci_dev_specific_enable_acs(struct pci_dev *dev)
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
+DECLARE_PCI_FIXUP_FINAL(0x19a2, 0x211, quirk_elx_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(0x19a2, 0x221, quirk_elx_limit_vpd);
+/* BE2 */
+DECLARE_PCI_FIXUP_FINAL(0x19a2, 0x700, quirk_elx_limit_vpd);
+/* BE3 */
+DECLARE_PCI_FIXUP_FINAL(0x19a2, 0x710, quirk_elx_limit_vpd);
+/* LANCER */
+DECLARE_PCI_FIXUP_FINAL(0x10df, 0xe220, quirk_elx_limit_vpd);
+/* LANCER VF */
+DECLARE_PCI_FIXUP_FINAL(0x10df, 0xe228, quirk_elx_limit_vpd);
+/* SKYHAWK */
+DECLARE_PCI_FIXUP_FINAL(0x10df, 0x720, quirk_elx_limit_vpd);
+/* SKYHAWK VF */
+DECLARE_PCI_FIXUP_FINAL(0x10df, 0x728, quirk_elx_limit_vpd);
-- 
1.7.1

