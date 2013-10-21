Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58178 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab3JUJHw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2013 05:07:52 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so7733681pab.27
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2013 02:07:51 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, sachin.kamat@linaro.org,
	Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] PCI: exynos: Remove redundant of_match_ptr
Date: Mon, 21 Oct 2013 14:36:43 +0530
Message-Id: <1382346403-29576-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This driver is DT only. Hence of_match_ptr is not required.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-exynos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index ee692c2..c4798fb 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -647,7 +647,7 @@ static struct platform_driver exynos_pcie_driver = {
 	.driver = {
 		.name	= "exynos-pcie",
 		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(exynos_pcie_of_match),
+		.of_match_table = exynos_pcie_of_match,
 	},
 };
 
-- 
1.7.9.5

