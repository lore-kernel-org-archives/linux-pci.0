Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36191 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbcIJMbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2016 08:31:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id x24so5390489pfa.3
        for <linux-pci@vger.kernel.org>; Sat, 10 Sep 2016 05:31:06 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, rfi@lists.rocketboards.org,
        linux-pci@vger.kernel.org
Subject: [PATCH -next] PCI: altera: Use builtin_platform_driver to simplify the code
Date: Sat, 10 Sep 2016 12:31:01 +0000
Message-Id: <1473510661-25029-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

Use the builtin_platform_driver() macro to make the code simpler.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pcie-altera.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 48f2736..ea33e8f 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -581,8 +581,4 @@ static struct platform_driver altera_pcie_driver = {
 	},
 };
 
-static int altera_pcie_init(void)
-{
-	return platform_driver_register(&altera_pcie_driver);
-}
-device_initcall(altera_pcie_init);
+builtin_platform_driver(altera_pcie_driver);



