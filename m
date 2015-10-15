Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Ma Jun <majun258@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 3/7] irqdomain: Make irq_domain_alloc_irqs_recursive available
Date: Thu, 15 Oct 2015 16:39:24 +0100
Message-Id: <1444923568-17413-4-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are soon going to need the MSI layer to call into the domain
allocators. Instead of open coding this, make the standard
irq_domain_alloc_irqs_recursive function available to the MSI
layer.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h | 3 +++
 kernel/irq/irqdomain.c    | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d5e5c5b..cf96c6a 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -367,6 +367,9 @@ static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false);
 }
 
+extern int irq_domain_alloc_irqs_recursive(struct irq_domain *domain,
+					   unsigned int irq_base,
+					   unsigned int nr_irqs, void *arg);
 extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 unsigned int virq,
 					 irq_hw_number_t hwirq,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 22aa961..1c9973e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1125,9 +1125,9 @@ static void irq_domain_free_irqs_recursive(struct irq_domain *domain,
 	}
 }
 
-static int irq_domain_alloc_irqs_recursive(struct irq_domain *domain,
-					   unsigned int irq_base,
-					   unsigned int nr_irqs, void *arg)
+int irq_domain_alloc_irqs_recursive(struct irq_domain *domain,
+				    unsigned int irq_base,
+				    unsigned int nr_irqs, void *arg)
 {
 	int ret = 0;
 	struct irq_domain *parent = domain->parent;
-- 
2.1.4

