Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCHv5 1/6] msi: Relax msi_domain_alloc() to support parentless MSI irqdomains
Date: Fri, 13 Nov 2015 10:17:32 -0700
Message-Id: <1447435057-5212-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1447435057-5212-1-git-send-email-keith.busch@intel.com>
References: <1447435057-5212-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Liu Jiang <jiang.liu@linux.intel.com>

Previously msi_domain_alloc() assumes MSI irqdomains always have parent
irqdomains, but that's not true for the new Intel VMD devices. So relax
msi_domain_alloc() to support parentless MSI irqdomains.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Tested-by: Keith Busch <keith.busch@intel.com>
---
 kernel/irq/msi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 6b0c0b7..5e15cb4 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -109,9 +109,11 @@ static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (irq_find_mapping(domain, hwirq) > 0)
 		return -EEXIST;
 
-	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
-	if (ret < 0)
-		return ret;
+	if (domain->parent) {
+		ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+		if (ret < 0)
+			return ret;
+	}
 
 	for (i = 0; i < nr_irqs; i++) {
 		ret = ops->msi_init(domain, info, virq + i, hwirq + i, arg);
-- 
2.6.2.307.g37023ba

