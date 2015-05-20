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
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [Patch v2 03/14] x86, irq: Use accessor irq_data_get_node() to hide struct irq_data detail
Date: Wed, 20 May 2015 17:40:34 +0800
Message-Id: <1432114845-24304-4-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use accessor irq_data_get_node() to hide struct irq_data implementation
detail, so we could easily reconstruct struct irq_data later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/apic/vector.c |    8 ++++----
 arch/x86/platform/uv/uv_irq.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 28eba2d38b15..9b62f690b0ff 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -296,7 +296,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	struct irq_alloc_info *info = arg;
 	struct apic_chip_data *data;
 	struct irq_data *irq_data;
-	int i, err;
+	int i, err, node;
 
 	if (disable_apic)
 		return -ENXIO;
@@ -308,12 +308,13 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
 		BUG_ON(!irq_data);
+		node = irq_data_get_node(irq_data);
 #ifdef	CONFIG_X86_IO_APIC
 		if (virq + i < nr_legacy_irqs() && legacy_irq_data[virq + i])
 			data = legacy_irq_data[virq + i];
 		else
 #endif
-			data = alloc_apic_chip_data(irq_data->node);
+			data = alloc_apic_chip_data(node);
 		if (!data) {
 			err = -ENOMEM;
 			goto error;
@@ -322,8 +323,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irq_data->chip = &lapic_controller;
 		irq_data->chip_data = data;
 		irq_data->hwirq = virq + i;
-		err = assign_irq_vector_policy(virq, irq_data->node, data,
-					       info);
+		err = assign_irq_vector_policy(virq, node, data, info);
 		if (err)
 			goto error;
 	}
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 8570abe68be1..e1c24631afbb 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -89,7 +89,7 @@ static int uv_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -EINVAL;
 
 	chip_data = kmalloc_node(sizeof(*chip_data), GFP_KERNEL,
-				 irq_data->node);
+				 irq_data_get_node(irq_data));
 	if (!chip_data)
 		return -ENOMEM;
 
-- 
1.7.10.4

