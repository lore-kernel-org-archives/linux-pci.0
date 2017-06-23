Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33891 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbdFWJaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2017 05:30:35 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: horms@verge.net.au, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-gen2: make of_device_ids const
Date: Fri, 23 Jun 2017 14:59:52 +0530
Message-Id: <99e5ddc3b23962b22740dc93113d178f6f98df2f.1498210098.git.arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/host/pci-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 8534859..6f87968 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -429,7 +429,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id rcar_pci_of_match[] = {
+static const struct of_device_id rcar_pci_of_match[] = {
 	{ .compatible = "renesas,pci-r8a7790", },
 	{ .compatible = "renesas,pci-r8a7791", },
 	{ .compatible = "renesas,pci-r8a7794", },
-- 
1.9.1
