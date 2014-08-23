Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31908 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaHWBPb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 21:15:31 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI: don't release sibiling bridge resources during hotplug
Date: Fri, 22 Aug 2014 18:15:10 -0700
Message-Id: <1408756512-16885-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On hotplug path, we can not touch sibling bridges that is out
side of the slot.

That could happen when BIOS does not assign some bridge BARs and
later can not assign resource to them in first try.

Check if fail dev is the parent bridge, then just use subordinate
bus instead use parent bus.

Reported-by:  Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>


---
 drivers/pci/setup-bus.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -1676,10 +1676,16 @@ again:
 	 * Try to release leaf bridge's resources that doesn't fit resource of
 	 * child device under that bridge
 	 */
-	list_for_each_entry(fail_res, &fail_head, list)
-		pci_bus_release_bridge_resources(fail_res->dev->bus,
+	list_for_each_entry(fail_res, &fail_head, list) {
+		struct pci_bus *bus = fail_res->dev->bus;
+
+		if (fail_res->dev == bridge)
+			bus = bridge->subordinate;
+
+		pci_bus_release_bridge_resources(bus,
 						 fail_res->flags & type_mask,
 						 whole_subtree);
+	}
 
 	/* restore size and flags */
 	list_for_each_entry(fail_res, &fail_head, list) {
