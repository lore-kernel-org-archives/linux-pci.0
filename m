Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:37693 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932898AbeFPTfb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:35:31 -0400
Message-Id: <b835565f9e9e234dbae1b78ab83c703f78d0710c.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 01/32] PCI: hotplug: Don't leak pci_slot on registration
 failure
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If addition of sysfs files fails on registration of a hotplug slot, the
struct pci_slot as well as the entry in the slot_list is leaked.  The
issue has been present since the hotplug core was introduced in 2002:
https://git.kernel.org/tglx/history/c/a8a2069f432c

Perhaps the idea was that even though sysfs addition fails, the slot
should still be usable.  But that's not how drivers use the interface,
they abort probe if a non-zero value is returned.

Cc: stable@vger.kernel.org # v2.4.15+
Cc: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index af92fed46ab7..fd93783a87b0 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -438,8 +438,17 @@ int __pci_hp_register(struct hotplug_slot *slot, struct pci_bus *bus,
 	list_add(&slot->slot_list, &pci_hotplug_slot_list);
 
 	result = fs_add_slot(pci_slot);
+	if (result)
+		goto err_list_del;
+
 	kobject_uevent(&pci_slot->kobj, KOBJ_ADD);
 	dbg("Added slot %s to the list\n", name);
+	goto out;
+
+err_list_del:
+	list_del(&slot->slot_list);
+	pci_slot->hotplug = NULL;
+	pci_destroy_slot(pci_slot);
 out:
 	mutex_unlock(&pci_hp_mutex);
 	return result;
-- 
2.17.1
