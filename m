Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34414 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbbGXFaI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 01:30:08 -0400
Received: by ykax123 with SMTP id x123so11808244yka.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 22:30:07 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH 4/4] PCI: spear: Mark the msi cascade handler IRQF_NO_THREAD
Date: Fri, 24 Jul 2015 13:29:36 +0800
Message-Id: <1437715776-2243-5-git-send-email-haokexin@gmail.com>
In-Reply-To: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
References: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The cascade handler must run in hard interrupt context, otherwise
it will cause dead lock if we force threading of all the interrupt
handlers via kernel command parameter "threadirqs".

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/pci/host/pcie-spear13xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index c49fbdc0f6e4..338788b28631 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -280,7 +280,8 @@ static int spear13xx_add_pcie_port(struct pcie_port *pp,
 		return -ENODEV;
 	}
 	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
-			       IRQF_SHARED, "spear1340-pcie", pp);
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       "spear1340-pcie", pp);
 	if (ret) {
 		dev_err(dev, "failed to request irq %d\n", pp->irq);
 		return ret;
-- 
2.1.0

