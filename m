Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24780 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab3GVVhn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 17:37:43 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 1/7] PCI: Don't use temp bus for pci_bus_release_bridge_resources
Date: Mon, 22 Jul 2013 14:37:12 -0700
Message-Id: <1374529038-14311-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
References: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

as later bus can not be used as temp variable after we change to
per root bus handling with assign unassigned resources.

Per Bjorn, separate it from big patch that handing assign_unssigned per root bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d254e23..7de30e3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1458,12 +1458,11 @@ again:
 	 * Try to release leaf bridge's resources that doesn't fit resource of
 	 * child device under that bridge
 	 */
-	list_for_each_entry(fail_res, &fail_head, list) {
-		bus = fail_res->dev->bus;
-		pci_bus_release_bridge_resources(bus,
+	list_for_each_entry(fail_res, &fail_head, list)
+		pci_bus_release_bridge_resources(fail_res->dev->bus,
 						 fail_res->flags & type_mask,
 						 rel_type);
-	}
+
 	/* restore size and flags */
 	list_for_each_entry(fail_res, &fail_head, list) {
 		struct resource *res = fail_res->res;
-- 
1.8.1.4

