Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938811AbcJGQ1a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:27:30 -0400
Subject: [PATCH 3/3] PCI: rockchip: Remove unused platform data
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:27:26 -0500
Message-ID: <20161007162726.23835.51154.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162706.23835.10081.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162706.23835.10081.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The rockchip driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rockchip.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 0a89d02..b3548d0 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1019,8 +1019,8 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
 
 static int rockchip_pcie_probe(struct platform_device *pdev)
 {
-	struct rockchip_pcie *rockchip;
 	struct device *dev = &pdev->dev;
+	struct rockchip_pcie *rockchip;
 	struct pci_bus *bus, *child;
 	struct resource_entry *win;
 	resource_size_t io_base;
@@ -1083,8 +1083,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto err_vpcie;
 
-	platform_set_drvdata(pdev, rockchip);
-
 	rockchip_pcie_enable_interrupts(rockchip);
 
 	err = rockchip_pcie_init_irq_domain(rockchip);

