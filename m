Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:51119 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754860AbdL2LrQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Dec 2017 06:47:16 -0500
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] pci/setup-bus: Delete an error message for a failed memory
 allocation in add_to_list()
Message-ID: <fd9d212e-e8da-1aa7-be7f-7bf6d8f1e15f@users.sourceforge.net>
Date: Fri, 29 Dec 2017 12:47:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2017 12:15:16 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pci/setup-bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b1ad466199ad..d131d29c4fdb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -67,10 +67,8 @@ static int add_to_list(struct list_head *head,
 	struct pci_dev_resource *tmp;
 
 	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
-	if (!tmp) {
-		pr_warn("add_to_list: kmalloc() failed!\n");
+	if (!tmp)
 		return -ENOMEM;
-	}
 
 	tmp->res = res;
 	tmp->dev = dev;
-- 
2.15.1
