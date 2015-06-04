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
	Steven Miao <realmz6@gmail.com>,
	Christoph Lameter <cl@linux.com>,
	Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	adi-buildroot-devel@lists.sourceforge.net
Subject: [RFT v2 37/48] genirq, blackfin: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:47 +0800
Message-Id: <1433391238-19471-38-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/blackfin/include/asm/irq_handler.h   |    4 ++--
 arch/blackfin/kernel/ipipe.c              |    2 +-
 arch/blackfin/mach-bf537/ints-priority.c  |    8 +++-----
 arch/blackfin/mach-common/ints-priority.c |    6 ++----
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/blackfin/include/asm/irq_handler.h b/arch/blackfin/include/asm/irq_handler.h
index 4b2a992794d7..d2f90c72378e 100644
--- a/arch/blackfin/include/asm/irq_handler.h
+++ b/arch/blackfin/include/asm/irq_handler.h
@@ -60,7 +60,7 @@ extern void bfin_internal_mask_irq(unsigned int irq);
 extern void bfin_internal_unmask_irq(unsigned int irq);
 
 struct irq_desc;
-extern void bfin_demux_mac_status_irq(unsigned int, struct irq_desc *);
-extern void bfin_demux_gpio_irq(unsigned int, struct irq_desc *);
+extern void bfin_demux_mac_status_irq(struct irq_desc *);
+extern void bfin_demux_gpio_irq(struct irq_desc *);
 
 #endif
diff --git a/arch/blackfin/kernel/ipipe.c b/arch/blackfin/kernel/ipipe.c
index 6007a1375c5b..8daca4d56992 100644
--- a/arch/blackfin/kernel/ipipe.c
+++ b/arch/blackfin/kernel/ipipe.c
@@ -54,7 +54,7 @@ atomic_t __ipipe_irq_lvdepth[IVG15 + 1];
 unsigned long __ipipe_irq_lvmask = bfin_no_irqs;
 EXPORT_SYMBOL(__ipipe_irq_lvmask);
 
-static void __ipipe_ack_irq(unsigned irq, struct irq_desc *desc)
+static void __ipipe_ack_irq(struct irq_desc *desc)
 {
 	desc->ipipe_ack(irq_desc_get_irq(desc), desc);
 }
diff --git a/arch/blackfin/mach-bf537/ints-priority.c b/arch/blackfin/mach-bf537/ints-priority.c
index 2137a209a22b..a48baae4384d 100644
--- a/arch/blackfin/mach-bf537/ints-priority.c
+++ b/arch/blackfin/mach-bf537/ints-priority.c
@@ -89,8 +89,7 @@ static struct irq_chip bf537_generic_error_irqchip = {
 	.irq_unmask = bf537_generic_error_unmask_irq,
 };
 
-static void bf537_demux_error_irq(unsigned int int_err_irq,
-				  struct irq_desc *inta_desc)
+static void bf537_demux_error_irq(struct irq_desc *inta_desc)
 {
 	int irq = 0;
 
@@ -182,13 +181,12 @@ static struct irq_chip bf537_mac_rx_irqchip = {
 	.irq_unmask = bf537_mac_rx_unmask_irq,
 };
 
-static void bf537_demux_mac_rx_irq(unsigned int int_irq,
-				   struct irq_desc *desc)
+static void bf537_demux_mac_rx_irq(struct irq_desc *desc)
 {
 	if (bfin_read_DMA1_IRQ_STATUS() & (DMA_DONE | DMA_ERR))
 		bfin_handle_irq(IRQ_MAC_RX);
 	else
-		bfin_demux_gpio_irq(int_irq, desc);
+		bfin_demux_gpio_irq(desc);
 }
 #endif
 
diff --git a/arch/blackfin/mach-common/ints-priority.c b/arch/blackfin/mach-common/ints-priority.c
index 4e3155e5aa20..e7d6d65e0946 100644
--- a/arch/blackfin/mach-common/ints-priority.c
+++ b/arch/blackfin/mach-common/ints-priority.c
@@ -656,8 +656,7 @@ static struct irq_chip bfin_mac_status_irqchip = {
 	.irq_set_wake = bfin_mac_status_set_wake,
 };
 
-void bfin_demux_mac_status_irq(unsigned int int_err_irq,
-			       struct irq_desc *inta_desc)
+void bfin_demux_mac_status_irq(struct irq_desc *inta_desc)
 {
 	int i, irq = 0;
 	u32 status = bfin_read_EMAC_SYSTAT();
@@ -825,8 +824,7 @@ static void bfin_demux_gpio_block(unsigned int irq)
 	}
 }
 
-void bfin_demux_gpio_irq(unsigned int inta_irq,
-			struct irq_desc *desc)
+void bfin_demux_gpio_irq(struct irq_desc *desc)
 {
 	unsigned int irq;
 
-- 
1.7.10.4

