Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45792 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933295Ab3BLQ31 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:27 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: [PATCH 09/32] clk: mvebu: add more PCIe clocks for Armada XP
Date: Tue, 12 Feb 2013 17:28:43 +0100
Message-Id: <1360686546-24277-10-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current revision of the datasheet only mentions the gatable clocks
for the PCIe 0.0, 0.1, 0.2 and 0.3 interfaces, and forgot to mention
the ones for the PCIe 1.0, 1.1, 1.2, 1.3, 2.0 and 3.0
interfaces. After confirmation with Marvell engineers, this patch adds
the missing gatable clocks for those PCIe interfaces.

It also changes the name of the previously existing PCIe gatable
clocks, in order to match the naming using the datasheets.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/mvebu/clk-gating-ctrl.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index fd52b5f..24137f8 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -137,10 +137,14 @@ static const struct mvebu_soc_descr __initconst armada_xp_gating_descr[] = {
 	{ "ge2", NULL,  2 },
 	{ "ge1", NULL, 3 },
 	{ "ge0", NULL, 4 },
-	{ "pex0", NULL, 5 },
-	{ "pex1", NULL, 6 },
-	{ "pex2", NULL, 7 },
-	{ "pex3", NULL, 8 },
+	{ "pex00", NULL, 5 },
+	{ "pex01", NULL, 6 },
+	{ "pex02", NULL, 7 },
+	{ "pex03", NULL, 8 },
+	{ "pex10", NULL, 9 },
+	{ "pex11", NULL, 10 },
+	{ "pex12", NULL, 11 },
+	{ "pex13", NULL, 12 },
 	{ "bp", NULL, 13 },
 	{ "sata0lnk", NULL, 14 },
 	{ "sata0", "sata0lnk", 15 },
@@ -152,6 +156,8 @@ static const struct mvebu_soc_descr __initconst armada_xp_gating_descr[] = {
 	{ "xor0", NULL, 22 },
 	{ "crypto", NULL, 23 },
 	{ "tdm", NULL, 25 },
+	{ "pex20", NULL, 26 },
+	{ "pex30", NULL, 27 },
 	{ "xor1", NULL, 28 },
 	{ "sata1lnk", NULL, 29 },
 	{ "sata1", "sata1lnk", 30 },
-- 
1.7.9.5

