Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36752 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbcL2UpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2016 15:45:20 -0500
Received: by mail-lf0-f49.google.com with SMTP id t196so227449626lff.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2016 12:45:19 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc: artemi.ivanov@cogentembedded.com, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 2/2] rcar-pcie: set host bridge's DMA mask
Date: Thu, 29 Dec 2016 23:45:04 +0300
Message-Id: <1483044304-2085-2-git-send-email-nikita.yoush@cogentembedded.com>
In-Reply-To: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This gives platform DMA mapping code a chance to disallow setting device
DMA mask to something that host bridge can't support.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/pci/host/pcie-rcar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index aca85be..b1edc3c 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -451,6 +451,7 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	LIST_HEAD(res);
 
 	/* Try setting 5 GT/s link speed */
@@ -480,6 +481,10 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 
+	bridge = pci_find_host_bridge(bus);
+	bridge->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	bridge->dev.dma_mask = &bridge->dev.coherent_dma_mask;
+
 	pci_bus_add_devices(bus);
 
 	return 0;
-- 
2.1.4

