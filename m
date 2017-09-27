Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from alln-iport-1.cisco.com ([173.37.142.88]:63407 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdI0Vwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2017 17:52:31 -0400
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: benve@cisco.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com, peterz@infradead.org
Cc: Govindarajulu Varadarajan <gvaradar@cisco.com>
Subject: [PATCH 4/4] lockdep: make MAX_LOCK_DEPTH configurable from Kconfig
Date: Wed, 27 Sep 2017 14:42:20 -0700
Message-Id: <20170927214220.41216-5-gvaradar@cisco.com>
In-Reply-To: <20170927214220.41216-1-gvaradar@cisco.com>
References: <20170927214220.41216-1-gvaradar@cisco.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make MAX_LOCK_DEPTH configurable. It is set to 48 right now. Number of
VFs under a PCI pf bus can exceed 48 and this disables lockdep.

lockdep currently allows max of 63 held_locks.

Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
---
 fs/configfs/inode.c      |  2 +-
 include/linux/sched.h    |  3 +--
 kernel/locking/lockdep.c | 13 +++++++------
 lib/Kconfig.debug        | 10 ++++++++++
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index ad718e5e37bb..a1e2a7ce69d0 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -41,7 +41,7 @@
 #include "configfs_internal.h"
 
 #ifdef CONFIG_LOCKDEP
-static struct lock_class_key default_group_class[MAX_LOCK_DEPTH];
+static struct lock_class_key default_group_class[CONFIG_MAX_LOCK_DEPTH];
 #endif
 
 static const struct address_space_operations configfs_aops = {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 92fb8dd5a9e4..9a81eec702be 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -841,11 +841,10 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_LOCKDEP
-# define MAX_LOCK_DEPTH			48UL
 	u64				curr_chain_key;
 	int				lockdep_depth;
 	unsigned int			lockdep_recursion;
-	struct held_lock		held_locks[MAX_LOCK_DEPTH];
+	struct held_lock		held_locks[CONFIG_MAX_LOCK_DEPTH];
 #endif
 
 #ifdef CONFIG_LOCKDEP_CROSSRELEASE
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 44c8d0d17170..22a4a338616d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3404,7 +3404,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	/*
 	 * Ran out of static storage for our per-task lock stack again have we?
 	 */
-	if (DEBUG_LOCKS_WARN_ON(depth >= MAX_LOCK_DEPTH))
+	if (DEBUG_LOCKS_WARN_ON(depth >= CONFIG_MAX_LOCK_DEPTH))
 		return 0;
 
 	class_idx = class - lock_classes + 1;
@@ -3513,11 +3513,11 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (unlikely(!debug_locks))
 		return 0;
 #endif
-	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
+	if (unlikely(curr->lockdep_depth >= CONFIG_MAX_LOCK_DEPTH)) {
 		debug_locks_off();
 		print_lockdep_off("BUG: MAX_LOCK_DEPTH too low!");
 		printk(KERN_DEBUG "depth: %i  max: %lu!\n",
-		       curr->lockdep_depth, MAX_LOCK_DEPTH);
+		       curr->lockdep_depth, CONFIG_MAX_LOCK_DEPTH);
 
 		lockdep_print_held_locks(current);
 		debug_show_all_locks();
@@ -4276,7 +4276,8 @@ void lockdep_reset(void)
 	current->curr_chain_key = 0;
 	current->lockdep_depth = 0;
 	current->lockdep_recursion = 0;
-	memset(current->held_locks, 0, MAX_LOCK_DEPTH*sizeof(struct held_lock));
+	memset(current->held_locks, 0,
+	       CONFIG_MAX_LOCK_DEPTH * sizeof(struct held_lock));
 	nr_hardirq_chains = 0;
 	nr_softirq_chains = 0;
 	nr_process_chains = 0;
@@ -4421,7 +4422,7 @@ void __init lockdep_info(void)
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
 	printk("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
-	printk("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
+	printk("... MAX_LOCK_DEPTH:          %lu\n", CONFIG_MAX_LOCK_DEPTH);
 	printk("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
 	printk("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
 	printk("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
@@ -4441,7 +4442,7 @@ void __init lockdep_info(void)
 		);
 
 	printk(" per task-struct memory footprint: %lu bytes\n",
-		sizeof(struct held_lock) * MAX_LOCK_DEPTH);
+		sizeof(struct held_lock) * CONFIG_MAX_LOCK_DEPTH);
 }
 
 static void
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2689b7c50c52..60bc084315a6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1187,6 +1187,16 @@ config DEBUG_LOCKDEP
 	  additional runtime checks to debug itself, at the price
 	  of more runtime overhead.
 
+config MAX_LOCK_DEPTH
+	int "Maximum held_locks depth"
+	depends on DEBUG_LOCKDEP
+	default 48
+	range 1 63
+	help
+	  This is maximum held_lock depth in task_struct for debugging.
+	  Increment if you think a task can hold more than default(48) locks.
+	  If unsure, set to default value, 48.
+
 config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
 	select PREEMPT_COUNT
-- 
2.14.1
