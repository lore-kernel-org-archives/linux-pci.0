Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andi Kleen <andi@firstfloor.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86, pci: Add quirk for unsizeable Broadwell EP bar
Date: Fri, 15 Jan 2016 14:17:59 -0800
Message-Id: <1452896279-22034-1-git-send-email-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Andi Kleen <ak@linux.intel.com>

The Home Agent and PCU PCI devices in Broadwell-EP have a BAR that returns a
non zero value when read, but is still not sizeable (because it doesn't
exist).  This causes several [Firmware error] messages at boot. It does
not cause any functional problems, as the devices really have no BARs.

Add a PCI quirk to shut off the messages.

Since the message is printed before the normal header fixup add EARLY
fixups. This requires changing the PCI probe code to not override
the resource flags unconditionally, so that the quirk can set flags.

(I believe that's ok, they should be always zero before, but please double
check)

Also don't print the invalid BAR message for FIXED BARs.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/pci/fixup.c | 12 ++++++++++++
 drivers/pci/probe.c  |  8 +++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e585655..86bbdd6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -540,3 +540,15 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
         }
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
+
+/*
+ * Intel Broadwell EP. Prevent reading/updating BAR on Home Agent and PCU devices
+ * which are not real BARs, but still return non-null.
+ * This prevents a harmless warning message at boot.
+ */
+static void pci_bdwep_ha_bar(struct pci_dev *dev)
+{
+	dev->resource[0].flags |= IORESOURCE_PCI_FIXED;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_ha_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_ha_bar);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index edb1984..f7926e8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -214,7 +214,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		l = 0;
 
 	if (type == pci_bar_unknown) {
-		res->flags = decode_bar(dev, l);
+		res->flags |= decode_bar(dev, l);
 		res->flags |= IORESOURCE_SIZEALIGN;
 		if (res->flags & IORESOURCE_IO) {
 			l64 = l & PCI_BASE_ADDRESS_IO_MASK;
@@ -251,8 +251,10 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 	sz64 = pci_size(l64, sz64, mask64);
 	if (!sz64) {
-		dev_info(&dev->dev, FW_BUG "reg 0x%x: invalid BAR (can't size)\n",
-			 pos);
+		/* Don't print this message for a fixed BAR */
+		if (!(res->flags & IORESOURCE_PCI_FIXED))
+			dev_info(&dev->dev, FW_BUG "reg 0x%x: invalid BAR (can't size)\n",
+				 pos);
 		goto fail;
 	}
 
-- 
2.4.3
