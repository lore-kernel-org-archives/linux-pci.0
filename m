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
Subject: [RFT v2 22/48] blackfin, irq: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:32 +0800
Message-Id: <1433391238-19471-23-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change irq flow handler to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Seems ipipe.c is never used at all, and it may fail to compile if it's
used.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/blackfin/kernel/ipipe.c              |    2 +-
 arch/blackfin/mach-common/ints-priority.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/blackfin/kernel/ipipe.c b/arch/blackfin/kernel/ipipe.c
index f657b38163e3..6007a1375c5b 100644
--- a/arch/blackfin/kernel/ipipe.c
+++ b/arch/blackfin/kernel/ipipe.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL(__ipipe_irq_lvmask);
 
 static void __ipipe_ack_irq(unsigned irq, struct irq_desc *desc)
 {
-	desc->ipipe_ack(irq, desc);
+	desc->ipipe_ack(irq_desc_get_irq(desc), desc);
 }
 
 /*
diff --git a/arch/blackfin/mach-common/ints-priority.c b/arch/blackfin/mach-common/ints-priority.c
index 332a434b4669..4e3155e5aa20 100644
--- a/arch/blackfin/mach-common/ints-priority.c
+++ b/arch/blackfin/mach-common/ints-priority.c
@@ -830,7 +830,7 @@ void bfin_demux_gpio_irq(unsigned int inta_irq,
 {
 	unsigned int irq;
 
-	switch (inta_irq) {
+	switch (irq_desc_get_irq(desc)) {
 #if defined(BF537_FAMILY)
 	case IRQ_PF_INTA_PG_INTA:
 		bfin_demux_gpio_block(IRQ_PF0);
-- 
1.7.10.4

