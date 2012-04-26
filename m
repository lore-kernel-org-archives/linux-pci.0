Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48060 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab2DZKko (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 06:40:44 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 5F7403EE0C0
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:40:43 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 445B745DE5B
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:40:43 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0654445DE53
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:40:43 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id ECF5DE18004
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:40:42 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A9C791DB803F
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:40:42 +0900 (JST)
Date: Thu, 26 Apr 2012 19:40:36 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: liuj97@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Subject: [PATCH 2/6] PCI, x86: split out pci_mmconfig_alloc() for code reuse
Message-Id: <20120426194036.0a0d22e4.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Split out pci_mmconfig_alloc() for code reuse.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/pci/mmconfig-shared.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

Index: bjorn-next/arch/x86/pci/mmconfig-shared.c
===================================================================
--- bjorn-next.orig/arch/x86/pci/mmconfig-shared.c
+++ bjorn-next/arch/x86/pci/mmconfig-shared.c
@@ -61,8 +61,9 @@ static __init void list_add_sorted(struc
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
@@ -79,8 +80,6 @@ static __init struct pci_mmcfg_region *p
 	new->start_bus = start;
 	new->end_bus = end;
 
-	list_add_sorted(new);
-
 	res = &new->res;
 	res->start = addr + PCI_MMCFG_BUS_OFFSET(start);
 	res->end = addr + PCI_MMCFG_BUS_OFFSET(end + 1) - 1;
@@ -96,6 +95,18 @@ static __init struct pci_mmcfg_region *p
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

