Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51700 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbLKFZ7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2015 00:25:59 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v9 22/60] PCI: Don't release sibling bridge resources during hotplug
Date: Thu, 10 Dec 2015 21:06:18 -0800
Message-Id: <1449810416-2950-23-git-send-email-yinghai@kernel.org>
In-Reply-To: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
References: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
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
index c2e3999..7f7f46c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1902,10 +1902,16 @@ again:
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

