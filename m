Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:41008 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbdCTJno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2017 05:43:44 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: rockchip: set RC's RCB to 128 bytes
Date: Mon, 20 Mar 2017 17:39:40 +0800
Message-Id: <1490002780-67737-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Read Completion Boundary could be 64 bytes or 128 bytes
for rockchip RC. The reset value of RCB is zero which means
it doesn't support RCB to be 128 bytes, however it does support
that. When setting the RCB to 128 bytes, we see some significant
improvment for testing NVMe with libaio. So this patch will set
RC's RCB to 128 bytes.

Cc: Brian Norris <briannorris@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 26ddd35..8bcd417 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -599,6 +599,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	status |= PCI_EXP_LNKCTL_CCC;
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
 
+	/* Set RC's RCB to 128 */
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status |= PCI_EXP_LNKCTL_RCB;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
-- 
1.9.1
