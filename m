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
	Marc Zyngier <marc.zyngier@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v3 36/36] genirq: Optimize irq_data_to_desc() to avoid irq_to_desc() lookup
Date: Mon,  1 Jun 2015 16:05:45 +0800
Message-Id: <1433145945-789-37-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Optimize irq_data_to_desc() to avoid irq_to_desc() lookup.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irqdesc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 4dfa46b99a14..749755bffbc1 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -97,7 +97,7 @@ extern struct irq_desc irq_desc[NR_IRQS];
 static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
 {
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-	return irq_to_desc(data->irq);
+	return container_of(data->common, struct irq_desc, irq_common_data);
 #else
 	return container_of(data, struct irq_desc, irq_data);
 #endif
-- 
1.7.10.4

