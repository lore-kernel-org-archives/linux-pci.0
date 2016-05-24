Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:42690 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbcEXJch (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2016 05:32:37 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI/ASPM: Remove redundant check of pcie_set_clkpm
Date: Tue, 24 May 2016 17:32:10 +0800
Message-Id: <1464082330-22437-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Without supporting clock PM capable, if we want to disable
clkpm, we don't need this extra check as it already be zero for
the enable argument. And it's the same for enabling clkpm here.
So let's remove this check.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2dfe7fd..0ec649d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -139,7 +139,7 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 {
 	/* Don't enable Clock PM if the link is not Clock PM capable */
-	if (!link->clkpm_capable && enable)
+	if (!link->clkpm_capable)
 		enable = 0;
 	/* Need nothing if the specified equals to current state */
 	if (link->clkpm_enabled == enable)
-- 
2.3.7


