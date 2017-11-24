Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3860 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753540AbdKXPyq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 10:54:46 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 04/10] ARM: tegra: EXPORT tegra_cpuidle_pcie_irqs_in_use()
Date: Fri, 24 Nov 2017 21:23:14 +0530
Message-ID: <1511538800-8275-5-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

EXPORT tegra_cpuidle_pcie_irqs_in_use() to allow Tegra PCIe driver to be
compiled as loadable kernel module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
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
