Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:56597 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284AbaBLW5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Feb 2014 17:57:15 -0500
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] bus: mvebu-mbus: Fix incorrect size for PCI aperture resources
Date: Wed, 12 Feb 2014 15:57:07 -0700
Message-Id: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

reg[0] is the DT base, reg[1] is the DT length in bytes,
struct resource.end is the inclusive end address, so a -1 is
required.

Tested on kirkwood.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/bus/mvebu-mbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 2394e97..7fd54e9 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -876,14 +876,14 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
 	ret = of_property_read_u32_array(np, "pcie-mem-aperture", reg, ARRAY_SIZE(reg));
 	if (!ret) {
 		mem->start = reg[0];
-		mem->end = mem->start + reg[1];
+		mem->end = mem->start + reg[1] - 1;
 		mem->flags = IORESOURCE_MEM;
 	}
 
 	ret = of_property_read_u32_array(np, "pcie-io-aperture", reg, ARRAY_SIZE(reg));
 	if (!ret) {
 		io->start = reg[0];
-		io->end = io->start + reg[1];
+		io->end = io->start + reg[1] - 1;
 		io->flags = IORESOURCE_IO;
 	}
 }
-- 
1.8.1.2

