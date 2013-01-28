Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58262 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab3A1S5A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:57:00 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 12/27] clk: mvebu: add more PCIe clocks for Armada XP
Date: Mon, 28 Jan 2013 19:56:21 +0100
Message-Id: <1359399397-29729-13-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
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

