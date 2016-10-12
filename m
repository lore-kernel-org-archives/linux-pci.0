Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37045 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932614AbcJLKy6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2016 06:54:58 -0400
Date: Wed, 12 Oct 2016 13:54:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [patch] PCI: rockchip: Indent an if statement
Message-ID: <20161012105409.GA19070@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The if statement wasn't intended.  Add a tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index b8c82fc..f54ef1e 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -972,7 +972,7 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
 		return -EINVAL;
 	if (region_no == 0) {
 		if (AXI_REGION_0_SIZE < (2ULL << num_pass_bits))
-		return -EINVAL;
+			return -EINVAL;
 	}
 	if (region_no != 0) {
 		if (AXI_REGION_SIZE < (2ULL << num_pass_bits))
