Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFT v2 02/48] genirq: Kill never used irq_node()
Date: Thu,  4 Jun 2015 12:13:12 +0800
Message-Id: <1433391238-19471-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Macro irq_node() is never used, so kill it.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irqnr.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index fdd5cc16c9c4..9669bf9d4f48 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -23,12 +23,6 @@ unsigned int irq_get_next_irq(unsigned int offset);
 			;						\
 		else
 
-#ifdef CONFIG_SMP
-#define irq_node(irq)	(irq_get_irq_data(irq)->node)
-#else
-#define irq_node(irq)	0
-#endif
-
 # define for_each_active_irq(irq)			\
 	for (irq = irq_get_next_irq(0); irq < nr_irqs;	\
 	     irq = irq_get_next_irq(irq + 1))
-- 
1.7.10.4

