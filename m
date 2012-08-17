Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab2HQXgm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:42 -0400
Received: by mail-ob0-f202.google.com with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:42 -0700 (PDT)
Subject: [PATCH v2 11/16] PCI: Leave normal LIST_POISON in deleted list entries
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:41 -0600
Message-ID: <20120817233641.10973.93668.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

list_del() already sets next/prev to LIST_POISON1/LIST_POISON2, so we
don't need to do anything special here to prevent further list accesses.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/remove.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index c01baca..4f9ca91 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -32,11 +32,8 @@ static void pci_stop_dev(struct pci_dev *dev)
 
 static void pci_destroy_dev(struct pci_dev *dev)
 {
-	/* Remove the device from the device lists, and prevent any further
-	 * list accesses from this device */
 	down_write(&pci_bus_sem);
 	list_del(&dev->bus_list);
-	dev->bus_list.next = dev->bus_list.prev = NULL;
 	up_write(&pci_bus_sem);
 
 	pci_free_resources(dev);

