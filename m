Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33958 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbcF3NPH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 09:15:07 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: tegra: Stop setting pcibios_min_mem
Date: Thu, 30 Jun 2016 15:14:30 +0200
Message-Id: <20160630131430.32096-3-thierry.reding@gmail.com>
In-Reply-To: <20160630131430.32096-1-thierry.reding@gmail.com>
References: <20160630131430.32096-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

In practice this value will never be used and it hinders portability of
the driver, so remove it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index f04b062e8c67..bbf77a49517d 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2249,8 +2249,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	pcibios_min_mem = 0;
-
 	err = tegra_pcie_get_resources(pcie);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request resources: %d\n", err);
-- 
2.8.3

