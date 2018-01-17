Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:45636 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeAQKeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 05:34:37 -0500
From: Luis de Bethencourt <luisbg@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH] PCI / PM: Fix trailing semicolon
Date: Wed, 17 Jan 2018 10:33:21 +0000
Message-Id: <20180117103321.24414-1-luisbg@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d79dbc377b9c..5958c8dda4e3 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -968,7 +968,7 @@ static int pci_pm_freeze_late(struct device *dev)
 	if (dev_pm_smart_suspend_and_suspended(dev))
 		return 0;
 
-	return pm_generic_freeze_late(dev);;
+	return pm_generic_freeze_late(dev);
 }
 
 static int pci_pm_freeze_noirq(struct device *dev)
-- 
2.15.1
