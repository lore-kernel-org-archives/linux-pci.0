Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53572 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934922Ab3CZQSx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:18:53 -0400
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
	Andrew Murray <andrew.murray@arm.com>,
	Mike Turquette <mturquette@linaro.org>
Subject: [PATCHv6 06/17] clk: mvebu: create parent-child relation for PCIe clocks on Armada 370
Date: Tue, 26 Mar 2013 17:18:28 +0100
Message-Id: <1364314719-1049-7-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Armada 370 has two gatable clocks for each PCIe interface, and we
want both of them to be enabled. We therefore make one of the two
clocks a child of the other, as we did for the sataX and sataXlnk
clocks on Armada XP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/mvebu/clk-gating-ctrl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index ebf141d..b35785a 100644
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

