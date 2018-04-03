Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51699 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755253AbeDCJTF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2018 05:19:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id v21so32074861wmc.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Apr 2018 02:19:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@linaro.org>
To: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] PCI: kirin: Fix reset gpio name
Date: Tue,  3 Apr 2018 11:19:01 +0200
Message-Id: <1522747141-8299-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As documented in the device-tree bindings (pci/kirin-pcie.txt) and
defined in existing device-tree (hi3660.dtsi), the reset gpio name
is 'reset-gpios'. However, driver looks for a 'reset-gpio' resource
which makes the driver probe fail. Fix this.

Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/pci/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index dc3033c..efc317e 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -490,7 +490,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	kirin_pcie->gpio_id_reset = of_get_named_gpio(dev->of_node,
-						      "reset-gpio", 0);
+						      "reset-gpios", 0);
 	if (kirin_pcie->gpio_id_reset < 0)
 		return -ENODEV;
 
-- 
2.7.4
