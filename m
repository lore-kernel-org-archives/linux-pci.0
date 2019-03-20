Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BDC4360F
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850B5218A3
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCTSOe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:14:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727062AbfCTSOZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 14:14:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A4F62995DDD7CC8A41BE;
        Thu, 21 Mar 2019 02:14:22 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Mar 2019 02:14:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>, <bp@suse.de>
CC:     <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linuxarm@huawei.com>, <agraf@suse.de>,
        <andy.shevchenko@gmail.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 2/3] lib: logic_pio: Reject access to unregistered CPU MMIO regions
Date:   Thu, 21 Mar 2019 02:14:09 +0800
Message-ID: <1553105650-28012-3-git-send-email-john.garry@huawei.com>
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

Currently when accessing logical indirect PIO addresses in
logic_{in, out}{,s}, we first ensure that the region is registered.

However, no such check exists for CPU MMIO regions. The CPU MMIO regions
would be registered by the PCI host (when PCI_IOBASE is defined) in
pci_register_io_range().

We have seen scenarios when systems which don't have a PCI host or, they
do, and the PCI host probe fails, that certain devices attempts to still
attempt to access PCI IO ports; examples are in [1] and [2].

And even though we would protect against this by ensuring the driver call
request_{muxed_}region(), some don't do this:

root@(none)$ insmod hwmon/f71805f.ko
[   98.623872] Unable to handle kernel paging request at virtual address ffff7dfffee0002e
[   98.639804] Mem abort info:
[   98.645404]   ESR = 0x96000046
[   98.651525]   Exception class = DABT (current EL), IL = 32 bits
[   98.663410]   SET = 0, FnV = 0
[   98.669530]   EA = 0, S1PTW = 0
[   98.675826] Data abort info:
[   98.681597]   ISV = 0, ISS = 0x00000046
[   98.689290]   CM = 0, WnR = 1
[   98.695237] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
[   98.709044] [ffff7dfffee0002e] pgd=000000000141c003, pud=000000000141d003, pmd=0000000000000000
[   98.726523] Internal error: Oops: 96000046 [#1] PREEMPT SMP
[   98.737706] Modules linked in: f71805f(+)
[   98.745748] CPU: 20 PID: 2736 Comm: insmod Not tainted 5.1.0-rc1-00003-g6f1bfec2a620-dirty #99
[   98.763045] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
[   98.781390] pstate: 80000005 (Nzcv daif -PAN -UAO)
[   98.791008] pc : logic_outb+0x54/0xb8
[   98.798351] lr : f71805f_find+0x2c/0x1b8 [f71805f]
[   98.807962] sp : ffff000025fbba90
[   98.814603] x29: ffff000025fbba90 x28: ffff000008b944d0
[   98.825263] x27: ffff000025fbbdf0 x26: 0000000000000100
[   98.835922] x25: ffff801f8c270580 x24: ffff000011420000
[   98.846582] x23: ffff000025fbbb3e x22: ffff000025fbbb40
[   98.857242] x21: ffff000008b991b8 x20: 0000000000000087
[   98.867901] x19: 000000000000002e x18: ffffffffffffffff
[   98.878561] x17: 0000000000000000 x16: 0000000000000000
[   98.889220] x15: ffff00001127d6c8 x14: 0000000000000000
[   98.899880] x13: 0000000000000000 x12: 0000000000000000
[   98.910539] x11: 0000000000010820 x10: 0000841fdac40000
[   98.921199] x9 : 0000000000000001 x8 : 0000000040000000
[   98.931858] x7 : 0000000000210d00 x6 : 0000000000000000
[   98.942517] x5 : ffff801fb6a46040 x4 : ffff841febeaeda0
[   98.953177] x3 : 0000000000ffbffe x2 : ffff000025fbbb40
[   98.963837] x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
[   98.974497] Process insmod (pid: 2736, stack limit = 0x(____ptrval____))
[   98.987950] Call trace:
[   98.992846]  logic_outb+0x54/0xb8
[   98.999489]  f71805f_find+0x2c/0x1b8 [f71805f]
[   99.008403]  f71805f_init+0x38/0xe48 [f71805f]
[   99.017317]  do_one_initcall+0x5c/0x198
[   99.025008]  do_init_module+0x54/0x1b0
[   99.032522]  load_module+0x1dc4/0x2158
[   99.040037]  __se_sys_init_module+0x14c/0x1e8
[   99.048774]  __arm64_sys_init_module+0x18/0x20
[   99.057688]  el0_svc_common+0x5c/0x100
[   99.065203]  el0_svc_handler+0x2c/0x80
[   99.072717]  el0_svc+0x8/0xc
[   99.078486] Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
[   99.090719] ---[ end trace 10ea80bde051bbfc ]---
root@(none)$

Driver f71805f does not call request_{muxed_}region(), as it should do.

This patch adds a check to ensure that the CPU MMIO region is registered
prior to accessing the PCI IO ports.

[1] https://lkml.org/lkml/2019/3/14/630
[2] https://www.spinics.net/lists/arm-kernel/msg694702.html

Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 70 ++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index feea48fd1a0d..026a4fb4b944 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -192,70 +192,80 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 }
 
 #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
+#define INVALID_RANGE(range) (!range || \
+			      (range->flags == LOGIC_PIO_CPU_MMIO && !range->ops))
+
 #define BUILD_LOGIC_IO(bw, type)					\
 type logic_in##bw(unsigned long addr)					\
 {									\
 	type ret = (type)~0;						\
+	struct logic_pio_hwaddr *range = find_io_range(addr);		\
+									\
+	if (INVALID_RANGE(range)) {					\
+		WARN_ON_ONCE(1);					\
+		return ret;						\
+	}								\
 									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
 		ret = read##bw(PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
-		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
-									\
-		if (entry && entry->ops)				\
-			ret = entry->ops->in(entry->hostdata,		\
-					addr, sizeof(type));		\
-		else							\
-			WARN_ON_ONCE(1);				\
+		ret = range->ops->in(range->hostdata,			\
+				     addr, sizeof(type));		\
 	}								\
 	return ret;							\
 }									\
 									\
 void logic_out##bw(type value, unsigned long addr)			\
 {									\
+	struct logic_pio_hwaddr *range = find_io_range(addr);		\
+									\
+	if (INVALID_RANGE(range)) {					\
+		WARN_ON_ONCE(1);					\
+		return;							\
+	}								\
+									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
 		write##bw(value, PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
-		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
-									\
-		if (entry && entry->ops)				\
-			entry->ops->out(entry->hostdata,		\
-					addr, value, sizeof(type));	\
-		else							\
-			WARN_ON_ONCE(1);				\
+		if (range->ops && range->ops->out)			\
+			range->ops->out(range->hostdata, addr,		\
+					value, sizeof(type));		\
 	}								\
 }									\
 									\
-void logic_ins##bw(unsigned long addr, void *buffer,		\
+void logic_ins##bw(unsigned long addr, void *buffer,			\
 		   unsigned int count)					\
 {									\
+	struct logic_pio_hwaddr *range = find_io_range(addr);		\
+									\
+	if (INVALID_RANGE(range)) {					\
+		WARN_ON_ONCE(1);					\
+		return;							\
+	}								\
+									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
 		reads##bw(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
-		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
-									\
-		if (entry && entry->ops)				\
-			entry->ops->ins(entry->hostdata,		\
-				addr, buffer, sizeof(type), count);	\
-		else							\
-			WARN_ON_ONCE(1);				\
+		range->ops->ins(range->hostdata, addr, buffer,		\
+				sizeof(type), count);			\
 	}								\
-									\
 }									\
 									\
 void logic_outs##bw(unsigned long addr, const void *buffer,		\
 		    unsigned int count)					\
 {									\
+	struct logic_pio_hwaddr *range = find_io_range(addr);		\
+									\
+	if (INVALID_RANGE(range)) {					\
+		WARN_ON_ONCE(1);					\
+		return;							\
+	}								\
+									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
 		writes##bw(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
-		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
-									\
-		if (entry && entry->ops)				\
-			entry->ops->outs(entry->hostdata,		\
-				addr, buffer, sizeof(type), count);	\
-		else							\
-			WARN_ON_ONCE(1);				\
+		range->ops->outs(range->hostdata, addr, buffer,		\
+				 sizeof(type), count);			\
 	}								\
 }
 
-- 
2.17.1

