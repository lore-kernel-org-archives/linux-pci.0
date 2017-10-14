Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:47459 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdJNWHn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2017 18:07:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id z50so25437062qtj.4
        for <linux-pci@vger.kernel.org>; Sat, 14 Oct 2017 15:07:43 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/5] PCI: aardvark: Check for platform_get_irq() error
Date: Sat, 14 Oct 2017 19:07:27 -0300
Message-Id: <1508018851-9272-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_get_irq() may fail and in the case of failure the error value
should be propagated.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/host/pci-aardvark.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 26ed0c0..f3b16ff 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -901,6 +901,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->base);
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 	ret = devm_request_irq(dev, irq, advk_pcie_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
 			       pcie);
-- 
2.7.4
