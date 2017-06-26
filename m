Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:3779 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752193AbdFZNeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2017 09:34:17 -0400
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
CC: Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] PCI: mediatek: change to use pci_scan_root_bus_bridge()
Date: Mon, 26 Jun 2017 21:34:01 +0800
Message-ID: <1498484041-6181-2-git-send-email-ryder.lee@mediatek.com>
In-Reply-To: <1498484041-6181-1-git-send-email-ryder.lee@mediatek.com>
References: <1498484041-6181-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a critical patch fixes Build bot failed:
> 	arm-allmodconfig
> ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of
function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]

It uses the new registration methods pci_scan_root_bus_bridge().

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 3baafa8..514ef34 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -482,12 +482,10 @@ static int mtk_pcie_register_host(struct pci_host_bridge *host)
 	host->dev.parent = pcie->dev;
 	host->ops = &mtk_pcie_ops;
 
-	err = pci_register_host_bridge(host);
+	err = pci_scan_root_bus_bridge(host);
 	if (err < 0)
 		return err;
 
-	pci_scan_child_bus(host->bus);
-
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 	pci_bus_size_bridges(host->bus);
 	pci_bus_assign_resources(host->bus);
@@ -506,7 +504,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *host;
 	int err;
 
-	host = pci_alloc_host_bridge(sizeof(*pcie));
+	host = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
 	if (!host)
 		return -ENOMEM;
 
-- 
1.9.1
