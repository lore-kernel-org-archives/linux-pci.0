Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34037 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933025AbdGSP3S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 11:29:18 -0400
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 053/102] PCI: tegra: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:57 +0200
Message-Id: <20170719152646.25903-54-p.zabel@pengutronix.de>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/pci/host/pci-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index b3722b7709df8..a64bd0a191767 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1147,15 +1147,15 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 
-	pcie->pex_rst = devm_reset_control_get(dev, "pex");
+	pcie->pex_rst = devm_reset_control_get_exclusive(dev, "pex");
 	if (IS_ERR(pcie->pex_rst))
 		return PTR_ERR(pcie->pex_rst);
 
-	pcie->afi_rst = devm_reset_control_get(dev, "afi");
+	pcie->afi_rst = devm_reset_control_get_exclusive(dev, "afi");
 	if (IS_ERR(pcie->afi_rst))
 		return PTR_ERR(pcie->afi_rst);
 
-	pcie->pcie_xrst = devm_reset_control_get(dev, "pcie_x");
+	pcie->pcie_xrst = devm_reset_control_get_exclusive(dev, "pcie_x");
 	if (IS_ERR(pcie->pcie_xrst))
 		return PTR_ERR(pcie->pcie_xrst);
 
-- 
2.11.0
