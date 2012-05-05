Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60421 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab2EEDBI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 May 2012 23:01:08 -0400
Received: by pbbrp8 with SMTP id rp8so4527911pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 04 May 2012 20:01:08 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v5 2/6] PCI, x86: split out pci_mmconfig_alloc() for code reuse
Date: Sat,  5 May 2012 11:00:26 +0800
Message-Id: <1336186830-10765-3-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com>
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

Split out pci_mmconfig_alloc() for code reuse, which will be used
when supporting PCI root bridge hotplug.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

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
1.7.9.5

