Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8932BF43
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094400; cv=none; b=iALUa81wLWg1UUXZnBf/+1XP9hUeMiNSOC2D4bME1HjGqgUo4k8drnHDkjil4mOOQ0Ycj2B86a0He2+by4uk9zamouLzsNAfsDHPdD5z4y2TjpeaL61zQqdvHD1bOSNMy1957lOdOJYKn1chKMB/zqd5bMd+PSsiM3ecIKAnjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094400; c=relaxed/simple;
	bh=ZS4UOSrNS+KfGTKnJgHgc3eBCljR5+cbx3Y7xDJqgv0=;
	h=Mime-Version:Content-Type:Message-Id:In-Reply-To:To:Date:
	 References:Cc:From:Subject; b=Tdy4VWylNqPK0Q50lmTq3ChTaQ+e0Nl033SXNxCwM7a+9IzWZSBLMH1Q3JKh1JW8Hh8CLymd2BaEfgr/WCyllCakET9Xj0/COqBahQCKdXk3zLzdF4Ls8dLX+eDviuPN2V/iZpJ6A+BRo813wh1Eh01Yc28QjMt+5NPAEtbLHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PamVu+UK; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PamVu+UK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1769093666; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PMVB8s5v8HETmoix20BnmGHUQkrMR5TqEENrEuudru4=;
 b=PamVu+UKvInV/O1wAxegBTRvpf05nQAUp8rLRQjGzsWudMMPnrM5SpgTjYfCPYwFnYwXow
 DOVQUnSSfk12nidwkHedeqYeuO32PpL6DICDvzN7Jf/eNGt/nfCh5RLOkbdpXsDNizk62z
 +k7CTDLjpWYzIrLz87Et3UDKXEH1C8wljN7a/ljqIbp3is6uJeA9Im4Jo9ix2Ylq3xDYZz
 gypigMYUeZbF4wEWA4LC/5N0YW6VrRe98+kp8l2ZlTVG36ZFWLgAX71ZOraCPHjm+RPOYo
 nsZBOZmUELTmokilqmwOZL/lYD1oJ2iQZXOviGk1LDbMfF1t0A5xF/DpjYEljQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260122145208.1013-4-guojinhui.liam@bytedance.com>
In-Reply-To: <20260122145208.1013-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
To: <dakr@kernel.org>, <alexanderduyck@fb.com>, <bhelgaas@google.com>, 
	<bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<gregkh@linuxfoundation.org>, <helgaas@kernel.org>, <rafael@kernel.org>, 
	<tj@kernel.org>, <frederic@kernel.org>
Date: Thu, 22 Jan 2026 22:52:08 +0800
References: <20260122145208.1013-1-guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+269723a20+2a79bd+vger.kernel.org+guojinhui.liam@bytedance.com>
Cc: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [PATCH v2 3/3] PCI: Clean up NUMA-node awareness in pci_bus_type probe
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit

With NUMA-node-aware probing now handled by the driver core,
the equivalent code in the PCI driver is redundant and can
be removed.

Dropping it speeds up asynchronous probe by 35%; the gain
comes from eliminating the work_on_cpu() call in pci_call_probe()
that previously pinned every worker to the same CPU, forcing
serial probe of devices on the same NUMA node.

Testing three NVMe devices on the same NUMA node of an AMD
EPYC 9A64 2.4 GHz processor shows a 35% probe-time improvement
with the patch:

Before (all on CPU 0):
  nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, cost: 52266334ns
  nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:0, cost: 50787194ns
  nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:2, cost: 50541584ns

After (spread across CPUs 1, 2, 4):
  nvme 0000:01:00.0: CPU: 1, COMM: kworker/u1025:2, cost: 35399608ns
  nvme 0000:02:00.0: CPU: 2, COMM: kworker/u1025:3, cost: 35156157ns
  nvme 0000:03:00.0: CPU: 4, COMM: kworker/u1025:0, cost: 35322116ns

The improvement grows with more PCI devices because fewer probes
contend for the same CPU.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/pci-driver.c | 116 +++------------------------------------
 include/linux/pci.h      |   4 --
 kernel/sched/isolation.c |   2 -
 3 files changed, 8 insertions(+), 114 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6b80400ee9b9..258f16da6550 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -296,17 +296,9 @@ static struct attribute *pci_drv_attrs[] = {
 };
 ATTRIBUTE_GROUPS(pci_drv);
 
-struct drv_dev_and_id {
-	struct pci_driver *drv;
-	struct pci_dev *dev;
-	const struct pci_device_id *id;
-};
-
-static int local_pci_probe(struct drv_dev_and_id *ddi)
+static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
+			  const struct pci_device_id *id)
 {
-	struct pci_dev *pci_dev = ddi->dev;
-	struct pci_driver *pci_drv = ddi->drv;
-	struct device *dev = &pci_dev->dev;
 	int rc;
 
 	/*
@@ -318,113 +310,25 @@ static int local_pci_probe(struct drv_dev_and_id *ddi)
 	 * count, in its probe routine and pm_runtime_get_noresume() in
 	 * its remove routine.
 	 */
-	pm_runtime_get_sync(dev);
-	pci_dev->driver = pci_drv;
-	rc = pci_drv->probe(pci_dev, ddi->id);
+	pm_runtime_get_sync(&dev->dev);
+	dev->driver = drv;
+	rc = drv->probe(dev, id);
 	if (!rc)
 		return rc;
 	if (rc < 0) {
-		pci_dev->driver = NULL;
-		pm_runtime_put_sync(dev);
+		dev->driver = NULL;
+		pm_runtime_put_sync(&dev->dev);
 		return rc;
 	}
 	/*
 	 * Probe function should return < 0 for failure, 0 for success
 	 * Treat values > 0 as success, but warn.
 	 */
-	pci_warn(pci_dev, "Driver probe function unexpectedly returned %d\n",
+	pci_warn(dev, "Driver probe function unexpectedly returned %d\n",
 		 rc);
 	return 0;
 }
 
-static struct workqueue_struct *pci_probe_wq;
-
-struct pci_probe_arg {
-	struct drv_dev_and_id *ddi;
-	struct work_struct work;
-	int ret;
-};
-
-static void local_pci_probe_callback(struct work_struct *work)
-{
-	struct pci_probe_arg *arg = container_of(work, struct pci_probe_arg, work);
-
-	arg->ret = local_pci_probe(arg->ddi);
-}
-
-static bool pci_physfn_is_probed(struct pci_dev *dev)
-{
-#ifdef CONFIG_PCI_IOV
-	return dev->is_virtfn && dev->physfn->is_probed;
-#else
-	return false;
-#endif
-}
-
-static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
-			  const struct pci_device_id *id)
-{
-	int error, node, cpu;
-	struct drv_dev_and_id ddi = { drv, dev, id };
-
-	/*
-	 * Execute driver initialization on node where the device is
-	 * attached.  This way the driver likely allocates its local memory
-	 * on the right node.
-	 */
-	node = dev_to_node(&dev->dev);
-	dev->is_probed = 1;
-
-	cpu_hotplug_disable();
-	/*
-	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
-	 * device is probed from work_on_cpu() of the Physical device.
-	 */
-	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev)) {
-		error = local_pci_probe(&ddi);
-	} else {
-		struct pci_probe_arg arg = { .ddi = &ddi };
-
-		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
-		/*
-		 * The target election and the enqueue of the work must be within
-		 * the same RCU read side section so that when the workqueue pool
-		 * is flushed after a housekeeping cpumask update, further readers
-		 * are guaranteed to queue the probing work to the appropriate
-		 * targets.
-		 */
-		rcu_read_lock();
-		cpu = cpumask_any_and(cpumask_of_node(node),
-				      housekeeping_cpumask(HK_TYPE_DOMAIN));
-
-		if (cpu < nr_cpu_ids) {
-			struct workqueue_struct *wq = pci_probe_wq;
-
-			if (WARN_ON_ONCE(!wq))
-				wq = system_percpu_wq;
-			queue_work_on(cpu, wq, &arg.work);
-			rcu_read_unlock();
-			flush_work(&arg.work);
-			error = arg.ret;
-		} else {
-			rcu_read_unlock();
-			error = local_pci_probe(&ddi);
-		}
-
-		destroy_work_on_stack(&arg.work);
-	}
-
-	dev->is_probed = 0;
-	cpu_hotplug_enable();
-	return error;
-}
-
-void pci_probe_flush_workqueue(void)
-{
-	flush_workqueue(pci_probe_wq);
-}
-
 /**
  * __pci_device_probe - check if a driver wants to claim a specific PCI device
  * @drv: driver to call to check if it wants the PCI device
@@ -1734,10 +1638,6 @@ static int __init pci_driver_init(void)
 {
 	int ret;
 
-	pci_probe_wq = alloc_workqueue("sync_wq", WQ_PERCPU, 0);
-	if (!pci_probe_wq)
-		return -ENOMEM;
-
 	ret = bus_register(&pci_bus_type);
 	if (ret)
 		return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7e36936bb37a..ae05faa105e2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -486,7 +486,6 @@ struct pci_dev {
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
-	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
@@ -1211,7 +1210,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
 int pci_host_probe(struct pci_host_bridge *bridge);
-void pci_probe_flush_workqueue(void);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
@@ -2085,8 +2083,6 @@ static inline int pci_has_flag(int flag) { return 0; }
 _PCI_NOP_ALL(read, *)
 _PCI_NOP_ALL(write,)
 
-static inline void pci_probe_flush_workqueue(void) { }
-
 static inline struct pci_dev *pci_get_device(unsigned int vendor,
 					     unsigned int device,
 					     struct pci_dev *from)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ef152d401fe2..3d28d8163ee4 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,7 +8,6 @@
  *
  */
 #include <linux/sched/isolation.h>
-#include <linux/pci.h>
 #include "sched.h"
 
 enum hk_flags {
@@ -144,7 +143,6 @@ int housekeeping_update(struct cpumask *isol_mask)
 
 	synchronize_rcu();
 
-	pci_probe_flush_workqueue();
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
 
-- 
2.20.1
