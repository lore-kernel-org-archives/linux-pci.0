Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Sricharan" <sricharan@codeaurora.org>
To: "'Sinan Kaya'" <okaya@codeaurora.org>, <robin.murphy@arm.com>,
 <will.deacon@arm.com>, <joro@8bytes.org>, <lorenzo.pieralisi@arm.com>,
 <iommu@lists.linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-arm-msm@vger.kernel.org>, <m.szyprowski@samsung.com>,
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-8-git-send-email-sricharan@codeaurora.org>
 <34a703f0-3b37-88f0-46fa-b56ab6717a42@codeaurora.org>
In-Reply-To: <34a703f0-3b37-88f0-46fa-b56ab6717a42@codeaurora.org>
Subject: RE: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
Date: Mon, 30 Jan 2017 17:30:58 +0530
Message-ID: <008f01d27af0$88e897d0$9ab9c770$@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Sinan Kaya
>Sent: Sunday, January 29, 2017 10:06 PM
>To: Sricharan R <sricharan@codeaurora.org>; robin.murphy@arm.com; will.deacon@arm.com; joro@8bytes.org;
>lorenzo.pieralisi@arm.com; iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org; linux-arm-
>msm@vger.kernel.org; m.szyprowski@samsung.com; bhelgaas@google.com; linux-pci@vger.kernel.org; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with deferred probing or error
>
>On 1/23/2017 11:18 AM, Sricharan R wrote:
>> @@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>>  	if (ret < 0) {
>>  		dma_addr = offset = 0;
>> -		size = dev->coherent_dma_mask + 1;
>> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>>  	} else {
>
>what's happening here?

Sorry, not relevant. Will remove this. Has come in because of some rebase mistake.

Regards,
 Sricharan


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
