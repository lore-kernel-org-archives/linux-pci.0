Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7899 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbcHHUTU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 16:19:20 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Date: Mon,  8 Aug 2016 14:19:02 -0600
Message-Id: <1470687542-30155-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a quirk for certain devices that require ignoring attention
and power indicators.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b69321c..b5bd7a0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4427,3 +4427,18 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
+
+/*
+ * The PCIe slot capabilities for Intel compatible Hot-swap backplane advertise
+ * attention and power indicators, but will do the wrong thing if used in a
+ * standard way. Ignore these.
+ */
+static void quirk_hsbp(struct pci_dev *pdev)
+{
+	pdev->ignore_aip = 1;
+	pdev->ignore_pip = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_hsbp);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_hsbp);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_hsbp);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_hsbp);
-- 
2.7.2

