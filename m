Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shell.v3.sk ([90.176.6.54]:36043 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbeIJQxs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Sep 2018 12:53:48 -0400
From: Lubomir Rintel <lkundrak@v3.sk>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/5] spi: pxa2xx: use an enum for type
Date: Mon, 10 Sep 2018 13:59:33 +0200
Message-Id: <20180910115935.163121-4-lkundrak@v3.sk>
In-Reply-To: <20180910115935.163121-1-lkundrak@v3.sk>
References: <20180910115935.163121-1-lkundrak@v3.sk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

That seems to be the correct type.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c   | 6 +++---
 include/linux/pxa2xx_ssp.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 14f4ea59caff..f674541675bb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1429,7 +1429,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct resource *res;
 	const struct acpi_device_id *adev_id = NULL;
 	const struct pci_device_id *pcidev_id = NULL;
-	int type;
+	enum pxa_ssp_type type;
 
 	adev = ACPI_COMPANION(&pdev->dev);
 
@@ -1443,9 +1443,9 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		return NULL;
 
 	if (adev_id)
-		type = (int)adev_id->driver_data;
+		type = (enum pxa_ssp_type)adev_id->driver_data;
 	else if (pcidev_id)
-		type = (int)pcidev_id->driver_data;
+		type = (enum pxa_ssp_type)pcidev_id->driver_data;
 	else
 		return NULL;
 
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 13b4244d44c1..262e1f318836 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -217,7 +217,7 @@ struct ssp_device {
 
 	const char	*label;
 	int		port_id;
-	int		type;
+	enum pxa_ssp_type type;
 	int		use_count;
 	int		irq;
 
-- 
2.17.1
