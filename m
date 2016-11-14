Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36400 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbcKNLQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2016 06:16:10 -0500
Received: by mail-wm0-f46.google.com with SMTP id g23so91575664wme.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 03:16:10 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc: robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v4 1/3] bus: simple-pm: add support to pm clocks
Date: Mon, 14 Nov 2016 11:15:53 +0000
Message-Id: <1479122155-13393-2-git-send-email-srinivas.kandagatla@linaro.org>
In-Reply-To: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support to pm clocks via device tree, so that the clocks
can be turned on and off during runtime pm. This patch is required for
Qualcomm msm8996 pcie controller which sits on a bus with its own
power-domain and clocks.

Without this patch the clock associated with the bus are never turned on.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/bus/simple-pm-bus.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index c5eb46c..63b7e8c 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_clock.h>
 #include <linux/pm_runtime.h>
 
 
@@ -22,17 +23,26 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	if (np)
+	if (np) {
+		of_pm_clk_add_clks(&pdev->dev);
 		of_platform_populate(np, NULL, NULL, &pdev->dev);
+	}
 
 	return 0;
 }
 
+static const struct dev_pm_ops simple_pm_bus_pm_ops = {
+	SET_RUNTIME_PM_OPS(pm_clk_suspend,
+			   pm_clk_resume, NULL)
+};
+
 static int simple_pm_bus_remove(struct platform_device *pdev)
 {
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_clk_destroy(&pdev->dev);
+
 	return 0;
 }
 
@@ -48,6 +58,7 @@ static struct platform_driver simple_pm_bus_driver = {
 	.driver = {
 		.name = "simple-pm-bus",
 		.of_match_table = simple_pm_bus_of_match,
+		.pm = &simple_pm_bus_pm_ops,
 	},
 };
 
-- 
2.10.1

