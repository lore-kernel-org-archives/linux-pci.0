Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] blk-mq: allow the driver to pass in an affinity mask
Date: Fri, 15 Apr 2016 18:35:49 -0700
Message-Id: <1460770552-31260-6-git-send-email-hch@lst.de>
In-Reply-To: <1460770552-31260-1-git-send-email-hch@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow drivers to pass in the affinity mask from the generic interrupt
layer, and spread queues based on that.  If the driver doesn't pass in
a mask we will create it using the genirq helper.  As this helper was
modelled after the blk-mq algorithm there should be no change in behavior.

XXX: Just as with the core IRQ spreading code this doesn't handle CPU
hotplug yet.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile         |   2 +-
 block/blk-mq-cpumap.c  | 120 -------------------------------------------------
 block/blk-mq.c         |  60 ++++++++++++++++++++++++-
 block/blk-mq.h         |   8 ----
 include/linux/blk-mq.h |   1 +
 5 files changed, 60 insertions(+), 131 deletions(-)
 delete mode 100644 block/blk-mq-cpumap.c

diff --git a/block/Makefile b/block/Makefile
index 9eda232..aeb318d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-tag.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-exec.o blk-merge.o blk-softirq.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o \
-			blk-mq-sysfs.o blk-mq-cpu.o blk-mq-cpumap.o ioctl.o \
+			blk-mq-sysfs.o blk-mq-cpu.o ioctl.o \
 			genhd.o scsi_ioctl.o partition-generic.o ioprio.o \
 			badblocks.o partitions/
 
diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
deleted file mode 100644
index d0634bc..0000000
--- a/block/blk-mq-cpumap.c
+++ /dev/null
@@ -1,120 +0,0 @@
-/*
- * CPU <-> hardware queue mapping helpers
- *
- * Copyright (C) 2013-2014 Jens Axboe
- */
-#include <linux/kernel.h>
-#include <linux/threads.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/cpu.h>
-
-#include <linux/blk-mq.h>
-#include "blk.h"
-#include "blk-mq.h"
-
-static int cpu_to_queue_index(unsigned int nr_cpus, unsigned int nr_queues,
-			      const int cpu)
-{
-	return cpu * nr_queues / nr_cpus;
-}
-
-static int get_first_sibling(unsigned int cpu)
-{
-	unsigned int ret;
-
-	ret = cpumask_first(topology_sibling_cpumask(cpu));
-	if (ret < nr_cpu_ids)
-		return ret;
-
-	return cpu;
-}
-
-int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
-			    const struct cpumask *online_mask)
-{
-	unsigned int i, nr_cpus, nr_uniq_cpus, queue, first_sibling;
-	cpumask_var_t cpus;
-
-	if (!alloc_cpumask_var(&cpus, GFP_ATOMIC))
-		return 1;
-
-	cpumask_clear(cpus);
-	nr_cpus = nr_uniq_cpus = 0;
-	for_each_cpu(i, online_mask) {
-		nr_cpus++;
-		first_sibling = get_first_sibling(i);
-		if (!cpumask_test_cpu(first_sibling, cpus))
-			nr_uniq_cpus++;
-		cpumask_set_cpu(i, cpus);
-	}
-
-	queue = 0;
-	for_each_possible_cpu(i) {
-		if (!cpumask_test_cpu(i, online_mask)) {
-			map[i] = 0;
-			continue;
-		}
-
-		/*
-		 * Easy case - we have equal or more hardware queues. Or
-		 * there are no thread siblings to take into account. Do
-		 * 1:1 if enough, or sequential mapping if less.
-		 */
-		if (nr_queues >= nr_cpus || nr_cpus == nr_uniq_cpus) {
-			map[i] = cpu_to_queue_index(nr_cpus, nr_queues, queue);
-			queue++;
-			continue;
-		}
-
-		/*
-		 * Less then nr_cpus queues, and we have some number of
-		 * threads per cores. Map sibling threads to the same
-		 * queue.
-		 */
-		first_sibling = get_first_sibling(i);
-		if (first_sibling == i) {
-			map[i] = cpu_to_queue_index(nr_uniq_cpus, nr_queues,
-							queue);
-			queue++;
-		} else
-			map[i] = map[first_sibling];
-	}
-
-	free_cpumask_var(cpus);
-	return 0;
-}
-
-unsigned int *blk_mq_make_queue_map(struct blk_mq_tag_set *set)
-{
-	unsigned int *map;
-
-	/* If cpus are offline, map them to first hctx */
-	map = kzalloc_node(sizeof(*map) * nr_cpu_ids, GFP_KERNEL,
-				set->numa_node);
-	if (!map)
-		return NULL;
-
-	if (!blk_mq_update_queue_map(map, set->nr_hw_queues, cpu_online_mask))
-		return map;
-
-	kfree(map);
-	return NULL;
-}
-
-/*
- * We have no quick way of doing reverse lookups. This is only used at
- * queue init time, so runtime isn't important.
- */
-int blk_mq_hw_queue_to_node(unsigned int *mq_map, unsigned int index)
-{
-	int i;
-
-	for_each_possible_cpu(i) {
-		if (index == mq_map[i])
-			return local_memory_node(cpu_to_node(i));
-	}
-
-	return NUMA_NO_NODE;
-}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1699baf..ab156bb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -22,6 +22,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
+#include <linux/interrupt.h>
 
 #include <trace/events/block.h>
 
@@ -1954,6 +1955,22 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
+/*
+ * We have no quick way of doing reverse lookups. This is only used at
+ * queue init time, so runtime isn't important.
+ */
+static int blk_mq_hw_queue_to_node(unsigned int *mq_map, unsigned int index)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		if (index == mq_map[i])
+			return local_memory_node(cpu_to_node(i));
+	}
+
+	return NUMA_NO_NODE;
+}
+
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
@@ -2013,6 +2030,30 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	blk_mq_sysfs_register(q);
 }
 
+static unsigned int *
+affinity_mask_to_queue_map(const struct cpumask *affinity_mask, int node)
+{
+	unsigned int *map;
+	int queue = -1, cpu = 0;
+
+	map = kzalloc_node(sizeof(*map) * nr_cpu_ids, GFP_KERNEL, node);
+	if (!map)
+		return NULL;
+
+	if (!affinity_mask)
+		return map;	/* map all cpus to queue 0 */
+
+	/* If cpus are offline, map them to first hctx */
+	for_each_online_cpu(cpu) {
+		if (cpumask_test_cpu(cpu, affinity_mask))
+			queue++;
+		if (queue > 0)
+			map[cpu] = queue;
+	}
+
+	return map;
+}
+
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
@@ -2028,7 +2069,21 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
 
-	q->mq_map = blk_mq_make_queue_map(set);
+	if (set->affinity_mask) {
+		q->mq_map = affinity_mask_to_queue_map(set->affinity_mask,
+				set->numa_node);
+	} else {
+		struct cpumask *affinity_mask;
+		int ret;
+
+		ret = irq_create_affinity_mask(&affinity_mask, set->nr_hw_queues);
+		if (ret)
+			goto err_map;
+
+		q->mq_map = affinity_mask_to_queue_map(affinity_mask, set->numa_node);
+		kfree(affinity_mask);
+	}
+
 	if (!q->mq_map)
 		goto err_map;
 
@@ -2111,7 +2166,8 @@ static void blk_mq_queue_reinit(struct request_queue *q,
 
 	blk_mq_sysfs_unregister(q);
 
-	blk_mq_update_queue_map(q->mq_map, q->nr_hw_queues, online_mask);
+//	XXX: figure out what to do about cpu hotplug in the new world order
+//	blk_mq_update_queue_map(q->mq_map, q->nr_hw_queues, online_mask);
 
 	/*
 	 * redo blk_mq_init_cpu_queues and blk_mq_init_hw_queues. FIXME: maybe
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9087b11..fe7e21f 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -45,14 +45,6 @@ void blk_mq_enable_hotplug(void);
 void blk_mq_disable_hotplug(void);
 
 /*
- * CPU -> queue mappings
- */
-extern unsigned int *blk_mq_make_queue_map(struct blk_mq_tag_set *set);
-extern int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
-				   const struct cpumask *online_mask);
-extern int blk_mq_hw_queue_to_node(unsigned int *map, unsigned int);
-
-/*
  * sysfs helpers
  */
 extern int blk_mq_sysfs_register(struct request_queue *q);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2498fdf..21ffe10 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -74,6 +74,7 @@ struct blk_mq_tag_set {
 	unsigned int		timeout;
 	unsigned int		flags;		/* BLK_MQ_F_* */
 	void			*driver_data;
+	struct cpumask		*affinity_mask;
 
 	struct blk_mq_tags	**tags;
 
-- 
2.1.4
