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
Subject: [Patch v3 18/36] blackfin, irq: Use access helper irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:27 +0800
Message-Id: <1433145945-789-19-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/blackfin/mach-common/ints-priority.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/blackfin/mach-common/ints-priority.c b/arch/blackfin/mach-common/ints-priority.c
index 7236bdfc71e6..332a434b4669 100644
--- a/arch/blackfin/mach-common/ints-priority.c
+++ b/arch/blackfin/mach-common/ints-priority.c
@@ -194,7 +194,8 @@ void bfin_internal_unmask_irq(unsigned int irq)
 #ifdef CONFIG_SMP
 static void bfin_internal_unmask_irq_chip(struct irq_data *d)
 {
-	bfin_internal_unmask_irq_affinity(d->irq, d->affinity);
+	bfin_internal_unmask_irq_affinity(d->irq,
+					  irq_data_get_affinity_mask(d));
 }
 
 static int bfin_internal_set_affinity(struct irq_data *d,
-- 
1.7.10.4

