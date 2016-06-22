Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35025 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbcFVCpj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2016 22:45:39 -0400
Received: by mail-pa0-f47.google.com with SMTP id hl6so11993120pac.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2016 19:45:17 -0700 (PDT)
Subject: Re: [RFC PATCH v2 00/15] ACPI IORT ARM SMMU v3 support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
 <b00f33ad-be24-21a9-b03b-611756bbc8e9@linaro.org>
 <20160621142704.GA31593@red-moon>
Cc: iommu@lists.linux-foundation.org,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <e9d5d68a-3e1d-4517-7f67-b7941e74eddd@linaro.org>
Date: Wed, 22 Jun 2016 10:45:05 +0800
MIME-Version: 1.0
In-Reply-To: <20160621142704.GA31593@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/6/21 22:27, Lorenzo Pieralisi wrote:
> Hi Hanjun,
>
> On Tue, Jun 21, 2016 at 06:37:17PM +0800, Hanjun Guo wrote:
>> Hi Lorenzo,
>>
>> On 2016/6/7 21:30, Lorenzo Pieralisi wrote:
>>> This RFC patch series is v2 of a previous posting:
>>>
>>> https://lkml.org/lkml/2016/4/14/702
>>>
>>> v1 -> v2:
>>> 	- Rebased on top of dependencies series [1][2][3](v4.7-rc1)
>>> 	- Removed IOMMU fwnode generalization
>>> 	- Implemented ARM SMMU v3 ACPI probing instead of ARM SMMU v2
>>> 	  owing to patch series dependencies [1]
>>> 	- Moved platform device creation logic to IORT code to
>>> 	  generalize its usage for ARM SMMU v1-v2-v3 components
>>> 	- Removed reliance on ACPI early device probing
>>> 	- Created IORT specific iommu_xlate() translation hook leaving
>>> 	  OF code unchanged according to v1 reviews
>>>
>>> The ACPI IORT table provides information that allows instantiating
>>> ARM SMMU devices and carrying out id mappings between components on
>>> ARM based systems (devices, IOMMUs, interrupt controllers).
>>>
>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>>>
>>> Building on basic IORT support, available through [2]:
>>>
>>> this patchset enables ARM SMMU v3 support on ACPI systems.
>>
>> I'm trying to test your patches on D03 (SMMUv3 based) but ...
>
> What do you mean by "I am trying.." :), have you actually tested
> this series ?

I was rebasing this series on top of Tomasz's latest ITS patchset,
and found that patch 1~2,5 are not needed, and also have conflicts
(expected), so I think it's better to wait for the updated version
from you :)

>
>> [...]
>>> [1] R.Murphy "Generic DT bindings for PCI and ARM SMMU v3"
>>>    http://marc.info/?l=linux-arm-kernel&m=146497432413816&w=2
>>
>> ...This patch set is still in discussion and seems not work
>> for non-PCI devices.
>
> Can you be more specific please ? Yes, both series are work
> in progress.
>
>>> [2] T.Nowicki "Introduce ACPI world to ITS irqchip" v5
>>>    http://marc.info/?l=linux-acpi&m=146469369703684&w=2
>>
>> Tomasz sent out the v7 and included patches in your series.
>>
>> I think a updated version before the test makes sense, what
>> do you think? Let me know your thoughts.
>
> I am working with Robin so that the xlate() mechanism works
> properly and seamlessly for both DT and ACPI, given the
> dependencies I think it makes more sense to wait for Tomasz
> and Robin patches to get merged or at least stabilize before
> doing anything else, I am curently working on a v3.

OK.

Thanks
Hanjun
