Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] pci/vmd: Add quirk for aer to ignore source id
Date: Thu, 25 Aug 2016 17:26:11 -0600
Message-Id: <1472167571-11123-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1472167571-11123-1-git-send-email-jonathan.derrick@intel.com>
References: <1472167571-11123-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

VMD root ports change all source ids to the VMD device id. To find the
sender of the aer notification, we need to scan all child devices for
the aer sender, rather than relying on the source id from the message.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0359e0b..a10ce81 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4438,3 +4438,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,      0x2032, quirk_hsbp);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,      0x2033, quirk_hsbp);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PMC_Sierra, 0x8531, quirk_hsbp);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PMC_Sierra, 0x8533, quirk_hsbp);
+
+/*
+ * VMD enabled root ports will change the source id for all messages
+ * to the VMD device. Rather than doing device matching with the source
+ * id, the AER driver should traverse the child device tree, reading
+ * AER registers to find the faulting device.
+ */
+static void quirk_no_aersid(struct pci_dev *pdev)
+{
+	/* VMD Domain */
+	if (pdev->bus->sysdata && pci_domain_nr(pdev->bus) >= 0x10000)
+		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,      0x2030, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,      0x2031, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,      0x2032, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,      0x2033, quirk_no_aersid);
-- 
1.8.3.1
