Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Daniel J Blueman <daniel@numascale.com>
Subject: [Patch v2] x86, irq: Support CPU vector allocation policies
Date: Wed,  6 May 2015 16:36:00 +0800
Message-Id: <1430901368-20686-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <alpine.DEB.2.11.1505052116210.4225@nanos>
References: <alpine.DEB.2.11.1505052116210.4225@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On NUMA systems, an IO device may be associated with a NUMA node.
It may improve IO performance to allocate resources, such as memory
and interrupts, from device local node.

This patch introduces a mechanism to support CPU vector allocation
policies. It tries to allocate CPU vectors from CPUs on device local
node first, and then fallback to all online(global) CPUs.

This mechanism may be used to support NumaConnect systems to allocate
CPU vectors from device local node.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Daniel J Blueman <daniel@numascale.com>
---
Hi Thomas,
	This is the simplified version, which removed the kernel parameter.
Seems much simpler:)

Thanks!
Gerry
---
 arch/x86/kernel/apic/vector.c |   66 +++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 1c7dd42b98c1..44363ccce9b5 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -28,6 +28,17 @@ struct apic_chip_data {
 	u8			move_in_progress : 1;
 };
 
+enum {
+	/* Allocate CPU vectors from CPUs on device local node */
+	X86_VECTOR_POL_NODE = 0x1,
+	/* Allocate CPU vectors from all online CPUs */
+	X86_VECTOR_POL_GLOBAL = 0x2,
+	/* Allocate CPU vectors from caller specified CPUs */
+	X86_VECTOR_POL_CALLER = 0x4,
+	X86_VECTOR_POL_MIN = X86_VECTOR_POL_NODE,
+	X86_VECTOR_POL_MAX = X86_VECTOR_POL_CALLER,
+};
+
 struct irq_domain *x86_vector_domain;
 static DEFINE_RAW_SPINLOCK(vector_lock);
 static cpumask_var_t vector_cpumask;
@@ -258,12 +269,6 @@ void copy_irq_alloc_info(struct irq_alloc_info *dst, struct irq_alloc_info *src)
 		memset(dst, 0, sizeof(*dst));
 }
 
-static inline const struct cpumask *
-irq_alloc_info_get_mask(struct irq_alloc_info *info)
-{
-	return (!info || !info->mask) ? apic->target_cpus() : info->mask;
-}
-
 static void x86_vector_free_irqs(struct irq_domain *domain,
 				 unsigned int virq, unsigned int nr_irqs)
 {
@@ -284,12 +289,55 @@ static void x86_vector_free_irqs(struct irq_domain *domain,
 	}
 }
 
+static int assign_irq_vector_policy(int irq, int node,
+				    struct apic_chip_data *data,
+				    struct irq_alloc_info *info)
+{
+	int err = -EBUSY;
+	unsigned int policy;
+	const struct cpumask *mask;
+
+	if (info && info->mask)
+		policy = X86_VECTOR_POL_CALLER;
+	else
+		policy = X86_VECTOR_POL_MIN;
+
+	for (; policy <= X86_VECTOR_POL_MAX; policy <<= 1) {
+		switch (policy) {
+		case X86_VECTOR_POL_NODE:
+			if (node >= 0)
+				mask = cpumask_of_node(node);
+			else
+				mask = NULL;
+			break;
+		case X86_VECTOR_POL_GLOBAL:
+			mask = apic->target_cpus();
+			break;
+		case X86_VECTOR_POL_CALLER:
+			if (info && info->mask)
+				mask = info->mask;
+			else
+				mask = NULL;
+			break;
+		default:
+			mask = NULL;
+			break;
+		}
+		if (mask) {
+			err = assign_irq_vector(irq, data, mask);
+			if (!err)
+				return 0;
+		}
+	}
+
+	return err;
+}
+
 static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 				 unsigned int nr_irqs, void *arg)
 {
 	struct irq_alloc_info *info = arg;
 	struct apic_chip_data *data;
-	const struct cpumask *mask;
 	struct irq_data *irq_data;
 	int i, err;
 
@@ -300,7 +348,6 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
 		return -ENOSYS;
 
-	mask = irq_alloc_info_get_mask(info);
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
 		BUG_ON(!irq_data);
@@ -318,7 +365,8 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irq_data->chip = &lapic_controller;
 		irq_data->chip_data = data;
 		irq_data->hwirq = virq + i;
-		err = assign_irq_vector(virq, data, mask);
+		err = assign_irq_vector_policy(virq, irq_data->node, data,
+					       info);
 		if (err)
 			goto error;
 	}
-- 
1.7.10.4

