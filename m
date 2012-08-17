Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:49948 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab2HQXfw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:35:52 -0400
Received: by faem1 with SMTP id m1so116751fae.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:35:51 -0700 (PDT)
Subject: [PATCH v2 01/16] PCI: acpiphp: Stop disabling bridges on remove
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:35:50 -0600
Message-ID: <20120817233549.10973.85915.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

acpiphp_disable_slot() turns off power to the slot immediately after
calling disable_device(), so there's no point in disabling any bridges
below the slot: we're about to turn them off anyway.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index ad6fd66..c25291c 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -869,17 +869,6 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 	return retval;
 }
 
-static void disable_bridges(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (dev->subordinate) {
-			disable_bridges(dev->subordinate);
-			pci_disable_device(dev);
-		}
-	}
-}
-
 /* return first device in slot, acquiring a reference on it */
 static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
 {
@@ -932,10 +921,6 @@ static int disable_device(struct acpiphp_slot *slot)
 	 */
 	while ((pdev = dev_in_slot(slot))) {
 		pci_stop_bus_device(pdev);
-		if (pdev->subordinate) {
-			disable_bridges(pdev->subordinate);
-			pci_disable_device(pdev);
-		}
 		__pci_remove_bus_device(pdev);
 		pci_dev_put(pdev);
 	}

