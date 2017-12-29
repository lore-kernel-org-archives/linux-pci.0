Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41524 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755298AbdL2Lrk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 06:47:40 -0500
Date: Fri, 29 Dec 2017 06:49:15 -0500
From: Alexandru Chirvasitu <achirvasub@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Message-ID: <20171229114915.GF10658@chirva-slack.chirva-slack>
References: <20171228175009.ucxr4to2nb42e3s4@D-69-91-141-110.dhcp4.washington.edu>
 <alpine.DEB.2.20.1712281930590.1899@nanos>
 <alpine.DEB.2.20.1712282253180.1899@nanos>
 <20171228225014.GE10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712282357380.1899@nanos>
 <alpine.DEB.2.20.1712290018210.1899@nanos>
 <20171228233058.c76a4upqbx6elmvg@D-69-91-141-110.dhcp4.washington.edu>
 <alpine.DEB.2.20.1712290034420.1899@nanos>
 <20171228235909.iz2pevxo4vnczu54@D-69-91-141-110.dhcp4.washington.edu>
 <alpine.DEB.2.20.1712290906500.1899@nanos>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zaRBsRFn0XYhEU69"
In-Reply-To: <alpine.DEB.2.20.1712290906500.1899@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

All right, I tried to do some more digging around, in the hope of
getting as close to the source of the problem as I can.

I went back to the very first commit that went astray for me, 2db1f95
(which is the only one actually panicking), and tried to move from its
parent 90ad9e2 (that boots fine) to it gradually, altering the code in
small chunks.

I tried to ignore the stuff that clearly shouldn't make a difference,
such as definitions. So in the end I get defined-but-unused-function
errors in my compilations, but I'm ignoring those for now. Some
results:

(1) When I move from the good commit 90ad9e2 according to the attached
bad-diff (which moves partly towards 2db1f95), I get a panic.

(2) On the other hand, when I further change this last panicking
commit by simply doing


----------------------------------------------------------------
    removed activate / deactivate from x86_vector_domain_ops

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 7317ba5a..063594d 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -514,8 +514,6 @@ void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
 static const struct irq_domain_ops x86_vector_domain_ops = {
        .alloc          = x86_vector_alloc_irqs,
        .free           = x86_vector_free_irqs,
-       .activate       = x86_vector_activate,
-       .deactivate     = x86_vector_deactivate,
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
        .debug_show     = x86_vector_debug_show,
 #endif
----------------------------------------------------------------

all is well. 




On Fri, Dec 29, 2017 at 09:07:45AM +0100, Thomas Gleixner wrote:
> On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:
> > On Fri, Dec 29, 2017 at 12:36:37AM +0100, Thomas Gleixner wrote:
> > > On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:
> > > 
> > > > Attached, but heads up on this: when redirecting the output of lspci
> > > > -vvv to a text file as root I get
> > > > 
> > > > pcilib: sysfs_read_vpd: read failed: Input/output error
> > > > 
> > > > I can find bugs filed for various distros to this same effect, but
> > > > haven't tracked down any explanations.
> > > 
> > > Weird, but the info looks complete.
> > > 
> > > Can you please add 'pci=nomsi' to the 4.15 kernel command line and see
> > > whether that works?
> > 
> > It does (emailing from that successful boot as we speak). I'm on a
> > clean 4.15-rc5 (as in no patches, etc.). 
> > 
> > This was also suggested way at the top of this thread by Dexuan Cui
> > for 4.15-rc3 (where this exchange started), and it worked back then
> > too.
> 
> I missed that part of the conversation. Let me stare into the MSI code
> again.
> 
> Thanks,
> 
> 	tglx

--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bad-diff

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index aaf8d28..1e9bd28 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -101,12 +101,8 @@
 #define POSTED_INTR_NESTED_VECTOR	0xf0
 #endif
 
-/*
- * Local APIC timer IRQ vector is on a different priority level,
- * to work around the 'lost local interrupt if more than 2 IRQ
- * sources per level' errata.
- */
-#define LOCAL_TIMER_VECTOR		0xef
+#define MANAGED_IRQ_SHUTDOWN_VECTOR	0xef
+#define LOCAL_TIMER_VECTOR		0xee
 
 #define NR_VECTORS			 256
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index f08d44f..7317ba5a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -32,7 +32,8 @@ struct apic_chip_data {
 	unsigned int		prev_cpu;
 	unsigned int		irq;
 	struct hlist_node	clist;
-	u8			move_in_progress : 1;
+	unsigned int		move_in_progress	: 1,
+				is_managed		: 1;
 };
 
 struct irq_domain *x86_vector_domain;
@@ -152,6 +153,28 @@ static void apic_update_vector(struct irq_data *irqd, unsigned int newvec,
 	per_cpu(vector_irq, newcpu)[newvec] = desc;
 }
 
+static void vector_assign_managed_shutdown(struct irq_data *irqd)
+{
+	unsigned int cpu = cpumask_first(cpu_online_mask);
+
+	apic_update_irq_cfg(irqd, MANAGED_IRQ_SHUTDOWN_VECTOR, cpu);
+}
+
+static int reserve_managed_vector(struct irq_data *irqd)
+{
+	const struct cpumask *affmsk = irq_data_get_affinity_mask(irqd);
+	struct apic_chip_data *apicd = apic_chip_data(irqd);
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&vector_lock, flags);
+	apicd->is_managed = true;
+	ret = irq_matrix_reserve_managed(vector_matrix, affmsk);
+	raw_spin_unlock_irqrestore(&vector_lock, flags);
+	trace_vector_reserve_managed(irqd->irq, ret);
+	return ret;
+}
+
 static int allocate_vector(struct irq_data *irqd, const struct cpumask *dest)
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
@@ -211,9 +234,58 @@ static int assign_irq_vector_policy(struct irq_data *irqd,
 	return assign_irq_vector(irqd, cpu_online_mask);
 }
 
+
+static int assign_irq_vector_any_locked(struct irq_data *irqd)
+{
+  int node = irq_data_get_node(irqd);
+
+  if (node != NUMA_NO_NODE) {
+    if (!assign_vector_locked(irqd, cpumask_of_node(node)))
+      return 0;
+  }
+  return assign_vector_locked(irqd, cpu_online_mask);
+}
+
+static int assign_irq_vector_any(struct irq_data *irqd)
+{
+  unsigned long flags;
+  int ret;
+
+  raw_spin_lock_irqsave(&vector_lock, flags);
+  ret = assign_irq_vector_any_locked(irqd);
+  raw_spin_unlock_irqrestore(&vector_lock, flags);
+  return ret;
+}
+
+
+static int assign_managed_vector(struct irq_data *irqd, const struct cpumask *dest)
+{
+  const struct cpumask *affmsk = irq_data_get_affinity_mask(irqd);
+  struct apic_chip_data *apicd = apic_chip_data(irqd);
+  int vector, cpu;
+
+  cpumask_and(vector_searchmask, vector_searchmask, affmsk);
+  cpu = cpumask_first(vector_searchmask);
+  if (cpu >= nr_cpu_ids)
+    return -EINVAL;
+  /* set_affinity might call here for nothing */
+  if (apicd->vector && cpumask_test_cpu(apicd->cpu, vector_searchmask))
+    return 0;
+  vector = irq_matrix_alloc_managed(vector_matrix, cpu);
+  trace_vector_alloc_managed(irqd->irq, vector, vector);
+  if (vector < 0)
+    return vector;
+  apic_update_vector(irqd, vector, cpu);
+  apic_update_irq_cfg(irqd, vector, cpu);
+  return 0;
+}
+
+
+
 static void clear_irq_vector(struct irq_data *irqd)
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
+	bool managed = irqd_affinity_is_managed(irqd);
 	unsigned int vector = apicd->vector;
 
 	lockdep_assert_held(&vector_lock);
@@ -240,6 +312,80 @@ static void clear_irq_vector(struct irq_data *irqd)
 	hlist_del_init(&apicd->clist);
 }
 
+static void x86_vector_deactivate(struct irq_domain *dom, struct irq_data *irqd)
+{
+	struct apic_chip_data *apicd = apic_chip_data(irqd);
+	unsigned long flags;
+
+	trace_vector_deactivate(irqd->irq, apicd->is_managed,
+				false, false);
+
+	if (apicd->is_managed)
+		return;
+
+	raw_spin_lock_irqsave(&vector_lock, flags);
+	clear_irq_vector(irqd);
+	vector_assign_managed_shutdown(irqd);
+	raw_spin_unlock_irqrestore(&vector_lock, flags);
+}
+
+static int activate_managed(struct irq_data *irqd)
+{
+	const struct cpumask *dest = irq_data_get_affinity_mask(irqd);
+	int ret;
+
+	cpumask_and(vector_searchmask, dest, cpu_online_mask);
+	if (WARN_ON_ONCE(cpumask_empty(vector_searchmask))) {
+		/* Something in the core code broke! Survive gracefully */
+		pr_err("Managed startup for irq %u, but no CPU\n", irqd->irq);
+		return EINVAL;
+	}
+
+	ret = assign_managed_vector(irqd, vector_searchmask);
+	/*
+	 * This should not happen. The vector reservation got buggered.  Handle
+	 * it gracefully.
+	 */
+	if (WARN_ON_ONCE(ret < 0)) {
+		pr_err("Managed startup irq %u, no vector available\n",
+		       irqd->irq);
+	}
+       return ret;
+}
+
+static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
+			       bool early)
+{
+	struct apic_chip_data *apicd = apic_chip_data(irqd);
+	unsigned long flags;
+	int ret = 0;
+
+	trace_vector_activate(irqd->irq, apicd->is_managed,
+				false, early);
+
+	if (!apicd->is_managed)
+		return 0;
+
+	raw_spin_lock_irqsave(&vector_lock, flags);
+	if (early || irqd_is_managed_and_shutdown(irqd))
+		vector_assign_managed_shutdown(irqd);
+	else
+		ret = activate_managed(irqd);
+	raw_spin_unlock_irqrestore(&vector_lock, flags);
+	return ret;
+}
+
+static void vector_free_reserved_and_managed(struct irq_data *irqd)
+{
+	const struct cpumask *dest = irq_data_get_affinity_mask(irqd);
+	struct apic_chip_data *apicd = apic_chip_data(irqd);
+
+	trace_vector_teardown(irqd->irq, apicd->is_managed, false);
+
+	if (apicd->is_managed)
+		irq_matrix_remove_managed(vector_matrix, dest);
+}
+
 static void x86_vector_free_irqs(struct irq_domain *domain,
 				 unsigned int virq, unsigned int nr_irqs)
 {
@@ -368,6 +514,8 @@ void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
 static const struct irq_domain_ops x86_vector_domain_ops = {
 	.alloc		= x86_vector_alloc_irqs,
 	.free		= x86_vector_free_irqs,
+	.activate	= x86_vector_activate,
+	.deactivate	= x86_vector_deactivate,
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 	.debug_show	= x86_vector_debug_show,
 #endif
@@ -577,6 +725,15 @@ static void free_moved_vector(struct apic_chip_data *apicd)
 {
 	unsigned int vector = apicd->prev_vector;
 	unsigned int cpu = apicd->prev_cpu;
+	bool managed = apicd->is_managed;
+
+	/*
+	 * This should never happen. Managed interrupts are not
+	 * migrated except on CPU down, which does not involve the
+	 * cleanup vector. But try to keep the accounting correct
+	 * nevertheless.
+	 */
+	WARN_ON_ONCE(managed);
 
 	trace_vector_free_moved(apicd->irq, vector, false);
 	irq_matrix_free(vector_matrix, cpu, vector, false);

--zaRBsRFn0XYhEU69--
