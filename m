Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35343 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbcIJMam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2016 08:30:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id i75so464346pfa.2
        for <linux-pci@vger.kernel.org>; Sat, 10 Sep 2016 05:30:42 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Pratyush Anand <pratyush.anand@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH -next] PCI: spear: Use builtin_platform_driver to simplify the code
Date: Sat, 10 Sep 2016 12:30:34 +0000
Message-Id: <1473510634-23872-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

Use the builtin_platform_driver() macro to make the code simpler.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pcie-spear13xx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 09aed85..1c957eb 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -364,8 +364,4 @@ static struct platform_driver spear13xx_pcie_driver = {
 	},
 };
 
-static int __init spear13xx_pcie_init(void)
-{
-	return platform_driver_register(&spear13xx_pcie_driver);
-}
-device_initcall(spear13xx_pcie_init);
+builtin_platform_driver(spear13xx_pcie_driver);



