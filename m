Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59402 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756771AbbEVWNe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2015 18:13:34 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCIe / hotplug: Drop pointless label from pciehp_probe()
Date: Sat, 23 May 2015 00:38:57 +0200
Message-ID: <23117851.vMYBozkkxg@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The err_out_none label in pciehp_probe() only leads to a return
statement, so use return statements instead of jumps to it and
drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/patch/6436921/ .

---
 drivers/pci/hotplug/pciehp_core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/hotplug/pciehp_core.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/pciehp_core.c
+++ linux-pm/drivers/pci/hotplug/pciehp_core.c
@@ -256,13 +256,13 @@ static int pciehp_probe(struct pcie_devi
 		/* Can happen if we run out of bus numbers during probe */
 		dev_err(&dev->device,
 			"Hotplug bridge without secondary bus, ignoring\n");
-		goto err_out_none;
+		return -ENODEV;
 	}
 
 	ctrl = pcie_init(dev);
 	if (!ctrl) {
 		dev_err(&dev->device, "Controller initialization failed\n");
-		goto err_out_none;
+		return -ENODEV;
 	}
 	set_service_data(dev, ctrl);
 
@@ -302,7 +302,6 @@ err_out_free_ctrl_slot:
 	cleanup_slot(ctrl);
 err_out_release_ctlr:
 	pciehp_release_ctrl(ctrl);
-err_out_none:
 	return -ENODEV;
 }
 

