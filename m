Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:4836 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751177AbaDKH7P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Apr 2014 03:59:15 -0400
From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
	<swarren@wwwdotorg.org>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] ARM: tegra: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Fri, 11 Apr 2014 15:56:40 +0800
Message-ID: <1397203000-16586-1-git-send-email-duanj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes coccinelle error regarding usage of IS_ERR and
PTR_ERR instead of PTR_ERR_OR_ZERO.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 drivers/pci/host/pci-tegra.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 330f7e3..e06ffa4 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1024,10 +1024,7 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
 		return PTR_ERR(pcie->afi_rst);
 
 	pcie->pcie_xrst = devm_reset_control_get(pcie->dev, "pcie_x");
-	if (IS_ERR(pcie->pcie_xrst))
-		return PTR_ERR(pcie->pcie_xrst);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
 }
 
 static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
-- 
1.8.3.1

