Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50789 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584Ab2CHOv5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 09:51:57 -0500
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 02/11] regulator: Support driver probe deferral
Date: Thu,  8 Mar 2012 15:51:22 +0100
Message-Id: <1331218291-16119-3-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

If we fail to locate a requested regulator return -EPROBE_DEFER. If drivers
pass this error code through to their caller (which they really should)
then this will ensure that the probe is retried later when further devices
become available.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
[G,Manjunath Kondaiah removed in order not to bother him]
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 drivers/regulator/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5a6b8ba..8a4b0a8 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1198,7 +1198,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 {
 	struct regulator_dev *rdev;
 	struct regulator_map *map;
-	struct regulator *regulator = ERR_PTR(-ENODEV);
+	struct regulator *regulator = ERR_PTR(-EPROBE_DEFER);
 	const char *devname = NULL;
 	int ret;
 
@@ -2926,7 +2926,7 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
 
 		if (!r) {
 			dev_err(dev, "Failed to find supply %s\n", supply);
-			ret = -ENODEV;
+			ret = -EPROBE_DEFER;
 			goto scrub;
 		}
 
-- 
1.7.9.3

