Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34992 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934076AbcA0RyK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2016 12:54:10 -0500
Received: by mail-pa0-f41.google.com with SMTP id ho8so8144156pac.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Jan 2016 09:54:10 -0800 (PST)
From: Yang Shi <yang.shi@linaro.org>
To: Mingkai.Hu@freescale.com, Minghuan.Lian@freescale.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, yang.shi@linaro.org
Subject: [PATCH] PCI: layerscape: add ls2085a compatible
Date: Wed, 27 Jan 2016 09:32:05 -0800
Message-Id: <1453915925-19198-1-git-send-email-yang.shi@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The layerscape PCI host driver needs recognize ls2085a compatible when using
firmware with ls2085a compatible property, otherwise the PCI bus won't be
detected even though ls2085a compatible is included by the dts.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 drivers/pci/host/pci-layerscape.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 3923bed..c40d8b2 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -203,6 +203,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
 	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
 	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
-- 
2.0.2

