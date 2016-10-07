Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI/Quirks: Imply that other users can use the no-aer-sid quirk
Date: Fri,  7 Oct 2016 11:26:29 -0600
Message-Id: <1475861189-10794-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1475861189-10794-1-git-send-email-jonathan.derrick@intel.com>
References: <1475861189-10794-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Move the comment explaining the quirk to the quirk markup, so that other
devices can use the quirk without it being confused with a VMD-specific
action.
---
 drivers/pci/quirks.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 713035f..cee6526 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4430,17 +4430,18 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
 
+static void quirk_no_aersid(struct pci_dev *pdev)
+{
+	if (is_vmd(pdev->bus))
+		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
+}
+
 /*
  * VMD-enabled root ports will change the source ID for all messages
  * to the VMD device. Rather than doing device matching with the source
  * ID, the AER driver should traverse the child device tree, reading
  * AER registers to find the faulting device.
  */
-static void quirk_no_aersid(struct pci_dev *pdev)
-{
-	if (is_vmd(pdev->bus))
-		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
-}
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
-- 
1.8.3.1
