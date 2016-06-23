Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53011 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbcFWLcS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jun 2016 07:32:18 -0400
Subject: Re: [RFC PATCH v2 03/15] arm64: mm: change IOMMU notifier action to
 attach DMA ops
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465306270-27076-4-git-send-email-lorenzo.pieralisi@arm.com>
 <5763C27A.9030306@arm.com> <20160617141536.GA24840@red-moon>
Cc: Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	Hanjun Guo <hanjun.guo@linaro.org>, linux-pci@vger.kernel.org,
	Tomasz Nowicki <tn@semihalf.com>,
	linux-arm-kernel@lists.infradead.org
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <576BC8BC.6090400@arm.com>
Date: Thu, 23 Jun 2016 12:32:12 +0100
MIME-Version: 1.0
In-Reply-To: <20160617141536.GA24840@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 17/06/16 15:15, Lorenzo Pieralisi wrote:
>> I think this patch makes sense even independent of the rest of the
>> series, one nit inline notwithstanding.
>
> Thanks. Yes I added it to this series since it is not strictly
> necessary (ie it does not fix anything) in the mainline, but
> it *is* necessary for this whole series to function when we
> boot through ACPI.
>
> I will send it out in a separate patch and fold changes you
> request below, it would be good to have some coverage for
> it before merging it.

Having considered it a bit more, triggering on BIND_DRIVER also means 
the silly "process the whole list every time" behaviour should go away. 
There's little point in trying to configure a device's ops before we 
know they're actually needed, and once a driver has bound it's too late 
to change anything anyway. What do you think of squashing in something 
like the below?

Robin.

----->8-----
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 7d3fa9ae8a11..02484dc3f369 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -854,10 +854,11 @@ static int __iommu_attach_notifier(struct 
notifier_block *nb,

  	mutex_lock(&iommu_dma_notifier_lock);
  	list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
-		if (do_iommu_attach(master->dev, master->ops,
-				master->dma_base, master->size)) {
+		if (data == master->dev && do_iommu_attach(master->dev,
+				master->ops, master->dma_base, master->size)) {
  			list_del(&master->list);
  			kfree(master);
+			break;
  		}
  	}
  	mutex_unlock(&iommu_dma_notifier_lock);

