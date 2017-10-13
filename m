Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42671 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdJMQyz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Oct 2017 12:54:55 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pcmcia@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] pcmcia: convert to use for_each_pci_bridge() helper
Date: Fri, 13 Oct 2017 19:53:52 +0300
Message-Id: <20171013165352.25550-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

...which makes code slightly cleaner.

Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pcmcia/cardbus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index 4fe4cc4ae19a..5c0170597037 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -77,9 +77,8 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 
 	max = bus->busn_res.start;
 	for (pass = 0; pass < 2; pass++)
-		list_for_each_entry(dev, &bus->devices, bus_list)
-			if (pci_is_bridge(dev))
-				max = pci_scan_bridge(bus, dev, max, pass);
+		for_each_pci_bridge(dev, bus)
+			max = pci_scan_bridge(bus, dev, max, pass);
 
 	/*
 	 * Size all resources below the CardBus controller.
-- 
2.14.2
