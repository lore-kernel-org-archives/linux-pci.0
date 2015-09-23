Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38724 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934608AbbIWAKA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2015 20:10:00 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH] arm64/pci: Add quirks for Cavium Thunder PCI bridges.
Date: Tue, 22 Sep 2015 17:09:56 -0700
Message-Id: <1442966996-13419-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

The Cavium ThunderX SoC needs a PCI quirk for its on-chip bridges.
Since it is arm64, create a new quirks.c file there to contain arm64
related quirks.  Add the ThunderX bridge quirk, gated by a new config
variable, so that it can be disabled for kernels that aren't expected
to be used on ThunderX.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/Kconfig         | 11 +++++++++++
 arch/arm64/kernel/Makefile |  2 +-
 arch/arm64/kernel/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/quirks.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8bd55c5..7fdf94a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -359,6 +359,17 @@ config CAVIUM_ERRATUM_23154
 
 	  If unsure, say Y.
 
+config CAVIUM_THUNDER_PCI_QUIRKS
+	bool "Cavium PCI quirk workarounds"
+	depends on PCI
+	help
+
+	  Some ThunderX systems have PCI quirk workarounds that must
+	  be enabled to be able to use PCI devices.  This option
+	  enables the workarounds.
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc..f80aa01 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -33,7 +33,7 @@ arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
 arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
-arm64-obj-$(CONFIG_PCI)			+= pci.o
+arm64-obj-$(CONFIG_PCI)			+= pci.o quirks.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
 
diff --git a/arch/arm64/kernel/quirks.c b/arch/arm64/kernel/quirks.c
new file mode 100644
index 0000000..7352bd4
--- /dev/null
+++ b/arch/arm64/kernel/quirks.c
@@ -0,0 +1,36 @@
+/*
+ * PCIe quirks for arm64
+ *
+ * Copyright (C) 2015 Cavium, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/pci.h>
+
+#ifdef CONFIG_CAVIUM_THUNDER_PCI_QUIRKS
+static void thunder_bridge_fixup(struct pci_dev *dev)
+{
+	/*
+	 * This bridge is broken in that it doesn't have correct
+	 * resource ranges for the buses behind it.
+	 *
+	 * The upstream bus resources are a close enough approximation
+	 * to what is needed, that they can be used instead.  Copy
+	 * upstream root bus resources so that resource claiming for
+	 * downstream devices can be done.
+	 */
+	int resno;
+	struct pci_bus *bus = dev->subordinate;
+
+	for (resno = 0; resno < PCI_BRIDGE_RESOURCE_NUM; resno++) {
+		bus->resource[resno] =
+			pci_bus_resource_n(bus->parent,
+					   PCI_BRIDGE_RESOURCE_NUM + resno);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa002, thunder_bridge_fixup);
+#endif /* CONFIG_CAVIUM_THUNDER_PCI_QUIRKS */
-- 
1.9.1

