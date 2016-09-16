Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:30542 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965229AbcIPUMt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2016 16:12:49 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v14 15/17] PCI: Add has_mem64 for struct host_bridge
Date: Fri, 16 Sep 2016 13:02:05 -0700
Message-Id: <20160916200207.21439-16-yinghai@kernel.org>
In-Reply-To: <20160916200207.21439-1-yinghai@kernel.org>
References: <20160916200207.21439-1-yinghai@kernel.org>
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
index 55539dd..08cff94 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2251,6 +2251,13 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
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
index cf54188..e2fd9d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -412,6 +412,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	unsigned int has_mem64:1;
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
2.8.3

