Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E3C10F0F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC016217D4
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfDDQAc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:00:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728654AbfDDQAc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 12:00:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3EEFDB694C499E26B0A8;
        Fri,  5 Apr 2019 00:00:29 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Fri, 5 Apr 2019 00:00:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>
CC:     <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <bp@suse.de>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andy.shevchenko@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v3 2/4] lib: logic_pio: Use logical PIO low-level accessors for !CONFIG_INDIRECT_PIO
Date:   Fri, 5 Apr 2019 00:00:00 +0800
Message-ID: <1554393602-152448-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently we only use logical PIO low-level accessors for when
CONFIG_INDIRECT_PIO is enabled.

Otherwise we just use inb/out et all directly.

It is useful to now use logical PIO accessors for all cases, so we can add
legality checks to accesses. Such a check would be for ensuring that the
PCI IO port has been IO remapped prior to the access.

Using the logical PIO accesses will add a little processing overhead, but
that's ok as IO port accesses are relatively slow anyway.

Some changes are also made to stop spilling so many lines under
CONFIG_INDIRECT_PIO.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/logic_pio.h |  7 +++--
 lib/logic_pio.c           | 61 ++++++++++++++++++++++++++++++---------
 2 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index cbd9d8495690..06d22b2ec99f 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -37,7 +37,7 @@ struct logic_pio_host_ops {
 		     size_t dwidth, unsigned int count);
 };
 
-#ifdef CONFIG_INDIRECT_PIO
+#if defined(PCI_IOBASE)
 u8 logic_inb(unsigned long addr);
 void logic_outb(u8 value, unsigned long addr);
 void logic_outw(u16 value, unsigned long addr);
@@ -102,6 +102,7 @@ void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
 #define outsl logic_outsl
 #endif
 
+#if defined(CONFIG_INDIRECT_PIO)
 /*
  * We reserve 0x4000 bytes for Indirect IO as so far this library is only
  * used by the HiSilicon LPC Host. If needed, we can reserve a wider IO
@@ -109,10 +110,10 @@ void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
  */
 #define PIO_INDIRECT_SIZE 0x4000
 #define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
-#else
+#else /* CONFIG_INDIRECT_PIO */
 #define MMIO_UPPER_LIMIT IO_SPACE_LIMIT
 #endif /* CONFIG_INDIRECT_PIO */
-
+#endif /* PCI_IOBASE */
 struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
 unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
 			resource_size_t hw_addr, resource_size_t size);
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index feea48fd1a0d..431cd8d99236 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -191,7 +191,8 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 	return ~0UL;
 }
 
-#if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
+#if defined(PCI_IOBASE)
+#if defined(CONFIG_INDIRECT_PIO)
 #define BUILD_LOGIC_IO(bw, type)					\
 type logic_in##bw(unsigned long addr)					\
 {									\
@@ -201,10 +202,10 @@ type logic_in##bw(unsigned long addr)					\
 		ret = read##bw(PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+		size_t sz = sizeof(type);				\
 									\
 		if (entry && entry->ops)				\
-			ret = entry->ops->in(entry->hostdata,		\
-					addr, sizeof(type));		\
+			ret = entry->ops->in(entry->hostdata, addr, sz);\
 		else							\
 			WARN_ON_ONCE(1);				\
 	}								\
@@ -217,48 +218,82 @@ void logic_out##bw(type value, unsigned long addr)			\
 		write##bw(value, PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+		size_t sz = sizeof(type);				\
 									\
 		if (entry && entry->ops)				\
 			entry->ops->out(entry->hostdata,		\
-					addr, value, sizeof(type));	\
+					addr, value, sz);		\
 		else							\
 			WARN_ON_ONCE(1);				\
 	}								\
 }									\
 									\
-void logic_ins##bw(unsigned long addr, void *buffer,		\
-		   unsigned int count)					\
+void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+		size_t sz = sizeof(type);				\
 									\
 		if (entry && entry->ops)				\
 			entry->ops->ins(entry->hostdata,		\
-				addr, buffer, sizeof(type), count);	\
+				addr, buf, sz, cnt);			\
 		else							\
 			WARN_ON_ONCE(1);				\
 	}								\
 									\
 }									\
 									\
-void logic_outs##bw(unsigned long addr, const void *buffer,		\
-		    unsigned int count)					\
+void logic_outs##bw(unsigned long addr, const void *buf,		\
+		    unsigned int cnt)					\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		writes##bw(PCI_IOBASE + addr, buffer, count);		\
+		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+		size_t sz = sizeof(type);				\
 									\
 		if (entry && entry->ops)				\
 			entry->ops->outs(entry->hostdata,		\
-				addr, buffer, sizeof(type), count);	\
+				addr, buf, sz, cnt);			\
 		else							\
 			WARN_ON_ONCE(1);				\
 	}								\
 }
 
+#else /* CONFIG_INDIRECT_PIO */
+
+#define BUILD_LOGIC_IO(bw, type)					\
+type logic_in##bw(unsigned long addr)					\
+{									\
+	type ret = (type)~0;						\
+									\
+	if (addr < MMIO_UPPER_LIMIT)					\
+		ret = read##bw(PCI_IOBASE + addr);			\
+	return ret;							\
+}									\
+									\
+void logic_out##bw(type value, unsigned long addr)			\
+{									\
+	if (addr < MMIO_UPPER_LIMIT)					\
+		write##bw(value, PCI_IOBASE + addr);			\
+}									\
+									\
+void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
+{									\
+	if (addr < MMIO_UPPER_LIMIT)					\
+		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
+}									\
+									\
+void logic_outs##bw(unsigned long addr, const void *buf,		\
+		    unsigned int cnt)					\
+{									\
+	if (addr < MMIO_UPPER_LIMIT)					\
+		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
+}
+#endif /* CONFIG_INDIRECT_PIO */
+
 BUILD_LOGIC_IO(b, u8)
 EXPORT_SYMBOL(logic_inb);
 EXPORT_SYMBOL(logic_insb);
@@ -277,4 +312,4 @@ EXPORT_SYMBOL(logic_insl);
 EXPORT_SYMBOL(logic_outl);
 EXPORT_SYMBOL(logic_outsl);
 
-#endif /* CONFIG_INDIRECT_PIO && PCI_IOBASE */
+#endif /* PCI_IOBASE */
-- 
2.17.1

