Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13895 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbcFBIRX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Jun 2016 04:17:23 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Peter Wu <peter@lekensteyn.nl>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v6 4/5] ACPI / hotplug / PCI: Runtime resume bridge before rescan
Date: Thu,  2 Jun 2016 11:17:14 +0300
Message-Id: <1464855435-32960-5-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If a PCI bridge (or PCIe port) that is runtime suspended gets an ACPI
hotplug event, such as BUS_CHECK we need to make sure it is resumed before
devices below the bridge are re-scanned. Otherwise the devices behind the
port are not accessible and will be treated as hot-unplugged.

To fix this, resume PCI bridges from runtime suspend while rescanning.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index fa49f9143b80..6a33ddcfa20b 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -675,6 +675,8 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 	if (bridge->is_going_away)
 		return;
 
+	pm_runtime_get_sync(&bridge->pci_dev->dev);
+
 	list_for_each_entry(slot, &bridge->slots, node) {
 		struct pci_bus *bus = slot->bus;
 		struct pci_dev *dev, *tmp;
@@ -694,6 +696,8 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 			disable_slot(slot);
 		}
 	}
+
+	pm_runtime_put(&bridge->pci_dev->dev);
 }
 
 /*
-- 
2.8.1

