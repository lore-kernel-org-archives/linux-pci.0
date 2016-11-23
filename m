Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33258 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938766AbcKWPLA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2016 10:11:00 -0500
From: Geliang Tang <geliangtang@gmail.com>
To: Pratyush Anand <pratyush.anand@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: spear: use builtin_platform_driver
Date: Wed, 23 Nov 2016 22:55:07 +0800
Message-Id: <fad445bc8162cd07a298b25a18614773c86ec227.1479912870.git.geliangtang@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/pci/host/pcie-spear13xx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 3cf197b..dafe8b8 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -296,8 +296,4 @@ static struct platform_driver spear13xx_pcie_driver = {
 	},
 };
 
-static int __init spear13xx_pcie_init(void)
-{
-	return platform_driver_register(&spear13xx_pcie_driver);
-}
-device_initcall(spear13xx_pcie_init);
+builtin_platform_driver(spear13xx_pcie_driver);
-- 
2.9.3

