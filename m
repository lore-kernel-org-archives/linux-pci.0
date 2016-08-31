Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] PCI: Mark Haswell Power Control Unit as having
 non-compliant BARs
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Prarit Bhargava <prarit@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Andi Kleen <ak@linux.intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-kernel@vger.kernel.org
Date: Wed, 31 Aug 2016 10:50:09 -0500
Message-ID: <20160831155009.3216.93787.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Haswell Power Control Unit has a non-PCI register (CONFIG_TDP_NOMINAL)
where BAR 0 is supposed to be.  This is erratum HSE43 in the spec update
referenced below:

  The PCIe* Base Specification indicates that Configuration Space Headers
  have a base address register at offset 0x10.  Due to this erratum, the
  Power Control Unit's CONFIG_TDP_NOMINAL CSR (Bus 1; Device 30; Function
  3; Offset 0x10) is located where a base register is expected.

Mark the PCU as having non-compliant BARs so we don't try to probe any of
them.  There are no other BARs on this device.

Rename the quirk so it's not Broadwell-specific.

Link: http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
Link: https://bugzilla.kernel.org/show_bug.cgi?id=153881
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/fixup.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 837ea36..6d52b94 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -553,15 +553,21 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
 
 /*
- * Broadwell EP Home Agent BARs erroneously return non-zero values when read.
+ * Device [8086:2fc0]
+ * Erratum HSE43
+ * CONFIG_TDP_NOMINAL CSR Implemented at Incorrect Offset
+ * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
  *
- * See http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
- * entry BDF2.
+ * Devices [8086:6f60,6fa0,6fc0]
+ * Erratum BDF2
+ * PCI BARs in the Home Agent Will Return Non-Zero Values During Enumeration
+ * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
  */
-static void pci_bdwep_bar(struct pci_dev *dev)
+static void pci_invalid_bar(struct pci_dev *dev)
 {
 	dev->non_compliant_bars = 1;
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_bdwep_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
