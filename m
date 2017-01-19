Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbdASO6O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jan 2017 09:58:14 -0500
Subject: [PATCH] PCI: Remove res_to_dev_res() debug message
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Yinghai Lu <yinghai@kernel.org>
Date: Thu, 19 Jan 2017 08:58:06 -0600
Message-ID: <20170119145806.13731.64428.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove res_to_dev_res() debug message.  This is printed from a lookup
function.  If the message is important, it should be printed from the
caller with more context.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f30ca75b5b6c..1ca8870245f4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -106,14 +106,6 @@ static struct pci_dev_resource *res_to_dev_res(struct list_head *head,
 
 	list_for_each_entry(dev_res, head, list) {
 		if (dev_res->res == res) {
-			int idx = res - &dev_res->dev->resource[0];
-
-			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
-				 "res[%d]=%pR res_to_dev_res add_size %llx min_align %llx\n",
-				 idx, dev_res->res,
-				 (unsigned long long)dev_res->add_size,
-				 (unsigned long long)dev_res->min_align);
-
 			return dev_res;
 		}
 	}

