Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35223 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932220AbcDHARM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:17:12 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 23/60] PCI: Don't release sibling bridge resources during hotplug
Date: Thu,  7 Apr 2016 17:15:36 -0700
Message-Id: <1460074573-7481-24-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On hotplug path, we can not touch sibling bridges that is outside
of the slot.

That could happen when BIOS does not assign some bridge BARs and
later kernel can not assign resource to them in first try.

Check if fail dev is the parent bridge, then just use subordinate
bus instead use parent bus.

Reported-by: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d3a39b7..4674e6b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1901,10 +1901,16 @@ again:
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
-- 
1.8.4.5

