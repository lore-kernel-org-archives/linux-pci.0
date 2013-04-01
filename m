Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Rafael <rjw@sisk.pl>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/3] PCI: acpiphp: remove unused function acpiphp_max_busnr
Date: Mon, 1 Apr 2013 17:22:07 +0800
Message-ID: <1364808128-12792-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1364808128-12792-1-git-send-email-wangyijing@huawei.com>
References: <1364808128-12792-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Clean up unuse function acpiphp_max_busnr() code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   30 ------------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 7d7ed3f..52e91bb 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -680,36 +680,6 @@ static int power_off_slot(struct acpiphp_slot *slot)
 	return retval;
 }
 
-
-
-/**
- * acpiphp_max_busnr - return the highest reserved bus number under the given bus.
- * @bus: bus to start search with
- */
-static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
-{
-	struct list_head *tmp;
-	unsigned char max, n;
-
-	/*
-	 * pci_bus_max_busnr will return the highest
-	 * reserved busnr for all these children.
-	 * that is equivalent to the bus->subordinate
-	 * value.  We don't want to use the parent's
-	 * bus->subordinate value because it could have
-	 * padding in it.
-	 */
-	max = bus->busn_res.start;
-
-	list_for_each(tmp, &bus->children) {
-		n = pci_bus_max_busnr(pci_bus_b(tmp));
-		if (n > max)
-			max = n;
-	}
-	return max;
-}
-
-
 /**
  * acpiphp_bus_add - add a new bus to acpi subsystem
  * @func: acpiphp_func of the bridge
-- 
1.7.1


