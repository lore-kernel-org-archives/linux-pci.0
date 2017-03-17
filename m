Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ca-mx01.263.net ([50.18.194.75]:19692 "EHLO smtphy.263.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdCQH51 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Mar 2017 03:57:27 -0400
Received: from transport.263xmail.com (unknown [38.83.106.156])
        by smtphy.263.net (Postfix) with ESMTPS id 42D8FA01D8
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2017 15:41:15 +0800 (CST)
Received: from lucky1.263xmail.com (unknown [192.168.165.164])
        by transportlucky.263xmail.com (Postfix) with ESMTP id 8A3CD4389
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2017 15:41:10 +0800 (CST)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: rockchip: Mark SLC bit as well as CCC bit for RC
Date: Fri, 17 Mar 2017 15:24:53 +0800
Message-Id: <1489735493-148838-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

lspci traces CCC to see if the end-2-end supports common
clock, so the current code should work as we mark the CCC bit
of RC. However, ASPM code actually check SLC bit of RC and try to
compare it with the downstream components' SLC instead. So when
enabling ASPM, CCC will be cleared after failing to match SLC with
the corresponding bit of downstream components. On one hand, from the
code of pcie_aspm_configure_common_clock, we could find that what we
actually need to set is SLC. On the other hand, we should also guarantee
that CCC should be marked w/o supporting ASPM. This patch fixes this
issue.

Cc: Brian Norris <briannorris@chromium.org>
Cc: jeffy.chen <jeffy.chen@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 26ddd35..7cd4d5c 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -596,7 +596,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	/* Set RC's clock architecture as common clock */
 	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
-	status |= PCI_EXP_LNKCTL_CCC;
+	status |= (PCI_EXP_LNKCTL_CCC | PCI_EXP_LNKSTA_SLC << 16);
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
 
 	/* Enable Gen1 training */
-- 
1.9.1
