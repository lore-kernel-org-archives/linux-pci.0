Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <suravee.suthikulpanit@amd.com>
To: <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
	<jason@lakedaemon.net>
CC: <pawel.moll@arm.com>, <Catalin.Marinas@arm.com>,
	<Will.Deacon@arm.com>, <liviu.dudau@arm.com>, <tglx@linutronix.de>,
	<Harish.Kasiviswanathan@amd.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	"Suravee Suthikulpanit" <Suravee.Suthikulpanit@amd.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>
Subject: [PATCH 1/2 V7] irqchip: gic: Add support for multiple MSI for ARM64
Date: Wed, 17 Sep 2014 19:08:25 -0700
Message-ID: <1411006106-17339-2-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1411006106-17339-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1411006106-17339-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch implelments the ARM64 version of arch_setup_msi_irqs(),
which does not return 1 for when PCI_CAP_ID_MSI and nvec > 1.

Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>
Cc: Will Deacon <Will.Deacon@arm.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/arm64/kernel/Makefile |  1 +
 arch/arm64/kernel/msi.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 arch/arm64/kernel/msi.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index df7ef87..a921c42 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -29,6 +29,7 @@ arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
 arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
+arm64-obj-$(CONFIG_PCI_MSI)		+= msi.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/msi.c b/arch/arm64/kernel/msi.c
new file mode 100644
index 0000000..a295862
--- /dev/null
+++ b/arch/arm64/kernel/msi.c
@@ -0,0 +1,41 @@
+/*
+ * ARM64 architectural MSI implemention
+ *
+ * Support for Message Signalelled Interrupts for systems that
+ * implement ARM Generic Interrupt Controller: GICv2m.
+ *
+ * Copyright (C) 2014 Advanced Micro Devices, Inc.
+ * Authors: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+
+/*
+ * ARM64 function for seting up MSI irqs.
+ * Based on driver/pci/msi.c: arch_setup_msi_irqs().
+ *
+ * Note:
+ * Current implementation assumes that all interrupt controller used in
+ * ARM64 architecture _MUST_ supports multi-MSI.
+ */
+int arm64_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct msi_desc *entry;
+	int ret;
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		ret = arch_setup_msi_irq(dev, entry);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			return -ENOSPC;
+	}
+
+	return 0;
+}
-- 
1.9.3

