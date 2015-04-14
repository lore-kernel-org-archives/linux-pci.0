Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dimitri Sivanich <sivanich@sgi.com>, x86@kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [Patch Part2 v5 13/33] x86/irq: Kill irq_cfg.irq_remapped
Date: Tue, 14 Apr 2015 10:29:50 +0800
Message-Id: <1428978610-28986-14-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1428978610-28986-1-git-send-email-jiang.liu@linux.intel.com>
References: <1428978610-28986-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now there is no user of irq_cfg.irq_remapped, so kill it.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: iommu@lists.linux-foundation.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>
Link: http://lkml.kernel.org/r/1416901802-24211-23-git-send-email-jiang.liu@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/hw_irq.h       |    1 -
 drivers/iommu/amd_iommu.c           |    1 -
 drivers/iommu/intel_irq_remapping.c |    2 --
 3 files changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index bbf90fe2a224..88632ea75fe0 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -193,7 +193,6 @@ struct irq_cfg {
 	u8			vector;
 	u8			move_in_progress : 1;
 #ifdef CONFIG_IRQ_REMAP
-	u8			remapped : 1;
 	union {
 		struct irq_2_iommu irq_2_iommu;
 		struct irq_2_irte  irq_2_irte;
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 20abdbaf80d9..fa26c742bc39 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4131,7 +4131,6 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 	struct msi_msg *msg = &data->msi_entry;
 	struct IO_APIC_route_entry *entry;
 
-	irq_cfg->remapped = 1;
 	data->irq_2_irte.devid = devid;
 	data->irq_2_irte.index = index + sub_handle;
 
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index e76e5723ae87..21fc899e7c49 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -67,7 +67,6 @@ static int alloc_irte(struct intel_iommu *iommu, int irq,
 		      struct irq_2_iommu *irq_iommu, u16 count)
 {
 	struct ir_table *table = iommu->ir_table;
-	struct irq_cfg *cfg = irq_cfg(irq);
 	unsigned int mask = 0;
 	unsigned long flags;
 	int index;
@@ -94,7 +93,6 @@ static int alloc_irte(struct intel_iommu *iommu, int irq,
 	if (index < 0) {
 		pr_warn("IR%d: can't allocate an IRTE\n", iommu->seq_id);
 	} else {
-		cfg->remapped = 1;
 		irq_iommu->iommu = iommu;
 		irq_iommu->irte_index =  index;
 		irq_iommu->sub_handle = 0;
-- 
1.7.10.4

