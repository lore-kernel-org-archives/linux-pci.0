Return-Path: <SRS0=NXC0=7T=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=NXC0=7T=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Keith Busch <keith.busch@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	David Fugate <david.fugate@intel.com>,
	<linux-kernel@vger.kernel.org>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 2/4] pci/x86: Move VMD quirks to x86 fixups
Date: Thu, 17 Aug 2017 12:10:12 -0600
Message-Id: <20170817181014.1257-3-jonathan.derrick@intel.com>
In-Reply-To: <20170817181014.1257-1-jonathan.derrick@intel.com>
References: <20170817181014.1257-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

VMD currently only exists for Intel x86 products

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/fixup.c | 18 ++++++++++++++++++
 drivers/pci/quirks.c | 17 -----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 11e4074..ca4b02e5 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -618,3 +618,21 @@ static void quirk_apple_mbp_poweroff(struct pci_dev *pdev)
 		dev_info(dev, "can't work around MacBook Pro poweroff issue\n");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
+
+/*
+ * VMD-enabled root ports will change the source ID for all messages
+ * to the VMD device. Rather than doing device matching with the source
+ * ID, the AER driver should traverse the child device tree, reading
+ * AER registers to find the faulting device.
+ */
+static void quirk_no_aersid(struct pci_dev *pdev)
+{
+	/* VMD Domain */
+	if (pdev->bus->sysdata && pci_domain_nr(pdev->bus) >= 0x10000)
+		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
+
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f1c9852..073baba 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4671,23 +4671,6 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
 
-/*
- * VMD-enabled root ports will change the source ID for all messages
- * to the VMD device. Rather than doing device matching with the source
- * ID, the AER driver should traverse the child device tree, reading
- * AER registers to find the faulting device.
- */
-static void quirk_no_aersid(struct pci_dev *pdev)
-{
-	/* VMD Domain */
-	if (pdev->bus->sysdata && pci_domain_nr(pdev->bus) >= 0x10000)
-		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
-
 /* FLR may cause some 82579 devices to hang. */
 static void quirk_intel_no_flr(struct pci_dev *dev)
 {
-- 
2.9.4
