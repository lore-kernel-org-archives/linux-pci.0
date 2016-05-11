Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/2] x86/PCI: Add pci_bdwep_bar() quirk entry for Broadwell-EP Home Agent 1
Date: Wed, 11 May 2016 06:52:09 -0400
Message-Id: <1462963930-18506-2-git-send-email-prarit@redhat.com>
In-Reply-To: <1462963930-18506-1-git-send-email-prarit@redhat.com>
References: <1462963930-18506-1-git-send-email-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit b894157145e4 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having
non-compliant BARs") marks Home Agent 0 & PCU has having non-compliant
BARs.  The commit is missing device 0x6f60 for Home Agent 1.

The problem with these devices is documented in the Xeon v4 specification
update (but is unfortunately missing this ID):

BDF2
PCI BARs in the Home Agent Will Return Non-Zero Values During Enumeration
Problem:
During system initialization the Operating System may access the standard
PCI BARs (Base Address Registers). Due to this erratum, accesses to the
Home Agent BAR registers (Bus 1; Device 18; Function 0,4; Offsets (0x14-0x24)
will return non-zero values.
Implication:
The operating system may issue a warning. Intel has not observed any
functional failures due to this erratum.
Workaround:
None identified.

Link: http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
Fixes: b894157145e4 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having non-compliant BARs")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>

---
 arch/x86/pci/fixup.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b7de1929714b..6d8ab876b732 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -552,9 +552,18 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
 
+/*
+ * Broadwell EP Home Agent BARs erroneously return non-zero values
+ * during enumeration which cause bogus warnings during resource
+ * allocation.
+ *
+ *   See: http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
+ *   entry BDF2.
+ */
 static void pci_bdwep_bar(struct pci_dev *dev)
 {
 	dev->non_compliant_bars = 1;
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_bdwep_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_bar);
-- 
1.7.9.3
