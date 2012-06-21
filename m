Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:23223
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759470Ab2FUMb3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 08:31:29 -0400
Message-ID: <4FE31385.3060502@amd.com>
Date: Thu, 21 Jun 2012 14:28:53 +0200
From: Wei Wang <wei.wang2@amd.com>
MIME-Version: 1.0
To: Jan Beulich <JBeulich@suse.com>
CC: SherryHurwitz <sherry.hurwitz@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>, <stable@kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	KonradRzeszutek Wilk <konrad.wilk@oracle.com>,
	<linux-pci@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	<ebiederm@xmission.com>
Subject: Re: [PATCH] PCI/MSI: don't disable AMD IOMMU MSI on Xen dom0
References: <4FD72FE4.80009@amd.com> <4FD778C802000078000897EF@nat28.tlf.novell.com> <4FD76976.2020203@citrix.com> <4FD78DE6020000780008986D@nat28.tlf.novell.com> <4FD9D559.9050206@amd.com> <4FDA0ECD0200007800089FEA@nat28.tlf.novell.com> <4FDA0028.3090609@amd.com> <4FE30CBB020000780008B06B@nat28.tlf.novell.com> <4FE303C4.3060705@amd.com> <4FE32A81020000780008B11B@nat28.tlf.novell.com>
In-Reply-To: <4FE32A81020000780008B11B@nat28.tlf.novell.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/21/2012 02:06 PM, Jan Beulich wrote:
>>>> On 21.06.12 at 13:21, Wei Wang<wei.wang2@amd.com>  wrote:
>> On 06/21/2012 11:59 AM, Jan Beulich wrote:
>>>>>> On 14.06.12 at 17:15, Wei Wang<wei.wang2@amd.com>   wrote:
>>>> Am 14.06.2012 16:18, schrieb Jan Beulich:
>>>>> Have you at all considered getting this fixed on the kernel side?
>>>>> As I don't have direct access to any AMD IOMMU capable
>>>>> system - can one, other than by enumerating the respective
>>>>> PCI IDs or reading ACPI tables, reasonably easily identify the
>>>>> devices in question (e.g. via vendor/class/sub-class or some
>>>>> such)? That might permit skipping those in the offending kernel
>>>>> code...
>>>>
>>>> AMD IOMMUs (both v1 and v2) uses class id 08 (System Base Peripheral)
>>>> and sub class id 06 (IOMMU). Combined with PCI_VENDEOR_ID_AMD, this
>>>> should be enough to identify amd iommu device. I could send you a kernel
>>>> patch for review using this approach. I would believe that fixing this
>>>> issue in 4.2, no matter how, is really important for amd iommu.
>>>
>>> As you didn't come forward with anything, here's my first
>>> take on this:
>>
>> Hi Jan
>> Thanks a lot for the patch. Actually I plan to send my version today,
>> which is based on 3.4 pv_ops but looks very similar to yours. So, Acked!
>>
>> I also evaluated the possibility of hiding iommu device from dom0. I
>> think the change is no quite a lot, at least, for io based pcicfg
>> access. A proof-of-concept patch is attached.
>
> This completely hides the device from Dom0, but only when
> config space is accessed via method 1. Did you not see my
> earlier patch doing this for MCFG as well
Could you please provide a particular c/s number?... (I saw too many c/s 
might be related to this topic). so that I could work out a patch to 
support both i/o and mmcfg.

(albeit only disallowing
> writes, so allowing the device to still be seen by Dom0)?
Sounds better to me...this still allows user to check iommu status from 
lspci.

> Whether completely hiding the device is actually okay I can't
> easily tell: Would IOMMUs always be either at func 0 of a single-
> unction device, or at a non-zero func of a multi-function one? If
> not, other devices may get hidden implicitly.

AMD IOMMU is an independent pci-e endpoint, and this function will not 
be used for other purposes other than containing an iommu. So I don't 
see that iommu will share bdf value with other devices.

Thanks,
Wei

> Also I noticed just now that guest_io_read() wouldn't really
> behave correctly when pci_cfg_ok() returned false - it might
> pass back 0xff even for a multi-byte read. I'll send a fix shortly.
>
> Jan
>
>> --- a/xen/arch/x86/traps.c      Thu Jun 21 11:30:59 2012 +0200
>> +++ b/xen/arch/x86/traps.c      Thu Jun 21 13:19:02 2012 +0200
>> @@ -73,6 +73,7 @@
>>    #include<asm/hpet.h>
>>    #include<public/arch-x86/cpuid.h>
>>    #include<xsm/xsm.h>
>> +#include<asm/hvm/svm/amd-iommu-proto.h>
>>
>>    /*
>>     * opt_nmi: one of 'ignore', 'dom0', or 'fatal'.
>> @@ -1686,10 +1687,19 @@ static int pci_cfg_ok(struct domain *d,
>>    {
>>        uint32_t machine_bdf;
>>        uint16_t start, end;
>> +    struct amd_iommu *iommu;
>> +
>>        if (!IS_PRIV(d))
>>            return 0;
>>
>>        machine_bdf = (d->arch.pci_cf8>>  8)&  0xFFFF;
>> +
>> +    for_each_amd_iommu ( iommu )
>> +    {
>> +        if ( machine_bdf == iommu->bdf )
>> +            return 0;
>> +    }
>> +
>>        start = d->arch.pci_cf8&  0xFF;
>>        end = start + size - 1;
>>        if (xsm_pci_config_permission(d, machine_bdf, start, end, write))
>
>
>


