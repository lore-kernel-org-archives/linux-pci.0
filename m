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
	Dimitri Sivanich <sivanich@sgi.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [Patch 1/2] irq_remapping/vt-d: Fix regression caused by commit b106ee63abcc
Date: Mon,  4 May 2015 10:47:40 +0800
Message-Id: <1430707662-28598-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1430707662-28598-1-git-send-email-jiang.liu@linux.intel.com>
References: <1430707662-28598-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit b106ee63abcc ("irq_remapping/vt-d: Enhance Intel IR driver to
support hierarchical irqdomains") caused a regression, which forgot
to initialize remapping data structures other than the first entry
when setting up remapping entries for multiple MSIs.

Code is written by Thomas and commit message is written by Jiang.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
Hi Thomas,
	I missed this patch when rebasing my patch set. It may be
fold into commit b106ee63abcc ("irq_remapping/vt-d: Enhance Intel IR
driver to support hierarchical irqdomains").
Thanks!
Gerry
---
 drivers/iommu/intel_irq_remapping.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 14d95694fc1b..7ecc6b3180ba 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1113,7 +1113,7 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 {
 	struct intel_iommu *iommu = domain->host_data;
 	struct irq_alloc_info *info = arg;
-	struct intel_ir_data *data;
+	struct intel_ir_data *data, *ird;
 	struct irq_data *irq_data;
 	struct irq_cfg *irq_cfg;
 	int i, ret, index;
@@ -1158,14 +1158,20 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 		}
 
 		if (i > 0) {
-			data = kzalloc(sizeof(*data), GFP_KERNEL);
-			if (!data)
+			ird = kzalloc(sizeof(*ird), GFP_KERNEL);
+			if (!ird)
 				goto out_free_data;
+			/* Initialize the common data */
+			ird->irq_2_iommu = data->irq_2_iommu;
+			ird->irq_2_iommu.sub_handle = i;
+		} else {
+			ird = data;
 		}
+
 		irq_data->hwirq = (index << 16) + i;
-		irq_data->chip_data = data;
+		irq_data->chip_data = ird;
 		irq_data->chip = &intel_ir_chip;
-		intel_irq_remapping_prepare_irte(data, irq_cfg, info, index, i);
+		intel_irq_remapping_prepare_irte(ird, irq_cfg, info, index, i);
 		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
 	return 0;
-- 
1.7.10.4

