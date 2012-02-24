Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 02/13] genirq: Split __irq_reserve_irqs from irq_alloc_descs
Date: Thu, 23 Feb 2012 19:48:48 -0800
Message-Id: <1330055339-11662-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330055339-11662-1-git-send-email-yinghai@kernel.org>
References: <1330055339-11662-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

also make irq_reserve_irqs to reuse __irq_reserve_irqs.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Daney <ddaney@caviumnetworks.com>
---
 include/linux/irq.h  |    1 +
 kernel/irq/irqdesc.c |   55 ++++++++++++++++++++++++-------------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index bff29c5..7a9a19b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -582,6 +582,7 @@ int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 
 void irq_free_descs(unsigned int irq, unsigned int cnt);
 int irq_reserve_irqs(unsigned int from, unsigned int cnt);
+int __irq_reserve_irqs(int irq, unsigned int from, unsigned int cnt);
 
 static inline void irq_free_desc(unsigned int irq)
 {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index d86e254..3e23bb9 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -338,19 +338,8 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
 }
 EXPORT_SYMBOL_GPL(irq_free_descs);
 
-/**
- * irq_alloc_descs - allocate and initialize a range of irq descriptors
- * @irq:	Allocate for specific irq number if irq >= 0
- * @from:	Start the search from this irq number
- * @cnt:	Number of consecutive irqs to allocate.
- * @node:	Preferred node on which the irq descriptor should be allocated
- * @owner:	Owning module (can be NULL)
- *
- * Returns the first irq number or error code
- */
 int __ref
-__irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		  struct module *owner)
+__irq_reserve_irqs(int irq, unsigned int from, unsigned int cnt)
 {
 	int start, ret;
 
@@ -368,7 +357,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 	start = bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
 					   from, cnt, 0);
 	ret = -EEXIST;
-	if (irq >=0 && start != irq)
+	if (irq >= 0 && start != irq)
 		goto err;
 
 	if (start + cnt > nr_irqs) {
@@ -379,12 +368,35 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 
 	bitmap_set(allocated_irqs, start, cnt);
 	mutex_unlock(&sparse_irq_lock);
-	return alloc_descs(start, cnt, node, owner);
+	return start;
 
 err:
 	mutex_unlock(&sparse_irq_lock);
 	return ret;
 }
+/**
+ * irq_alloc_descs - allocate and initialize a range of irq descriptors
+ * @irq:	Allocate for specific irq number if irq >= 0
+ * @from:	Start the search from this irq number
+ * @cnt:	Number of consecutive irqs to allocate.
+ * @node:	Preferred node on which the irq descriptor should be allocated
+ * @owner:	Owning module (can be NULL)
+ *
+ * Returns the first irq number or error code
+ */
+int __ref
+__irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
+		  struct module *owner)
+{
+	int start;
+
+	start = __irq_reserve_irqs(irq, from, cnt);
+
+	if (start < 0)
+		return start;
+
+	return alloc_descs(start, cnt, node, owner);
+}
 EXPORT_SYMBOL_GPL(__irq_alloc_descs);
 
 /**
@@ -396,20 +408,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  */
 int irq_reserve_irqs(unsigned int from, unsigned int cnt)
 {
-	unsigned int start;
-	int ret = 0;
-
-	if (!cnt || (from + cnt) > nr_irqs)
-		return -EINVAL;
-
-	mutex_lock(&sparse_irq_lock);
-	start = bitmap_find_next_zero_area(allocated_irqs, nr_irqs, from, cnt, 0);
-	if (start == from)
-		bitmap_set(allocated_irqs, start, cnt);
-	else
-		ret = -EEXIST;
-	mutex_unlock(&sparse_irq_lock);
-	return ret;
+	return __irq_reserve_irqs(from, from, cnt);
 }
 
 /**
-- 
1.7.7

