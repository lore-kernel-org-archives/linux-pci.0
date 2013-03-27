Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33656 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab3C0SFK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 14:05:10 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [RFC PATCHv1 2/5] bus: mvebu: fix mistake in PCIe window target attribute for Kirkwood
Date: Wed, 27 Mar 2013 19:05:01 +0100
Message-Id: <1364407504-13524-3-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The target and attributes for the PCIe address decoding windows were
not correct on Kirkwood for the second PCIe interface.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Note: this patch should be merged with the existing mvebu-mbus driver.
---
 drivers/bus/mvebu-mbus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 586d03e..4de2c6b 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -626,7 +626,7 @@ static const struct mvebu_mbus_soc_data armada_xp_mbus_data = {
 
 static const struct mvebu_mbus_mapping kirkwood_map[] = {
 	MAPDEF("pcie0.0", 4, 0xe0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.0", 8, 0xe0, MAPDEF_PCIMASK),
+	MAPDEF("pcie1.0", 4, 0xd0, MAPDEF_PCIMASK),
 	MAPDEF("sram",    3, 0x01, MAPDEF_NOMASK),
 	MAPDEF("nand",    1, 0x2f, MAPDEF_NOMASK),
 	{},
-- 
1.7.9.5

