Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:44924 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab3I1KMN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Sep 2013 06:12:13 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so3565868pbc.4
        for <linux-pci@vger.kernel.org>; Sat, 28 Sep 2013 03:12:12 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, sachin.kamat@linaro.org
Subject: [PATCH 2/2] PCI: driver: Staticize pci_dev_pm_ops
Date: Sat, 28 Sep 2013 15:42:01 +0530
Message-Id: <1380363121-1977-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380363121-1977-1-git-send-email-sachin.kamat@linaro.org>
References: <1380363121-1977-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

'pci_dev_pm_ops' is local to this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/pci/pci-driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 38f3c01..653c8c5 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1124,7 +1124,7 @@ static int pci_pm_runtime_idle(struct device *dev)
 
 #ifdef CONFIG_PM
 
-const struct dev_pm_ops pci_dev_pm_ops = {
+static const struct dev_pm_ops pci_dev_pm_ops = {
 	.prepare = pci_pm_prepare,
 	.complete = pci_pm_complete,
 	.suspend = pci_pm_suspend,
-- 
1.7.9.5

