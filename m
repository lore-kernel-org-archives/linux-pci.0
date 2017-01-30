Return-Path: <SRS0=Orsw=ZM=codeaurora.org=sricharan@kernel.org>
Return-Path: <SRS0=Orsw=ZM=codeaurora.org=sricharan@kernel.org>
From: "Sricharan" <sricharan@codeaurora.org>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: <robin.murphy@arm.com>,
	<will.deacon@arm.com>,
	<joro@8bytes.org>,
	<lorenzo.pieralisi@arm.com>,
	<iommu@lists.linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>,
	<m.szyprowski@samsung.com>,
	<bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org> <1485188293-20263-10-git-send-email-sricharan@codeaurora.org> <20170128210611.GF20550@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170128210611.GF20550@bhelgaas-glaptop.roam.corp.google.com>
Subject: RE: [PATCH V7 09/11] arm64: dma-mapping: Remove the notifier trick to handle early setting of dma_ops
Date: Mon, 30 Jan 2017 13:34:18 +0530
Message-ID: <005201d27acf$7924a7b0$6b6df710$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

>> With arch_setup_dma_ops now being called late during device's probe after
>> the device's iommu is probed, the notifier trick required to handle the
>> early setup of dma_ops before the iommu group gets created is not
>> required. So removing the notifier's here.
>
>s/notifier's/notifiers/
>
ok, will change.

>Personally I'd capitalize "IOMMU" in the English text above, too.
>
ok, will change this too.

Regards,
 Sricharan

>> Acked-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> [rm: clean up even more]
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  arch/arm64/mm/dma-mapping.c | 132 ++++----------------------------------------
>>  1 file changed, 12 insertions(+), 120 deletions(-)
>
>Nice :)
