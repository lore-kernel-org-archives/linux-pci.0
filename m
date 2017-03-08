Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33168 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdCHXjE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2017 18:39:04 -0500
Received: by mail-pg0-f49.google.com with SMTP id 25so18810550pgy.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2017 15:38:00 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/3] PCI: rockchip: fix sign issues for current limits
Date: Wed,  8 Mar 2017 15:37:46 -0800
Message-Id: <20170308233748.54706-1-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The regulator framework can return negative error codes via
regulator_get_current_limit() for regulators that don't provide current
information. The subsequent check for postive values isn't very useful,
if the variable is unsigned.

Let's just match the signedness of the return value.

Prevents error messages like this, seen on Samsung Chromebook Plus:

[    1.069372] rockchip-pcie f8000000.pcie: invalid power supply

Fixes: 4816c4c7b82b ("PCI: rockchip: Provide captured slot power limit and scale")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v4.11 candidate?

 drivers/pci/host/pcie-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 26ddd3535272..d785f64ec03b 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -425,7 +425,8 @@ static struct pci_ops rockchip_pcie_ops = {
 
 static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 {
-	u32 status, curr, scale, power;
+	int curr;
+	u32 status, scale, power;
 
 	if (IS_ERR(rockchip->vpcie3v3))
 		return;
-- 
2.12.0.246.ga2ecc84866-goog
