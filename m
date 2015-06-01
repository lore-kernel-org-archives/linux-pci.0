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
	linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [Patch v3 06/36] sh, irq: Use accessor irq_data_get_node() to hide struct irq_data detail
Date: Mon,  1 Jun 2015 16:05:15 +0800
Message-Id: <1433145945-789-7-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use accessor irq_data_get_node() to hide struct irq_data implementation
detail, so we could easily reconstruct struct irq_data later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sh/kernel/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index eb10ff84015c..8dc677cc136b 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -227,7 +227,7 @@ void migrate_irqs(void)
 	for_each_active_irq(irq) {
 		struct irq_data *data = irq_get_irq_data(irq);
 
-		if (data->node == cpu) {
+		if (irq_data_get_node(data) == cpu) {
 			unsigned int newcpu = cpumask_any_and(data->affinity,
 							      cpu_online_mask);
 			if (newcpu >= nr_cpu_ids) {
-- 
1.7.10.4

