Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41074 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab3J2XOj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 19:14:39 -0400
Received: by mail-ie0-f173.google.com with SMTP id u16so969213iet.4
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2013 16:14:39 -0700 (PDT)
Subject: [PATCH] PCI: Report pci_pme_active() kmalloc failure
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Tue, 29 Oct 2013 17:14:38 -0600
Message-ID: <20131029231437.19711.61623.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously, if kmalloc() failed, we claimed "PME# enabled" in dmesg,
even though we didn't add the device to the pci_pme_list.  This prints
a more correct warning.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ad7fc72..36cc8d5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1638,8 +1638,10 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
 		if (enable) {
 			pme_dev = kmalloc(sizeof(struct pci_pme_device),
 					  GFP_KERNEL);
-			if (!pme_dev)
-				goto out;
+			if (!pme_dev) {
+				dev_warn(&dev->dev, "can't enable PME#\n");
+				return;
+			}
 			pme_dev->dev = dev;
 			mutex_lock(&pci_pme_list_mutex);
 			list_add(&pme_dev->list, &pci_pme_list);
@@ -1660,7 +1662,6 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
 		}
 	}
 
-out:
 	dev_dbg(&dev->dev, "PME# %s\n", enable ? "enabled" : "disabled");
 }
 

