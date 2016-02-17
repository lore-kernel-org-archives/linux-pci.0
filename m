Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21584 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423083AbcBQXpl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Feb 2016 18:45:41 -0500
From: Andi Kleen <andi@firstfloor.org>
To: bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86, pci: Add quirk for unsizeable Broadwell EP bar
Date: Wed, 17 Feb 2016 15:45:28 -0800
Message-Id: <1455752728-29958-1-git-send-email-andi@firstfloor.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Andi Kleen <ak@linux.intel.com>

The Home Agent and PCU PCI devices in Broadwell-EP have a BAR that returns a
non zero value when read, but is still not sizeable (because it doesn't
exist).  This causes several [Firmware error] messages at boot. It does
not cause any functional problems, as the devices really have no BARs.

Add a PCI quirk to shut off the messages.

v2: Handle all BARs, not just BAR0 (Chaohong Guo)
v3: Switch to patching bus ops
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/pci/fixup.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e585655..4fcb5d5 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -540,3 +540,48 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
         }
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
+
+/*
+ * Intel Broadwell EP. Prevent reading/updating BARs on Home Agent and PCU devices
+ * which are not real BARs, but still return non-null.
+ * This prevents a harmless warning message at boot.
+ */
+
+static inline bool bdwep_bad_bars(unsigned devfn, int where)
+{
+	return ((PCI_SLOT(devfn) == 0x12 && PCI_FUNC(devfn) == 0) ||
+		(PCI_SLOT(devfn) == 0x1e && PCI_FUNC(devfn) == 3)) &&
+		where >= 0x10 && where <= 0x24;
+}
+
+static int quirk_bdwep_bar_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
+{
+	if (bdwep_bad_bars(devfn, where)) {
+		*value = 0;
+		return 0;
+	}
+
+	return raw_pci_read(pci_domain_nr(bus), bus->number,
+			    devfn, where, size, value);
+}
+
+static int quirk_bdwep_bar_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
+{
+	if (bdwep_bad_bars(devfn, where))
+		return 0;
+
+	return raw_pci_write(pci_domain_nr(bus), bus->number,
+			     devfn, where, size, value);
+}
+
+static struct pci_ops quirk_bdwep_bar_ops = {
+	.read = quirk_bdwep_bar_read,
+	.write = quirk_bdwep_bar_write,
+};
+
+static void pci_bdwep_bar(struct pci_dev *dev)
+{
+	pci_bus_set_ops(dev->bus, &quirk_bdwep_bar_ops);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_bar);
-- 
2.5.0

