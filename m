Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:28692 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759229Ab2FUJyX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:54:23 -0400
From: Jiang Liu <jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
CC: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v9 02/11] x86/PCI: split out pci_mmconfig_alloc() for code reuse
Date: Thu, 21 Jun 2012 17:36:54 +0800
Message-ID: <1340271423-4352-3-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split out pci_mmconfig_alloc() for code reuse, which will be used
when supporting PCI root bridge hotplug.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index f799949..5e2cd2a 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -61,8 +61,9 @@ static __init void list_add_sorted(struct pci_mmcfg_region *new)
 	list_add_tail(&new->list, &pci_mmcfg_list);
 }
 
-static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
-							int end, u64 addr)
+static __devinit struct pci_mmcfg_region *pci_mmconfig_alloc(int segment,
+							     int start,
+							     int end, u64 addr)
 {
 	struct pci_mmcfg_region *new;
 	struct resource *res;
@@ -79,8 +80,6 @@ static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
 	new->start_bus = start;
 	new->end_bus = end;
 
-	list_add_sorted(new);
-
 	res = &new->res;
 	res->start = addr + PCI_MMCFG_BUS_OFFSET(start);
 	res->end = addr + PCI_MMCFG_BUS_OFFSET(end + 1) - 1;
@@ -96,6 +95,18 @@ static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
 	return new;
 }
 
+static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
+							int end, u64 addr)
+{
+	struct pci_mmcfg_region *new;
+
+	new = pci_mmconfig_alloc(segment, start, end, addr);
+	if (new)
+		list_add_sorted(new);
+
+	return new;
+}
+
 struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
 {
 	struct pci_mmcfg_region *cfg;
-- 
1.7.1


