Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21782 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbaACAHO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2014 19:07:14 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Donald Dutile <ddutile@redhat.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	stable@vger.kernel.org
Subject: [PATCH v5 10/33] iommu, irq: Allocate irq_desc for dmar_msi with local node
Date: Thu,  2 Jan 2014 16:05:42 -0800
Message-Id: <1388707565-16535-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
References: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

iommu irq's irq_desc should be on local node ram.

Fix the return value checking problem.
  create_irq() will return -1 when fail to allocate.
  create_irq_nr() will return 0 when fail to allocate.
here only check !irq, so need to change it to use create_irq_nr instead.

-v2: According to Sebastian, add cc to stable.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Donald Dutile <ddutile@redhat.com>
Acked-by: Donald Dutile <ddutile@redhat.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: stable@vger.kernel.org
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8b452c9..f4eaa50 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1277,7 +1277,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 	if (iommu->irq)
 		return 0;
 
-	irq = create_irq();
+	irq = create_irq_nr(0, iommu->node);
 	if (!irq) {
 		pr_err("IOMMU: no free vectors\n");
 		return -EINVAL;
-- 
1.8.4

