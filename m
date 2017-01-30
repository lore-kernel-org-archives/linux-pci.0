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
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org> <1485188293-20263-11-git-send-email-sricharan@codeaurora.org> <20170128210709.GG20550@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170128210709.GG20550@bhelgaas-glaptop.roam.corp.google.com>
Subject: RE: [PATCH V7 10/11] iommu/arm-smmu: Clean up early-probing workarounds
Date: Mon, 30 Jan 2017 13:35:12 +0530
Message-ID: <005401d27acf$991e6290$cb5b27b0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

>> Now that the appropriate ordering is enforced via profe-deferral of
>
>s/profe-deferral/probe-deferral/
>

ha, will change it.

Regards,
 Sricharan


>> masters in core code, rip it all out and bask in the simplicity.
>>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> [Sricharan: Rebased on top of ACPI IORT SMMU series]
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 46 ++---------------------------------
>>  drivers/iommu/arm-smmu.c    | 58 +++++++--------------------------------------
>>  2 files changed, 10 insertions(+), 94 deletions(-)
>
>Yay!
