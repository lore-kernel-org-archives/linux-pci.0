Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22527 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212AbbFAIIS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Jun 2015 04:08:18 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Feng Wu <feng.wu@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Brian Gerst <brgerst@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Juergen Gross <jgross@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, xen-devel@lists.xenproject.org
Subject: [Patch v3 27/36] x86, irq: Use access helper irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:36 +0800
Message-Id: <1433145945-789-28-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/apic/io_apic.c   |    2 +-
 arch/x86/kernel/apic/vector.c    |    5 ++---
 arch/x86/kernel/irq.c            |    5 +++--
 drivers/xen/events/events_base.c |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 845dc0df2002..09921de4210f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2541,7 +2541,7 @@ void __init setup_ioapic_dest(void)
 		 * Honour affinities which have been set in early boot
 		 */
 		if (!irqd_can_balance(idata) || irqd_affinity_was_set(idata))
-			mask = idata->affinity;
+			mask = irq_data_get_affinity_mask(idata);
 		else
 			mask = apic->target_cpus();
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 9b62f690b0ff..dfa3a5f5b3d3 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -494,9 +494,8 @@ static int apic_set_affinity(struct irq_data *irq_data,
 
 	err = assign_irq_vector(irq, data, dest);
 	if (err) {
-		struct irq_data *top = irq_get_irq_data(irq);
-
-		if (assign_irq_vector(irq, data, top->affinity))
+		if (assign_irq_vector(irq, data,
+				      irq_data_get_affinity_mask(irq_data)))
 			pr_err("Failed to recover vector for irq %d\n", irq);
 		return err;
 	}
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 7e10c8b4b318..37685e37550c 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -342,7 +342,8 @@ int check_irq_vectors_for_cpu_disable(void)
 				continue;
 
 			data = irq_desc_get_irq_data(desc);
-			cpumask_copy(&affinity_new, data->affinity);
+			cpumask_copy(&affinity_new,
+				     irq_data_get_affinity_mask(data));
 			cpumask_clear_cpu(this_cpu, &affinity_new);
 
 			/* Do not count inactive or per-cpu irqs. */
@@ -420,7 +421,7 @@ void fixup_irqs(void)
 		raw_spin_lock(&desc->lock);
 
 		data = irq_desc_get_irq_data(desc);
-		affinity = data->affinity;
+		affinity = irq_data_get_affinity_mask(data);
 		if (!irq_has_action(irq) || irqd_is_per_cpu(data) ||
 		    cpumask_subset(affinity, cpu_online_mask)) {
 			raw_spin_unlock(&desc->lock);
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 2b8553bd8715..d00e0be8e9ea 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -336,7 +336,7 @@ static void bind_evtchn_to_cpu(unsigned int chn, unsigned int cpu)
 
 	BUG_ON(irq == -1);
 #ifdef CONFIG_SMP
-	cpumask_copy(irq_get_irq_data(irq)->affinity, cpumask_of(cpu));
+	cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(cpu));
 #endif
 	xen_evtchn_port_bind_to_cpu(info, cpu);
 
@@ -373,7 +373,7 @@ static void xen_irq_init(unsigned irq)
 	struct irq_info *info;
 #ifdef CONFIG_SMP
 	/* By default all event channels notify CPU#0. */
-	cpumask_copy(irq_get_irq_data(irq)->affinity, cpumask_of(0));
+	cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(0));
 #endif
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-- 
1.7.10.4

