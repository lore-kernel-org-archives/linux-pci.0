Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:45855 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbaILSD3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Sep 2014 14:03:29 -0400
Received: by mail-ie0-f182.google.com with SMTP id tr6so1414757ieb.13
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2014 11:03:29 -0700 (PDT)
Subject: [PATCH v1 06/13] PCI: shpchp: Remove pci_configure_slot() usage
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatxjain@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Date: Fri, 12 Sep 2014 12:03:28 -0600
Message-ID: <20140912180328.1630.45550.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We now configure each PCI device as it is enumerated, in pci_device_add(),
so remove the configuration done in shpchp.

That configuration, in pci_configure_device(), does not include the
MPS/MRRS configuration done by pcie_bus_configure_settings(), so keep
that here.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/shpchp_pci.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index 469454e0cc48..f8cd3a27e351 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -69,13 +69,7 @@ int shpchp_configure_device(struct slot *p_slot)
 	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
-
-	list_for_each_entry(dev, &parent->devices, bus_list) {
-		if (PCI_SLOT(dev->devfn) != p_slot->device)
-			continue;
-		pci_configure_slot(dev);
-	}
-
+	pcie_bus_configure_settings(parent);
 	pci_bus_add_devices(parent);
 
  out:

