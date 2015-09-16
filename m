Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v5 38/53] PCI: Add has_mem64 for struct host_bridge
Date: Wed, 16 Sep 2015 14:57:36 -0700
Message-Id: <1442440671-5361-39-git-send-email-yinghai@kernel.org>
In-Reply-To: <1442440671-5361-1-git-send-email-yinghai@kernel.org>
References: <1442440671-5361-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add has_mem64 for struct host_bridge, on root bus that does not support
mmio64 above 4g, will not set that.

We will use that info next two following patches:
1. Don't treat non-pref mmio64 as pref mmio, so will not put
   it under bridge's pref range when rescan the devices
2. will keep pref mmio64 and pref mmio32 under bridge pref bar.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c | 9 +++++++++
 include/linux/pci.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9eb9e30..31998ea 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2122,6 +2122,15 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
 	}
 
+	resource_list_for_each_entry(window, &bridge->windows) {
+		res = window->res;
+		if (resource_type(res) == IORESOURCE_MEM &&
+		    (res->end - window->offset) > 0xffffffff) {
+			bridge->has_mem64 = 1;
+			break;
+		}
+	}
+
 	down_write(&pci_bus_sem);
 	list_add_tail(&b->node, &pci_root_buses);
 	up_write(&pci_bus_sem);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 66969bb..207ee64 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -413,6 +413,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	unsigned int has_mem64:1;
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
-- 
1.8.4.5

