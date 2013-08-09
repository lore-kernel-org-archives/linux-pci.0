Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:32961 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030994Ab3HIUKR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 16:10:17 -0400
From: Stephen Warren <swarren@wwwdotorg.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@nvidia.com>
Subject: [PATCH V3] ARM: tegra: disable LP2 cpuidle state if PCIe is enabled
Date: Fri,  9 Aug 2013 14:04:16 -0600
Message-Id: <1376078656-1378-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Warren <swarren@nvidia.com>

Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
this, simply disable LP2 if the PCI driver and DT node are both enabled.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I intend to apply this on top of Thierry's Tegra PCIe driver series.

v3: Only disable LP2 if a PCIe device that requests an interrupt is
actually present. This prevents the loss of power-saving when the WAR
isn't required.
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 12 ++++++++++++
 arch/arm/mach-tegra/cpuidle.c         | 10 ++++++++++
 arch/arm/mach-tegra/cpuidle.h         |  1 +
 drivers/pci/host/pci-tegra.c          |  5 +++++
 4 files changed, 28 insertions(+)

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
 
-- 
1.8.1.5

