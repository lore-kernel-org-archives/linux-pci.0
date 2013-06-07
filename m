Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Donald Dutile <ddutile@redhat.com>
Subject: [PATCH v3 07/27] iommu, irq: Allocate irq_desc for dmar_msi with local node
Date: Fri,  7 Jun 2013 15:30:53 -0700
Message-Id: <1370644273-10495-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1370644273-10495-1-git-send-email-yinghai@kernel.org>
References: <1370644273-10495-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

iommu irq's irq_desc should be on local node ram.

Fix the return value checking problem.

create_irq() will return -1 when fail to allocate.
create_irq_nr() will return 0 when fail to allocate.

here only check !irq, so need to change it to use create_irq_nr instead.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Donald Dutile <ddutile@redhat.com>
Acked-by: Donald Dutile <ddutile@redhat.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index a7967ce..c09e60d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1273,7 +1273,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 	if (iommu->irq)
 		return 0;
 
-	irq = create_irq();
+	irq = create_irq_nr(0, iommu->node);
 	if (!irq) {
 		pr_err("IOMMU: no free vectors\n");
 		return -EINVAL;
-- 
1.8.1.4

