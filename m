Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dimitri Sivanich <sivanich@sgi.com>,
	Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Daniel J Blueman <daniel@numascale.com>,
	linux-doc@vger.kernel.org
Subject: [Patch 2/2] x86, irq: Support CPU vector allocation policies
Date: Mon,  4 May 2015 10:47:41 +0800
Message-Id: <1430707662-28598-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1430707662-28598-1-git-send-email-jiang.liu@linux.intel.com>
References: <1430707662-28598-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On NUMA systems, an IO device may be associated with a NUMA node.
It may improve IO performance to allocate resources, such as memory
and interrupts, from device local node.

This patch introduces a mechanism to support CPU vector allocation
policies, so users may choose the best suitable CPU vector allocation
policy. Currently there are two supported allocation policies:
1) allocate CPU vectors from CPUs on device local node
2) allocate CPU vectors from all online CPUs

This mechanism may be used to support NumaConnect systems to allocate
CPU vectors from device local node.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Daniel J Blueman <daniel@numascale.com>
---
 Documentation/kernel-parameters.txt |    5 +++
 arch/x86/kernel/apic/vector.c       |   83 +++++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 274252f205b7..5e8b1c6f0677 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3840,6 +3840,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	vector=		[IA-64,SMP]
 			vector=percpu: enable percpu vector domain
 
+	vector_alloc=	[x86,SMP]
+			vector_alloc=node: try to allocate CPU vectors from CPUs on
+			device local node first, fallback to all online CPUs
+			vector_alloc=global: allocate CPU vector from all online CPUs
+
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.txt.
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 1c7dd42b98c1..96ce5068a926 100644
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
@@ -35,6 +46,9 @@ static struct irq_chip lapic_controller;
 #ifdef	CONFIG_X86_IO_APIC
 static struct apic_chip_data *legacy_irq_data[NR_IRQS_LEGACY];
 #endif
+static unsigned int vector_alloc_policy = X86_VECTOR_POL_NODE |
+					  X86_VECTOR_POL_GLOBAL |
+					  X86_VECTOR_POL_CALLER;
 
 void lock_vector_lock(void)
 {
@@ -258,12 +272,6 @@ void copy_irq_alloc_info(struct irq_alloc_info *dst, struct irq_alloc_info *src)
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
@@ -284,12 +292,58 @@ static void x86_vector_free_irqs(struct irq_domain *domain,
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
+		if (!(vector_alloc_policy & policy))
+			continue;
+
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
 
@@ -300,7 +354,6 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
 		return -ENOSYS;
 
-	mask = irq_alloc_info_get_mask(info);
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
 		BUG_ON(!irq_data);
@@ -318,7 +371,8 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irq_data->chip = &lapic_controller;
 		irq_data->chip_data = data;
 		irq_data->hwirq = virq + i;
-		err = assign_irq_vector(virq, data, mask);
+		err = assign_irq_vector_policy(virq, irq_data->node, data,
+					       info);
 		if (err)
 			goto error;
 	}
@@ -809,6 +863,17 @@ static __init int setup_show_lapic(char *arg)
 }
 __setup("show_lapic=", setup_show_lapic);
 
+static int __init apic_parse_vector_policy(char *str)
+{
+	if (!strncmp(str, "node", 4))
+		vector_alloc_policy |= X86_VECTOR_POL_NODE;
+	else if (!strncmp(str, "global", 6))
+		vector_alloc_policy &= ~X86_VECTOR_POL_NODE;
+
+	return 1;
+}
+__setup("vector_alloc=", apic_parse_vector_policy);
+
 static int __init print_ICs(void)
 {
 	if (apic_verbosity == APIC_QUIET)
-- 
1.7.10.4

