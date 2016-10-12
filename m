Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755195AbcJLNEs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:04:48 -0400
Subject: [PATCH v2 2/2] PCI: rockchip: Indent "if" statement body
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:04:37 -0500
Message-ID: <20161012130437.25212.34359.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012130256.25212.33689.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012130256.25212.33689.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

Body of an "if" statement wasn't indented.  Add a tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rockchip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 59bf0db..e0b22da 100644
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

