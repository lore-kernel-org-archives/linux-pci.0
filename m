Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27493 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbbJAFyK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 01:54:10 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 10/53] PCI: Get new realloc size for bridge for last try
Date: Wed, 30 Sep 2015 22:52:44 -0700
Message-Id: <1443678807-786-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1443678807-786-1-git-send-email-yinghai@kernel.org>
References: <1443678807-786-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current realloc path would not shrink bridge resource through
pbus_size_mem() checking with the old size.

That cause problem: when "required+optional" resource allocation fails,
the cached bridge resource size will prevent "required" resource to get
allocated smaller resource.

Clear the old resource size for last try or third and later try.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
Tested-by: TJ <linux@iam.tj>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9961ab2..8477cf5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1648,6 +1648,17 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 }
 #endif
 
+static void reset_bridge_resource_size(struct pci_dev *dev,
+				       struct resource *res)
+{
+	int idx = res - &dev->resource[0];
+
+	if (idx >= PCI_BRIDGE_RESOURCES && idx <= PCI_BRIDGE_RESOURCE_END) {
+		res->start = 0;
+		res->end = res->start - 1;
+	}
+}
+
 /*
  * first try will not touch pci bridge res
  * second and later try will clear small leaf bridge res
@@ -1732,8 +1743,13 @@ again:
 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
+		if (fail_res->dev->subordinate) {
 			res->flags = 0;
+			/* last or third times and later */
+			if (tried_times + 1 == pci_try_num ||
+			    tried_times + 1 > 2)
+				reset_bridge_resource_size(fail_res->dev, res);
+		}
 	}
 	free_list(&fail_head);
 
@@ -1807,8 +1823,11 @@ again:
 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
+		if (fail_res->dev->subordinate) {
 			res->flags = 0;
+			/* last time */
+			reset_bridge_resource_size(fail_res->dev, res);
+		}
 	}
 	free_list(&fail_head);
 
-- 
1.8.4.5

