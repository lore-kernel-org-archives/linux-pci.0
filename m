Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:50355 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbeHCQfc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Aug 2018 12:35:32 -0400
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Cc: Nadav Haklai <nadavh@marvell.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 4/6] PCI: mvebu: use resource_size() to remap I/O space
Date: Fri,  3 Aug 2018 16:38:46 +0200
Message-Id: <20180803143848.21551-5-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
References: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of hardcoding the remapping of IO_SPACE_LIMIT - SZ_64K, use
resource_size(), as suggested by Lorenzo Pieralisi.

However, we cannot use just IO_SPACE_LIMIT, because pci_ioremap_io()
has a bug (which will be fixed separately) and doesn't allow remapping
the last 64 KB before IO_SPACE_LIMIT, so we ensure that we do not
exceed this limit. A separate patch will be sent to fix the
pci_ioremap_io() issue, and once it is merged, we will be able to drop
this work-around. Note that this workaround already existed, since we
were mapping only up to IO_SPACE_LIMIT - SZ_64K.

Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 9aa224f2f009..05f863435e5e 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1218,10 +1218,10 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		pcie->realio.flags = pcie->io.flags;
 		pcie->realio.start = PCIBIOS_MIN_IO;
 		pcie->realio.end = min_t(resource_size_t,
-					 IO_SPACE_LIMIT,
+					 IO_SPACE_LIMIT - SZ_64K,
 					 resource_size(&pcie->io) - 1);
 
-		for (i = 0; i < (IO_SPACE_LIMIT - SZ_64K); i += SZ_64K)
+		for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
 			pci_ioremap_io(i, pcie->io.start + i);
 	} else
 		pcie->realio = pcie->io;
-- 
2.14.4
