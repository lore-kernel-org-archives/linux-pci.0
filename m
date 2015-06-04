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
	Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFT v2 28/48] unicore32, irq: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:38 +0800
Message-Id: <1433391238-19471-29-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change irq flow handler to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/unicore32/kernel/irq.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/kernel/irq.c b/arch/unicore32/kernel/irq.c
index 0be5ccd7ccd2..56fdd4dd2740 100644
--- a/arch/unicore32/kernel/irq.c
+++ b/arch/unicore32/kernel/irq.c
@@ -113,19 +113,20 @@ static struct irq_chip puv3_low_gpio_chip = {
  * and call the handler.
  */
 static void
-puv3_gpio_handler(unsigned int irq, struct irq_desc *desc)
+puv3_gpio_handler(unsigned int __irq, struct irq_desc *desc)
 {
 	unsigned int mask;
 
 	mask = readl(GPIO_GEDR);
 	do {
+		unsigned int irq = IRQ_GPIO0;
+
 		/*
 		 * clear down all currently active IRQ sources.
 		 * We will be processing them all.
 		 */
 		writel(mask, GPIO_GEDR);
 
-		irq = IRQ_GPIO0;
 		do {
 			if (mask & 1)
 				generic_handle_irq(irq);
-- 
1.7.10.4

