Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755166AbcJLNEg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:04:36 -0400
Subject: [PATCH v2 1/2] PCI: rockchip: Remove unused platform data
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:04:24 -0500
Message-ID: <20161012130424.25212.24525.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012130256.25212.33689.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012130256.25212.33689.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The rockchip driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/host/pcie-rockchip.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index b8c82fc..59bf0db 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1091,8 +1091,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto err_vpcie;
 
-	platform_set_drvdata(pdev, rockchip);
-
 	rockchip_pcie_enable_interrupts(rockchip);
 
 	err = rockchip_pcie_init_irq_domain(rockchip);

