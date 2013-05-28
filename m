Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25570 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab3E1Skp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 May 2013 14:40:45 -0400
Subject: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search function
To: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	joro@8bytes.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: stephen@networkplumber.org, linux-pci@vger.kernel.org,
	ddutile@redhat.com
Date: Tue, 28 May 2013 12:40:20 -0600
Message-ID: <20130528184020.3318.7800.stgit@bling.home>
In-Reply-To: <20130528183527.3318.5365.stgit@bling.home>
References: <20130528183527.3318.5365.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some PCIe-to-PCI bridges are not fully compliant with the PCIe spec
and do not include a PCIe capability.  pci_is_pcie() is not useful on
these devices, making it difficult to determine where we transition
from a legacy PCI bus to a PCIe link.  PCI-core doesn't want a quirked
bridge test for fear of confusion that a PCIe capability would be
expected, so implement it in IOMMU code.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/Kconfig  |    3 ++
 drivers/iommu/Makefile |    1 +
 drivers/iommu/pci.c    |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/pci.h    |   23 ++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 drivers/iommu/pci.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c332fb9..a591794 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -2,6 +2,9 @@
 config IOMMU_API
 	bool
 
+config IOMMU_PCI
+	bool
+
 menuconfig IOMMU_SUPPORT
 	bool "IOMMU Hardware Support"
 	default y
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index ef0e520..f14d905 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
 obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
+obj-$(CONFIG_IOMMU_PCI) += pci.o
diff --git a/drivers/iommu/pci.c b/drivers/iommu/pci.c
new file mode 100644
index 0000000..c3cae8d
--- /dev/null
+++ b/drivers/iommu/pci.c
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2013 Red Hat, Inc.  All rights reserved.
+ * Author: Alex Williamson <alex.williamson@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/pci.h>
+
+bool iommu_pci_is_pcie_bridge(struct pci_dev *pdev)
+{
+	if (!pdev->subordinate)
+		return false;
+
+	if (pci_is_pcie(pdev))
+		return true;
+
+#ifdef CONFIG_PCI_QUIRKS
+	/*
+	 * If we're not on the root bus, look one device upstream of the
+	 * current device.  If that device is PCIe and is not a PCIe-to-PCI
+	 * bridge, then the current device is effectively PCIe as it must
+	 * be the PCIe-to-PCI bridge.  This handles several bridges that
+	 * violate the PCIe spec by not exposing a PCIe capability:
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=44881
+	 */
+	if (!pci_is_root_bus(pdev->bus)) {
+		struct pci_dev *parent = pdev->bus->self;
+
+		if (pci_is_pcie(parent) &&
+		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
+			return true;
+	}
+#endif
+	return false;
+}
+
+struct pci_dev *iommu_pci_find_upstream(struct pci_dev *pdev,
+					bool (*match)(struct pci_dev *),
+					struct pci_dev **last)
+{
+	*last = NULL;
+
+	if (match(pdev))
+		return pdev;
+
+	*last = pdev;
+
+	while (!pci_is_root_bus(pdev->bus)) {
+		*last = pdev;
+		pdev = pdev->bus->self;
+
+		if (match(pdev))
+			return pdev;
+	}
+
+	return NULL;
+}
diff --git a/drivers/iommu/pci.h b/drivers/iommu/pci.h
index 352d80a..cc6d58a 100644
--- a/drivers/iommu/pci.h
+++ b/drivers/iommu/pci.h
@@ -26,4 +26,27 @@ static inline void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
 	*from = to;
 }
 
+/**
+ * iommu_pci_is_pcie_bridge - Match a PCIe bridge device
+ * @pdev: device to test
+ *
+ * Return true if the given device is a PCIe bridge, false otherwise.
+ */
+bool iommu_pci_is_pcie_bridge(struct pci_dev *pdev);
+
+/**
+ * iommu_pci_find_upstream - Generic upstream search function
+ * @pdev: starting PCI device to search
+ * @match: match function to call on each device (true = match)
+ * @last: last device examined prior to returned device
+ *
+ * Walk upstream from the given device, calling match() at each
+ * device, including self.  Returns the first device matching match().
+ * If the root bus is reached without finding a match, return NULL.
+ * last returns the N-1 step in the search path.
+ */
+struct pci_dev *iommu_pci_find_upstream(struct pci_dev *pdev,
+					bool (*match)(struct pci_dev *),
+					struct pci_dev **last);
+
 #endif  /* __IOMMU_PCI_H */

