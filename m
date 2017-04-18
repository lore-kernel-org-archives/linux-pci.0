Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:53161 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbdDRTut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2017 15:50:49 -0400
Message-Id: <20170418170553.885818800@linutronix.de>
Date: Tue, 18 Apr 2017 19:05:00 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [patch V2 18/24] PCI: Replace the racy recursion prevention
References: <20170418170442.665445272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_call_probe() can called recursively when a physcial function is probed
and the probing creates virtual functions, which are populated via
pci_bus_add_device() which in turn can end up calling pci_call_probe()
again.

The code has an interesting way to prevent recursing into the workqueue
code.  That's accomplished by a check whether the current task runs already
on the numa node which is associated with the device.

While that works to prevent the recursion into the workqueue code, it's
racy versus normal execution as there is no guarantee that the node does
not vanish after the check.

There is another issue with this code. It dereferences cpumask_of_node()
unconditionally without checking whether the node is available.

Make the detection reliable by:

 - Mark a probed device as 'is_probed' in pci_call_probe()
 
 - Check in pci_call_probe for a virtual function. If it's a virtual
   function and the associated physical function device is marked
   'is_probed' then this is a recursive call, so the call can be invoked in
   the calling context.

 - Add a check whether the node is online before dereferencing it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-driver.c |   47 +++++++++++++++++++++++++----------------------
 include/linux/pci.h      |    1 +
 2 files changed, 26 insertions(+), 22 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -320,10 +320,19 @@ static long local_pci_probe(void *_ddi)
 	return 0;
 }
 
+static bool pci_physfn_is_probed(struct pci_dev *dev)
+{
+#ifdef CONFIG_ATS
+	return dev->is_virtfn && dev->physfn->is_probed;
+#else
+	return false;
+#endif
+}
+
 static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			  const struct pci_device_id *id)
 {
-	int error, node;
+	int error, node, cpu;
 	struct drv_dev_and_id ddi = { drv, dev, id };
 
 	/*
@@ -332,33 +341,27 @@ static int pci_call_probe(struct pci_dri
 	 * on the right node.
 	 */
 	node = dev_to_node(&dev->dev);
+	dev->is_probed = 1;
+
+	cpu_hotplug_disable();
 
 	/*
-	 * On NUMA systems, we are likely to call a PF probe function using
-	 * work_on_cpu().  If that probe calls pci_enable_sriov() (which
-	 * adds the VF devices via pci_bus_add_device()), we may re-enter
-	 * this function to call the VF probe function.  Calling
-	 * work_on_cpu() again will cause a lockdep warning.  Since VFs are
-	 * always on the same node as the PF, we can work around this by
-	 * avoiding work_on_cpu() when we're already on the correct node.
-	 *
-	 * Preemption is enabled, so it's theoretically unsafe to use
-	 * numa_node_id(), but even if we run the probe function on the
-	 * wrong node, it should be functionally correct.
+	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
+	 * device is probed from work_on_cpu() of the Physical device.
 	 */
-	if (node >= 0 && node != numa_node_id()) {
-		int cpu;
-
-		cpu_hotplug_disable();
+	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
+	    pci_physfn_is_probed(dev))
+		cpu = nr_cpu_ids;
+	else
 		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
-		if (cpu < nr_cpu_ids)
-			error = work_on_cpu(cpu, local_pci_probe, &ddi);
-		else
-			error = local_pci_probe(&ddi);
-		cpu_hotplug_enable();
-	} else
+
+	if (cpu < nr_cpu_ids)
+		error = work_on_cpu(cpu, local_pci_probe, &ddi);
+	else
 		error = local_pci_probe(&ddi);
 
+	dev->is_probed = 0;
+	cpu_hotplug_enable();
 	return error;
 }
 
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -365,6 +365,7 @@ struct pci_dev {
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
 	unsigned int	non_compliant_bars:1;	/* broken BARs; ignore them */
+	unsigned int	is_probed:1;		/* device probing in progress */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
