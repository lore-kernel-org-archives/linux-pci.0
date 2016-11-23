Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35724 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933700AbcKWPIQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2016 10:08:16 -0500
From: Geliang Tang <geliangtang@gmail.com>
To: Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Geliang Tang <geliangtang@gmail.com>, rfi@lists.rocketboards.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: altera: use builtin_platform_driver
Date: Wed, 23 Nov 2016 22:52:22 +0800
Message-Id: <b12dde3b7465f3bba35ab7a9226b464f30f27412.1479912709.git.geliangtang@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/pci/host/pcie-altera.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index b0ac4df..eefcb38 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -641,8 +641,4 @@ static struct platform_driver altera_pcie_driver = {
 	},
 };
 
-static int altera_pcie_init(void)
-{
-	return platform_driver_register(&altera_pcie_driver);
-}
-device_initcall(altera_pcie_init);
+builtin_platform_driver(altera_pcie_driver);
-- 
2.9.3

