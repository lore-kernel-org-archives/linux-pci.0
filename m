Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v3 14/36] genirq: Introduce helper function irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:23 +0800
Message-Id: <1433145945-789-15-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce helper function irq_data_get_affinity_mask() and
irq_get_affinity_mask() to hide implementation details,
so we could move field 'affinity' from struct irq_data into
struct irq_common_data later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/irq.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 68874efe19d3..91fbf10bdae0 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -656,6 +656,18 @@ static inline int irq_data_get_node(struct irq_data *d)
 	return irq_common_data_get_node(d->common);
 }
 
+static inline struct cpumask *irq_get_affinity_mask(int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	return d ? d->affinity : NULL;
+}
+
+static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
+{
+	return d->affinity;
+}
+
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-- 
1.7.10.4

