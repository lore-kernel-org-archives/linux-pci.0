Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37551 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbcBIOwi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 09:52:38 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 3/3] PCI: tegra: Remove misleading PHYS_OFFSET
Date: Tue,  9 Feb 2016 15:52:33 +0100
Message-Id: <1455029553-9460-3-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1455029553-9460-1-git-send-email-thierry.reding@gmail.com>
References: <1455029553-9460-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

BARs are disabled when the size register is 0, so it's misleading to
write a base address into the start register.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index f6fc54b48606..9d5817546425 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -774,7 +774,7 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
 	afi_writel(pcie, 0, AFI_FPCI_BAR5);
 
 	/* map all upstream transactions as uncached */
-	afi_writel(pcie, PHYS_OFFSET, AFI_CACHE_BAR0_ST);
+	afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
 	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
 	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
 	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
-- 
2.7.1

