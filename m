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
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org> <1485188293-20263-8-git-send-email-sricharan@codeaurora.org> <20170128210359.GE20550@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170128210359.GE20550@bhelgaas-glaptop.roam.corp.google.com>
Subject: RE: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with deferred probing or error
Date: Mon, 30 Jan 2017 13:31:52 +0530
Message-ID: <005001d27acf$21c47db0$654d7910$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

>-----Original Message-----
>From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>Sent: Sunday, January 29, 2017 2:34 AM
>To: Sricharan R <sricharan@codeaurora.org>
>Cc: robin.murphy@arm.com; will.deacon@arm.com; joro@8bytes.org; lorenzo.pieralisi@arm.com; iommu@lists.linux-foundation.org;
>linux-arm-kernel@lists.infradead.org; linux-arm-msm@vger.kernel.org; m.szyprowski@samsung.com; bhelgaas@google.com; linux-
>pci@vger.kernel.org; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with deferred probing or error
>
>On Mon, Jan 23, 2017 at 09:48:09PM +0530, Sricharan R wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> Failures to look up an IOMMU when parsing the DT iommus property need to
>> be handled separately from the .of_xlate() failures to support deferred
>> probing.
>>
>> The lack of a registered IOMMU can be caused by the lack of a driver for
>> the IOMMU, the IOMMU device probe not having been performed yet, having
>> been deferred, or having failed.
>>
>> The first case occurs when the device tree describes the bus master and
>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>> or the device driver has not been compiled in. Return NULL, the caller
>> will configure the device without an IOMMU.
>>
>> The second and third cases are handled by deferring the probe of the bus
>> master device which will eventually get reprobed after the IOMMU.
>>
>> The last case is currently handled by deferring the probe of the bus
>> master device as well. A mechanism to either configure the bus master
>> device without an IOMMU or to fail the bus master device probe depending
>> on whether the IOMMU is optional or mandatory would be a good
>> enhancement.
>>
>> Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ...
>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 349bd1d..9529d6c 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_iommu.h>
>>  #include <linux/of_pci.h>
>> +#include <linux/pci.h>
>
>Why do we need this?

Right, will remove it.

Regards,
 Sricharan
