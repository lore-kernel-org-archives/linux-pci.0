Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33080 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752123AbaDRMUF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Apr 2014 08:20:05 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 6/7] bus: mvebu-mbus: allow several windows with the same target/attribute
Date: Fri, 18 Apr 2014 14:19:52 +0200
Message-Id: <1397823593-1932-7-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Having multiple windows with the same target and attribute is actually
legal, and can be useful for PCIe windows, when PCIe BARs have a size
that isn't a power of two, and we therefore need to create several
MBus windows to cover the PCIe BAR for a given PCIe interface.

Fixes: fddddb52a6c4e2438f4514ed979183653ca0732a ('bus: introduce an Marvell EBU MBus driver')
Cc: <stable@vger.kernel.org> # v3.10+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>
---
 drivers/bus/mvebu-mbus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index afee0f7..00b7344 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -223,12 +223,6 @@ static int mvebu_mbus_window_conflicts(struct mvebu_mbus_state *mbus,
 		 */
 		if ((u64)base < wend && end > wbase)
 			return 0;
-
-		/*
-		 * Check if target/attribute conflicts
-		 */
-		if (target == wtarget && attr == wattr)
-			return 0;
 	}
 
 	return 1;
-- 
1.9.2

