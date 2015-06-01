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
	Jason Cooper <jason@lakedaemon.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v3 29/36] irqchip, irq: Use access helper irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:38 +0800
Message-Id: <1433145945-789-30-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/irqchip/irq-mips-gic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 57f09cb54464..09257c301bd2 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -403,7 +403,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		clear_bit(irq, pcpu_masks[i].pcpu_mask);
 	set_bit(irq, pcpu_masks[cpumask_first(&tmp)].pcpu_mask);
 
-	cpumask_copy(d->affinity, cpumask);
+	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return IRQ_SET_MASK_OK_NOCOPY;
-- 
1.7.10.4

