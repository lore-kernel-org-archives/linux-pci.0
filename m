Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40129 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbLKFHp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2015 00:07:45 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v9 13/60] PCI: Add has_mem64 for struct host_bridge
Date: Thu, 10 Dec 2015 21:06:09 -0800
Message-Id: <1449810416-2950-14-git-send-email-yinghai@kernel.org>
In-Reply-To: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
References: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add has_mem64 for struct host_bridge, on root bus that does not support
mmio64 above 4g, will not set that.

We will use that info next two following patches:
1. Don't treat non-pref mmio64 as pref mmio, so will not put
   it under bridge's pref range when rescan the devices
2. will keep pref mmio64 and pref mmio32 under bridge pref bar.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 drivers/pci/probe.c | 7 +++++++
 include/linux/pci.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6faabe3..b89daef 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2194,6 +2194,13 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		} else
 			bus_addr[0] = '\0';
 		dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
+
+		if (resource_type(res) == IORESOURCE_MEM) {
+			if ((res->end - offset) > 0xffffffff)
+				bridge->has_mem64 = 1;
+			if ((res->start - offset) > 0xffffffff)
+				res->flags |= IORESOURCE_MEM_64;
+		}
 	}
 
 	down_write(&pci_bus_sem);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f96f86a..c135edc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -413,6 +413,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	unsigned int has_mem64:1;
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
1.8.4.5

