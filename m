Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:51444 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab2HQXgi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:38 -0400
Received: by faem1 with SMTP id m1so116777fae.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:37 -0700 (PDT)
Subject: [PATCH v2 10/16] PCI: Rename local variables to conventional names
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:36 -0600
Message-ID: <20120817233636.10973.70478.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"bus" is the conventional name for a "struct pci_bus *" variable.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/remove.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 44f479f..c01baca 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -43,19 +43,19 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_dev_put(dev);
 }
 
-void pci_remove_bus(struct pci_bus *pci_bus)
+void pci_remove_bus(struct pci_bus *bus)
 {
-	pci_proc_detach_bus(pci_bus);
+	pci_proc_detach_bus(bus);
 
 	down_write(&pci_bus_sem);
-	list_del(&pci_bus->node);
-	pci_bus_release_busn_res(pci_bus);
+	list_del(&bus->node);
+	pci_bus_release_busn_res(bus);
 	up_write(&pci_bus_sem);
-	if (!pci_bus->is_added)
+	if (!bus->is_added)
 		return;
 
-	pci_remove_legacy_files(pci_bus);
-	device_unregister(&pci_bus->dev);
+	pci_remove_legacy_files(bus);
+	device_unregister(&bus->dev);
 }
 EXPORT_SYMBOL(pci_remove_bus);
 

