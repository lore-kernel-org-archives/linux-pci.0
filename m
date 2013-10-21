Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:45821 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab3JUJHr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2013 05:07:47 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so6634774pbc.7
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2013 02:07:47 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, sachin.kamat@linaro.org,
	Sean Cross <xobs@kosagi.com>
Subject: [PATCH 1/3] PCI: imx6: Remove redeundant of_match_ptr
Date: Mon, 21 Oct 2013 14:36:41 +0530
Message-Id: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

imx6_pcie_of_match is always compiled in. Hence of_match_ptr is
not required.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Sean Cross <xobs@kosagi.com>
---
 drivers/pci/host/pci-imx6.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 5afa922..64aaa8e 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -558,7 +558,7 @@ static struct platform_driver imx6_pcie_driver = {
 	.driver = {
 		.name	= "imx6q-pcie",
 		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(imx6_pcie_of_match),
+		.of_match_table = imx6_pcie_of_match,
 	},
 };
 
-- 
1.7.9.5

