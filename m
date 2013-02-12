Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45802 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933360Ab3BLQ31 (ORCPT
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
	Tawfik Bayouk <tawfik@marvell.com>,
	Mike Turquette <mturquette@linaro.org>
Subject: [PATCH 08/32] clk: mvebu: create parent-child relation for PCIe clocks on Armada 370
Date: Tue, 12 Feb 2013 17:28:42 +0100
Message-Id: <1360686546-24277-9-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Armada 370 has two gatable clocks for each PCIe interface: pexY
and pexY_en. In order for a PCIe interface to be functional, we need
both of them to be enabled. Since there are no conditions in which
having one clock enabled and not the other would be useful, we simply
make those two clocks have a child-parent relationship.

So, the pex0 clock becomes a child of pex0_en (for the PCIe interface
0), and pex1 becomes a child of pex1_en (for the PCIe interface
1). This way, the DT node for the PCIe interface 0 only needs to grab
a reference to pex0, and the DT node for the PCIe interface 1 only
needs to grab a reference to pex1.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/mvebu/clk-gating-ctrl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index 8fa5408..fd52b5f 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -119,8 +119,8 @@ static const struct mvebu_soc_descr __initconst armada_370_gating_descr[] = {
 	{ "pex1_en", NULL,  2 },
 	{ "ge1", NULL, 3 },
 	{ "ge0", NULL, 4 },
-	{ "pex0", NULL, 5 },
-	{ "pex1", NULL, 9 },
+	{ "pex0", "pex0_en", 5 },
+	{ "pex1", "pex1_en", 9 },
 	{ "sata0", NULL, 15 },
 	{ "sdio", NULL, 17 },
 	{ "tdm", NULL, 25 },
-- 
1.7.9.5

