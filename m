Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43997 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbbBYNYO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 08:24:14 -0500
Date: Wed, 25 Feb 2015 16:23:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Scott Murray <scott@spiteful.org>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [patch] PCI: cpcihp: missing curly braces in cpci_configure_slot()
Message-ID: <20150225132322.GJ19745@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I don't have this hardware but it looks like we weren't adding bridge
devices as intended.  Maybe the bridge is always the last device?

Fixes: 05b125004815 ('PCI: cpcihp: Iterate over all devices in slot, not functions 0-7')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
index 7d48eca..788db48 100644
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -286,11 +286,12 @@ int cpci_configure_slot(struct slot *slot)
 	}
 	parent = slot->dev->bus;
 
-	list_for_each_entry(dev, &parent->devices, bus_list)
+	list_for_each_entry(dev, &parent->devices, bus_list) {
 		if (PCI_SLOT(dev->devfn) != PCI_SLOT(slot->devfn))
 			continue;
 		if (pci_is_bridge(dev))
 			pci_hp_add_bridge(dev);
+	}
 
 
 	pci_assign_unassigned_bridge_resources(parent->self);
