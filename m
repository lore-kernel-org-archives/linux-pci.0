Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:56647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdFUVyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2017 17:54:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] PCI: versatile: fix another typo
Date: Wed, 21 Jun 2017 23:53:02 +0200
Message-Id: <20170621215323.3921382-4-arnd@arndb.de>
In-Reply-To: <20170621215323.3921382-1-arnd@arndb.de>
References: <20170621215323.3921382-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The struct members were added to the wrong variable:

drivers/pci/host/pci-versatile.c: In function 'versatile_pci_probe':
drivers/pci/host/pci-versatile.c:212:2: error: 'host' undeclared (first use in this function)

Fixes: 997995e1722a ("PCI: versatile: Drop pci_fixup_irqs()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-versatile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index f572c921cdd4..f6fcec6b5578 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -209,8 +209,8 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	bridge->sysdata = NULL;
 	bridge->busnr = 0;
 	bridge->ops = &pci_versatile_ops;
-	host->map_irq = of_irq_parse_and_map_pci;
-	host->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0)
-- 
2.9.0
