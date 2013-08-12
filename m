Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57848 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab3HLQAM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 12:00:12 -0400
From: Stephen Warren <swarren@wwwdotorg.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@nvidia.com>
Subject: [PATCH V4] ARM: tegra: disable LP2 cpuidle state if PCIe is enabled
Date: Mon, 12 Aug 2013 10:00:04 -0600
Message-Id: <1376323204-25952-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Warren <swarren@nvidia.com>

Tegra20 HW appears to have a bug such that PCIe device interrupts,
whether they are legacy IRQs or MSI, are lost when LP2 is enabled. To
work around this, simply disable LP2 if any PCIe devices with interrupts
are present. Detect this via the IRQ domain map operation. This is
slightly over-conservative; if a device with an interrupt is present but
the driver does not actually use them, LP2 will still be disabled.
However, this is a reasonable trade-off which enables a simpler
workaround.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
v4: Add missing tegra-cpuidle.h, re-write commit description. Add acks.

v3: Only disable LP2 if a PCIe device that requests an interrupt is
actually present. This prevents the loss of power-saving when the WAR
isn't required.
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 12 ++++++++++++
 arch/arm/mach-tegra/cpuidle.c         | 10 ++++++++++
 arch/arm/mach-tegra/cpuidle.h         |  1 +
 drivers/pci/host/pci-tegra.c          |  5 +++++
 include/linux/tegra-cpuidle.h         | 19 +++++++++++++++++++
 5 files changed, 47 insertions(+)
 create mode 100644 include/linux/tegra-cpuidle.h

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 706aa42..b82dcae 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -211,6 +211,18 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 }
 #endif
 
+/*
+ * Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
+ * they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
+ * this, simply disable LP2 if the PCI driver and DT node are both enabled.
+ */
+void tegra20_cpuidle_pcie_irqs_in_use(void)
+{
+	pr_info_once(
+		"Disabling cpuidle LP2 state, since PCIe IRQs are in use\n");
+	tegra_idle_driver.states[1].disabled = true;
+}
+
 int __init tegra20_cpuidle_init(void)
 {
 	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index e85973c..0961dfc 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -44,3 +44,13 @@ void __init tegra_cpuidle_init(void)
 		break;
 	}
 }
+
+void tegra_cpuidle_pcie_irqs_in_use(void)
+{
+	switch (tegra_chip_id) {
+	case TEGRA20:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
+			tegra20_cpuidle_pcie_irqs_in_use();
+		break;
+	}
+}
diff --git a/arch/arm/mach-tegra/cpuidle.h b/arch/arm/mach-tegra/cpuidle.h
index 9ec2c1a..c017dab 100644
--- a/arch/arm/mach-tegra/cpuidle.h
+++ b/arch/arm/mach-tegra/cpuidle.h
@@ -19,6 +19,7 @@
 
 #ifdef CONFIG_CPU_IDLE
 int tegra20_cpuidle_init(void);
+void tegra20_cpuidle_pcie_irqs_in_use(void);
 int tegra30_cpuidle_init(void);
 int tegra114_cpuidle_init(void);
 void tegra_cpuidle_init(void);
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index ad95c40..7356741 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -41,6 +41,7 @@
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/tegra-cpuidle.h>
 #include <linux/tegra-powergate.h>
 #include <linux/vmalloc.h>
 #include <linux/regulator/consumer.h>
@@ -636,6 +637,8 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
 	struct tegra_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
 
+	tegra_cpuidle_pcie_irqs_in_use();
+
 	return pcie->irq;
 }
 
@@ -1221,6 +1224,8 @@ static int tegra_msi_map(struct irq_domain *domain, unsigned int irq,
 	irq_set_chip_data(irq, domain->host_data);
 	set_irq_flags(irq, IRQF_VALID);
 
+	tegra_cpuidle_pcie_irqs_in_use();
+
 	return 0;
 }
 
diff --git a/include/linux/tegra-cpuidle.h b/include/linux/tegra-cpuidle.h
new file mode 100644
index 0000000..dda3647
--- /dev/null
+++ b/include/linux/tegra-cpuidle.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef __LINUX_TEGRA_CPUIDLE_H__
+#define __LINUX_TEGRA_CPUIDLE_H__
+
+void tegra_cpuidle_pcie_irqs_in_use(void);
+
+#endif
-- 
1.8.1.5

