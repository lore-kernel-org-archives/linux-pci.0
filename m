Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:50547 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139Ab2EGU3m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 16:29:42 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 6/7] PCI, sgihp: Using pci_hp_add_bridge
Date: Mon,  7 May 2012 13:29:15 -0700
Message-Id: <1336422556-4124-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
References: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

instead of open code with pci_add_new_bus()/do_scan_bus...

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/sgi_hotplug.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index de57311..f64ca92 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -397,13 +397,11 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 			else
 				sn_io_slot_fixup(dev);
 			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-				unsigned char sec_bus;
-				pci_read_config_byte(dev, PCI_SECONDARY_BUS,
-						     &sec_bus);
-				new_bus = pci_add_new_bus(dev->bus, dev,
-							  sec_bus);
-				pci_scan_child_bus(new_bus);
-				new_ppb = 1;
+				pci_hp_add_bridge(dev);
+				if (dev->subordinate) {
+					new_bus = dev->subordinate;
+					new_ppb = 1;
+				}
 			}
 			pci_dev_put(dev);
 		}
-- 
1.7.7

