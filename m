Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27193 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775AbbDNCay (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Apr 2015 22:30:54 -0400
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
Subject: [Patch Part2 v5 15/33] irq_remapping/amd: Move struct irq_2_irte into amd_iommu.c
Date: Tue, 14 Apr 2015 10:29:52 +0800
Message-Id: <1428978610-28986-16-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1428978610-28986-1-git-send-email-jiang.liu@linux.intel.com>
References: <1428978610-28986-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now only amd_iommu.c access irq_2_irte, so move it from hw_irq.h into
amd_iommu.c.

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
Link: http://lkml.kernel.org/r/1416901802-24211-25-git-send-email-jiang.liu@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/hw_irq.h |   13 -------------
 drivers/iommu/amd_iommu.c     |    5 +++++
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 3520f71f168b..494d541d2aee 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -94,14 +94,6 @@ extern void trace_call_function_single_interrupt(void);
 #define trace_kvm_posted_intr_ipi kvm_posted_intr_ipi
 #endif /* CONFIG_TRACING */
 
-#ifdef CONFIG_IRQ_REMAP
-/* AMD specific interrupt remapping information */
-struct irq_2_irte {
-	u16 devid; /* Device ID for IRTE table */
-	u16 index; /* Index into IRTE table*/
-};
-#endif	/* CONFIG_IRQ_REMAP */
-
 struct irq_domain;
 
 #ifdef	CONFIG_X86_LOCAL_APIC
@@ -184,11 +176,6 @@ struct irq_cfg {
 	unsigned int		dest_apicid;
 	u8			vector;
 	u8			move_in_progress : 1;
-#ifdef CONFIG_IRQ_REMAP
-	union {
-		struct irq_2_irte  irq_2_irte;
-	};
-#endif
 	union {
 #ifdef CONFIG_X86_IO_APIC
 		struct {
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fa26c742bc39..a5a17f50691c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3858,6 +3858,11 @@ union irte {
 	} fields;
 };
 
+struct irq_2_irte {
+	u16 devid; /* Device ID for IRTE table */
+	u16 index; /* Index into IRTE table*/
+};
+
 struct amd_ir_data {
 	struct irq_2_irte			irq_2_irte;
 	union irte				irte_entry;
-- 
1.7.10.4

