Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:60831 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbaBMNRF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 08:17:05 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Russell King <linux@arm.linux.org.uk>,
	David Airlie <airlied@linux.ie>,
	<dri-devel@lists.freedesktop.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<linux-pcmcia@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/6] PCI,acpiphp: Use list_for_each_entry() for bus traversal
Date: Thu, 13 Feb 2014 21:13:58 +0800
Message-ID: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace list_for_each() + pci_bus_b() with the simpler
list_for_each_entry().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index cd929ae..aee6a0a 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -450,7 +450,7 @@ static void cleanup_bridge(struct acpiphp_bridge *bridge)
  */
 static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
 {
-	struct list_head *tmp;
+	struct pci_bus *tmp;
 	unsigned char max, n;
 
 	/*
@@ -463,8 +463,8 @@ static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
 	 */
 	max = bus->busn_res.start;
 
-	list_for_each(tmp, &bus->children) {
-		n = pci_bus_max_busnr(pci_bus_b(tmp));
+	list_for_each_entry(tmp, &bus->children, node) {
+		n = pci_bus_max_busnr(tmp);
 		if (n > max)
 			max = n;
 	}
-- 
1.7.1


