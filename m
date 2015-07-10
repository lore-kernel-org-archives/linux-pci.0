Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:9901 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbbGJGib (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2015 02:38:31 -0400
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI MSI DRIVER FOR APPLIEDMICRO
	XGENE),
	linux-arm-kernel@lists.infradead.org (open list:PCI MSI DRIVER FOR
	APPLIEDMICRO XGENE), linux-kernel@vger.kernel.org (open list)
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] pci: Drop owner assignment from platform_driver
Date: Fri, 10 Jul 2015 15:38:26 +0900
Message-id: <1436510306-5788-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/pci/host/pci-xgene-msi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index 2d31d4d6fd08..9e1889e6aec7 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -582,7 +582,6 @@ error:
 static struct platform_driver xgene_msi_driver = {
 	.driver = {
 		.name = "xgene-msi",
-		.owner = THIS_MODULE,
 		.of_match_table = xgene_msi_match_table,
 	},
 	.probe = xgene_msi_probe,
-- 
1.9.1

