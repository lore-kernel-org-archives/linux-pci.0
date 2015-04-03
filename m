Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:55218 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbbDCJ3K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 05:29:10 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>, <dja@axtens.net>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Guan Xuetao" <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, Liviu Dudau <liviu@dudau.co.uk>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Yijing Wang" <wangyijing@huawei.com>, <sparclinux@vger.kernel.org>
Subject: [PATCH v9 21/30] sparc/PCI: Use pci_scan_host_bridge() for simplicity
Date: Fri, 3 Apr 2015 17:25:55 +0800
Message-ID: <1428053164-28277-23-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1428053164-28277-1-git-send-email-wangyijing@huawei.com>
References: <1428053164-28277-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we could use pci_scan_host_bridge() to scan
pci buses, provide sparc specific pci_host_bridge_ops.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index e40e456..fa95a1d 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -650,12 +650,27 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 		pci_claim_bus_resources(child_bus);
 }
 
+static int pci_host_of_scan_bus(
+		struct pci_host_bridge *host)
+{
+	struct pci_pbm_info *pbm = dev_get_drvdata(&host->dev);
+	struct device_node *node = pbm->op->dev.of_node;
+
+	pci_of_scan_bus(pbm, node, host->bus);
+	return pci_bus_child_max_busnr(host->bus);
+}
+
+static struct pci_host_bridge_ops pci_host_ops = {
+	.scan_bus = pci_host_of_scan_bus,
+};
+
 struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 				 struct device *parent)
 {
 	LIST_HEAD(resources);
 	struct device_node *node = pbm->op->dev.of_node;
 	struct pci_bus *bus;
+	struct pci_host_bridge *host;
 
 	printk("PCI: Scanning PBM %s\n", node->full_name);
 
@@ -667,16 +682,17 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pbm->busn.end	= pbm->pci_last_busno;
 	pbm->busn.flags	= IORESOURCE_BUS;
 	pci_add_resource(&resources, &pbm->busn);
-	bus = pci_create_root_bus(parent, pbm->index, pbm->pci_first_busno,
-			pbm->pci_ops, pbm, &resources);
-	if (!bus) {
-		printk(KERN_ERR "Failed to create bus for %s\n",
-		       node->full_name);
+	pci_host_ops.pci_ops = pbm->pci_ops;
+	host = pci_scan_host_bridge(parent, pbm->index, pbm->pci_first_busno,
+			pbm, &resources, &pci_host_ops);
+	if (!host) {
+		pr_err("Failed to create host bridge pci%04x:%02x for %s\n",
+		       pbm->index, pbm->pci_first_busno, node->full_name);
 		pci_free_resource_list(&resources);
 		return NULL;
 	}
 
-	pci_of_scan_bus(pbm, node, bus);
+	bus = host->bus;
 	pci_bus_register_of_sysfs(bus);
 
 	pci_claim_bus_resources(bus);
-- 
1.7.1

