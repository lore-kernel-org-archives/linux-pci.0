Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFC PATCH v2 03/15] arm64: mm: change IOMMU notifier action to
 attach DMA ops
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465306270-27076-4-git-send-email-lorenzo.pieralisi@arm.com>
 <5763C27A.9030306@arm.com> <03c537e7-0acf-edca-d0e0-369490c828df@samsung.com>
 <20160621160637.GA31761@red-moon>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <76c43b76-518c-a2d3-c200-d02aa9125e1d@samsung.com>
Date: Thu, 23 Jun 2016 08:13:30 +0200
MIME-version: 1.0
In-reply-to: <20160621160637.GA31761@red-moon>
Content-type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,


On 2016-06-21 18:06, Lorenzo Pieralisi wrote:
> Hi Marek,
>
> On Tue, Jun 21, 2016 at 09:53:20AM +0200, Marek Szyprowski wrote:
>> Hi Robin,
>>
>>
>> On 2016-06-17 11:27, Robin Murphy wrote:
>>> Hi Lorenzo,
>>>
>>> I think this patch makes sense even independent of the rest of the
>>> series, one nit inline notwithstanding.
>>>
>>> Marek; I'm curious as to whether this could make the workaround in
>>> 722ec35f7 obsolete as well, or are all the drivers also bound
>>> super-early in the setup you had there?
>> Yes, this will solve that problem too. I will also hide some possible
>> deferred probe issues, because the moment at which IOMMU is activated
>> will be postponed. The only drawback with this approach is the fact
>> that is drivers won't be allowed to do any dma-mapping operations on
>> devices, which they don't own. This should not be a big issue, but
>> this was the reason to setup IOMMU on device add instead of driver
>> bind.
>>
>> While at it, please make sure that the case of failed client driver
>> probe will be handled properly. IOMMU might do some operations while
>> setting up and if the client driver fails to probe (for whatever
>> reason, might be a deferred probe too), those operation has to be
>> undone. However the current code of the driver core won't call any
>> notifier (like BUS_NOTIFY_UNBOUND_DRIVER or whatever else) in such
>> case.
> Isn't Andy's commit 14b6257a5f3d enough ? Is that what you had in
> mind ?
>
>> Long time ago I used BUS_NOTIFY_BIND_DRIVER based approach for my
>> Exynos IOMMU patches and had to extend bus core with such patch:
>> https://patchwork.kernel.org/patch/4678181/ to properly cleanup
>> after failed client driver probe and avoid leaking resources. Please
>> read the discussion, because some changes were requested to it.
> It looks like commit 14b6257a5f3d ("device core: add
> BUS_NOTIFY_DRIVER_NOT_BOUND notification") does what you
> are requesting, please let me know if that's enough.

Yes, that's exactly the change I needed that time. Nice to see that it
finally landed in mainline.

> I will revert the changes in 722ec35f7 and fold them in the
> new version along with Robin's suggestions.

Okay.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

