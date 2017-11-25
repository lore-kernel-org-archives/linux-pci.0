Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19019 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbdKYTcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Nov 2017 14:32:45 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 3/9] ARM: tegra: Export tegra_cpuidle_pcie_irqs_in_use()
Date: Sun, 26 Nov 2017 01:02:07 +0530
Message-ID: <1511638333-22951-4-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra20 has a HW bug where PCIe interrupts are lost when LP2 (Tegra idle
state) is enabled. tegra_cpuidle_pcie_irqs_in_use() disables LP2 when
PCIe irq is mapped. EXPORT tegra_cpuidle_pcie_irqs_in_use() to allow Tegra
PCIe driver to be compiled as loadable kernel module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* commit message update

 arch/arm/mach-tegra/cpuidle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index 316563141add..7d7e6d3ce32d 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -57,3 +57,4 @@ void tegra_cpuidle_pcie_irqs_in_use(void)
 		break;
 	}
 }
+EXPORT_SYMBOL(tegra_cpuidle_pcie_irqs_in_use);
-- 
2.1.4
