Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:34073 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756127AbcJ1Iwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2016 04:52:34 -0400
Message-Id: <f77a60b00b35103587335b06f4791135426e0bcb.1477611126.git.lukas@wunner.de>
In-Reply-To: <cover.1477611126.git.lukas@wunner.de>
References: <cover.1477611126.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 28 Oct 2016 10:52:06 +0200
Subject: [PATCH v2 1/9] PCI: Don't acquire ref on parent in
 pci_bridge_d3_update()
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This function is always called with an existing pci_dev struct, which
holds a reference on the pci_bus struct it resides on, which in turn
holds a reference on pci_bus->bridge, which is the pci_dev's parent.

Hence there's no need to acquire an additional ref on the parent.

More specifically, the pci_dev exists until pci_destroy_dev() drops the
final reference on it, so all calls to pci_bridge_d3_update() must be
finished before that.  It is arguably the caller's responsibility to
ensure that it doesn't call pci_bridge_d3_update() with a pci_dev that
might suddenly disappear, but in any case the existing callers are all
safe:

- The call in pci_destroy_dev() happens before the call to put_device().
- The call in pci_bus_add_device() is synchronized with pci_destroy_dev()
  using pci_lock_rescan_remove().
- The calls to pci_d3cold_disable() from the xhci and nouveau drivers
  are safe because a ref on the pci_dev is held as long as it's bound to
  a driver.
- The calls to pci_d3cold_enable() / pci_d3cold_disable() when modifying
  the sysfs "d3cold_allowed" entry are also safe because kernfs_drain()
  waits for existing sysfs users to finish before removing the entry,
  and pci_destroy_dev() is called way after that.

No functional change intended.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ba34907..6e0c399 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2292,7 +2292,6 @@ static void pci_bridge_d3_update(struct pci_dev *dev, bool remove)
 	if (!bridge || !pci_bridge_d3_possible(bridge))
 		return;
 
-	pci_dev_get(bridge);
 	/*
 	 * If the device is removed we do not care about its D3cold
 	 * capabilities.
@@ -2314,8 +2313,6 @@ static void pci_bridge_d3_update(struct pci_dev *dev, bool remove)
 		/* Propagate change to upstream bridges */
 		pci_bridge_d3_update(bridge, false);
 	}
-
-	pci_dev_put(bridge);
 }
 
 /**
-- 
2.9.3

