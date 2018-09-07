Return-Path: <SRS0=uotX=LV=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=uotX=LV=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	<linux-pci@vger.kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] x86/PCI: Apply VMD's AERSID fixup generically
Date: Fri,  7 Sep 2018 13:22:30 -0600
Message-Id: <1536348150-3535-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

A root port device-id changed between simulation and production. Rather
than match device-ids which may not be future-proof if left
unmaintained, match all root ports which exist in a VMD-domain

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/fixup.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 13f4485..30a5111 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -629,17 +629,11 @@ static void quirk_apple_mbp_poweroff(struct pci_dev *pdev)
 static void quirk_no_aersid(struct pci_dev *pdev)
 {
 	/* VMD Domain */
-	if (is_vmd(pdev->bus))
+	if (is_vmd(pdev->bus) && pci_is_root_bus(pdev->bus))
 		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334a, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334b, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334c, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334d, quirk_no_aersid);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 
-- 
1.8.3.1
