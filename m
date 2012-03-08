Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58212 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584Ab2CHOvx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 09:51:53 -0500
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 04/11] regulator: tps6586x: fix typo in debug message
Date: Thu,  8 Mar 2012 15:51:24 +0100
Message-Id: <1331218291-16119-5-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/regulator/tps6586x-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index c75fb20..29b615c 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -383,7 +383,7 @@ static int __devinit tps6586x_regulator_probe(struct platform_device *pdev)
 	int id = pdev->id;
 	int err;
 
-	dev_dbg(&pdev->dev, "Probing reulator %d\n", id);
+	dev_dbg(&pdev->dev, "Probing regulator %d\n", id);
 
 	ri = find_regulator_info(id);
 	if (ri == NULL) {
-- 
1.7.9.3

