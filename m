Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5691FC10F05
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C313218A3
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCTSOo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:14:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbfCTSOZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 14:14:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9832C85813C0A12AD8F8;
        Thu, 21 Mar 2019 02:14:22 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Mar 2019 02:14:13 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>, <bp@suse.de>
CC:     <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linuxarm@huawei.com>, <agraf@suse.de>,
        <andy.shevchenko@gmail.com>, "John Garry" <john.garry@huawei.com>
Subject: [RFC PATCH v2 1/3] resource: Request IO port regions from children of ioport_resource
Date:   Thu, 21 Mar 2019 02:14:08 +0800
Message-ID: <1553105650-28012-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently when we request an IO port region, the request is made directly
to the top resource, ioport_resource.

There is an issue here, in that drivers may successfully request an IO
port region even if the IO port region has not even been mapped in
(in pci_remap_iospace()).

This may lead to crashes when the system has no PCI host, or, has a host
but it has failed enumeration, while drivers still attempt to access PCI
IO ports, as below:

root@(none)$root@(none)$ insmod f71882fg.ko
[  152.215377] Unable to handle kernel paging request at virtual address ffff7dfffee0002e
[  152.231299] Mem abort info:
[  152.236898]   ESR = 0x96000046
[  152.243019]   Exception class = DABT (current EL), IL = 32 bits
[  152.254905]   SET = 0, FnV = 0
[  152.261024]   EA = 0, S1PTW = 0
[  152.267320] Data abort info:
[  152.273091]   ISV = 0, ISS = 0x00000046
[  152.280784]   CM = 0, WnR = 1
[  152.286730] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
[  152.300537] [ffff7dfffee0002e] pgd=000000000141c003, pud=000000000141d003, pmd=0000000000000000
[  152.318016] Internal error: Oops: 96000046 [#1] PREEMPT SMP
[  152.329199] Modules linked in: f71882fg(+)
[  152.337415] CPU: 8 PID: 2732 Comm: insmod Not tainted 5.1.0-rc1-00002-gab1a0e9200b8-dirty #102
[  152.354712] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
[  152.373058] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  152.382675] pc : logic_outb+0x54/0xb8
[  152.390017] lr : f71882fg_find+0x64/0x390 [f71882fg]
[  152.399977] sp : ffff000013393aa0
[  152.406618] x29: ffff000013393aa0 x28: ffff000008b98b10
[  152.417278] x27: ffff000013393df0 x26: 0000000000000100
[  152.427938] x25: ffff801f8c872d30 x24: ffff000011420000
[  152.438598] x23: ffff801fb49d2940 x22: ffff000011291000
[  152.449257] x21: 000000000000002e x20: 0000000000000087
[  152.459917] x19: ffff000013393b44 x18: ffffffffffffffff
[  152.470577] x17: 0000000000000000 x16: 0000000000000000
[  152.481236] x15: ffff00001127d6c8 x14: ffff801f8cfd691c
[  152.491896] x13: 0000000000000000 x12: 0000000000000000
[  152.502555] x11: 0000000000000003 x10: 0000801feace2000
[  152.513215] x9 : 0000000000000000 x8 : ffff841fa654f280
[  152.523874] x7 : 0000000000000000 x6 : 0000000000ffc0e3
[  152.534534] x5 : ffff000011291360 x4 : ffff801fb4949f00
[  152.545194] x3 : 0000000000ffbffe x2 : 76e767a63713d500
[  152.555853] x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
[  152.566514] Process insmod (pid: 2732, stack limit = 0x(____ptrval____))
[  152.579968] Call trace:
[  152.584863]  logic_outb+0x54/0xb8
[  152.591506]  f71882fg_find+0x64/0x390 [f71882fg]
[  152.600768]  f71882fg_init+0x38/0xc70 [f71882fg]
[  152.610031]  do_one_initcall+0x5c/0x198
[  152.617723]  do_init_module+0x54/0x1b0
[  152.625237]  load_module+0x1dc4/0x2158
[  152.632752]  __se_sys_init_module+0x14c/0x1e8
[  152.641490]  __arm64_sys_init_module+0x18/0x20
[  152.650404]  el0_svc_common+0x5c/0x100
[  152.657919]  el0_svc_handler+0x2c/0x80
[  152.665433]  el0_svc+0x8/0xc
[  152.671202] Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
[  152.683434] ---[ end trace fd4f35b610829a48 ]---
Segmentation fault
root@(none)$

Note that the f71882fg driver correctly calls request_muxed_region().

This issue was originally reported in [1].

This patch changes the functionality of request{muxed_}_region() to
request a region from a direct child descendent of the top
ioport_resource.

In this, if the IO port region has not been mapped for a particular IO
region, the PCI IO resource would also not have been inserted, and so a
suitable child region will not exist. As such,
request_{muxed_}region() calls will fail.

A side note: there are many drivers in the kernel which fail to even call
request_{muxed_}region() prior to IO port accesses, and they also need to
be fixed (to call request_{muxed_}region(), as appropriate) separately.

[1] https://www.spinics.net/lists/linux-pci/msg49821.html

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/ioport.h | 12 +++++++++---
 kernel/resource.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..d7b7e1e08291 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -217,19 +217,25 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
 
 
 /* Convenience shorthand with allocation */
-#define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
-#define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
+#define request_region(start,n,name)		__request_region_from_children(&ioport_resource, (start), (n), (name), 0)
+#define request_muxed_region(start,n,name)	__request_region_from_children(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
 #define __request_mem_region(start,n,name, excl) __request_region(&iomem_resource, (start), (n), (name), excl)
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name), 0)
 #define request_mem_region_exclusive(start,n,name) \
 	__request_region(&iomem_resource, (start), (n), (name), IORESOURCE_EXCLUSIVE)
 #define rename_region(region, newname) do { (region)->name = (newname); } while (0)
 
-extern struct resource * __request_region(struct resource *,
+extern struct resource *__request_region(struct resource *,
 					resource_size_t start,
 					resource_size_t n,
 					const char *name, int flags);
 
+extern struct resource *__request_region_from_children(struct resource *,
+					resource_size_t start,
+					resource_size_t n,
+					const char *name, int flags);
+
+
 /* Compatibility cruft */
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
diff --git a/kernel/resource.c b/kernel/resource.c
index 92190f62ebc5..87ed200eda8b 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1097,6 +1097,34 @@ resource_size_t resource_alignment(struct resource *res)
 
 static DECLARE_WAIT_QUEUE_HEAD(muxed_resource_wait);
 
+/**
+ * __request_region_from_children - create a new busy region from a child
+ * @parent: parent resource descriptor
+ * @start: resource start address
+ * @n: resource region size
+ * @name: reserving caller's ID string
+ * @flags: IO resource flags
+ */
+struct resource *__request_region_from_children(struct resource *parent,
+						resource_size_t start,
+						resource_size_t n,
+						const char *name, int flags)
+{
+	struct resource *res = __request_region(parent, start, n, name, flags);
+
+	if (res && res->parent == parent) {
+		/*
+		 * This is a direct descendent of the parent, which is
+		 * what we didn't want.
+		 */
+		__release_region(parent, start, n);
+		res = NULL;
+	}
+
+	return res;
+}
+EXPORT_SYMBOL(__request_region_from_children);
+
 /**
  * __request_region - create a new busy resource region
  * @parent: parent resource descriptor
-- 
2.17.1

