Return-Path: <SRS0=n5fO=ZN=samsung.com=jh80.chung@kernel.org>
Return-Path: <SRS0=n5fO=ZN=samsung.com=jh80.chung@kernel.org>
Subject: Re: [PATCH V3 0/5] PCI: exynos: cleans the minor things
To: Jingoo Han <jingoohan1@gmail.com>, 'Bjorn Helgaas' <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, krzk@kernel.org,
 linux-kernel@vger.kernel.org, javier@osg.samsung.com, kgene@kernel.org,
 linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
 'Pankaj Dubey' <pankaj.dubey@samsung.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <7c5ba1ea-e2a9-aac3-2007-73ae6a83c8e5@samsung.com>
Date: Wed, 01 Feb 2017 08:41:34 +0900
MIME-version: 1.0
In-reply-to: <003901d27c07$506c3610$f144a230$@gmail.com>
Content-type: text/plain; charset=windows-1252
References: 
 <CGME20170116063140epcas5p38fffe5effdcfd2650cad98c25c31335e@epcas5p3.samsung.com>
 <20170116063138.25805-1-jh80.chung@samsung.com>
 <20170128212730.GA22283@bhelgaas-glaptop.roam.corp.google.com>
 <003901d27c07$506c3610$f144a230$@gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On 02/01/2017 06:16 AM, Jingoo Han wrote:
> On Saturday, January 28, 2017 4:28 PM, Bjorn Helgaas wrote:
>> On Mon, Jan 16, 2017 at 03:31:33PM +0900, Jaehoon Chung wrote:
>>> Current pci-exynos.c is used for only EXYNOS5440.
>>> It's too complex to support the other Exynos SoCs.
>>> Before supporting the other Exynos SoCs, it needs to clean the codes.
>>>
>>> Changelog on V3:
>>> - Splits "PCI: exynos: replace to one register accessor from each
>> accessors"
>>>
>>> Changelog on V2:
>>> - Changes the all pointer names as "ep" instead of "exynos_pcie"
>>>
>>> Jaehoon Chung (5):
>>>   PCI: exynos: Rename all pointer names from "exynos_pcie" to "ep"
>>>   PCI: exynos: Replace the *_blk/*_phy/*_elb accessors
>>>   PCI: exynos: Remove the unnecessary variables
>>>   PCI: exynos: Use the bitops API to operate the bit shifting
>>>   PCI: exynos: remove the duplicated codes
>>>
>>>  drivers/pci/host/pci-exynos.c | 392 +++++++++++++++++++----------------
>> -------
>>
>> Waiting for ack from Jingoom, per MAINTAINERS:
>>
>> Jingoo Han <jingoohan1@gmail.com> (maintainer:PCI DRIVER FOR SAMSUNG
>> EXYNOS)
> 
> It looks good.
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thank you! I will post the other patches soon.

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Jingoo
> 
>>
>> Pankaj has a follow-on patch that depends on this series:
>> https://patchwork.ozlabs.org/patch/711210/
> 
> 
> 
