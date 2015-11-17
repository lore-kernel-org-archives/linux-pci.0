Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36351 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbbKQEng (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2015 23:43:36 -0500
Received: by pacdm15 with SMTP id dm15so198108626pac.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2015 20:43:35 -0800 (PST)
Subject: Re: [PATCH v7 14/50] powerpc/powernv: M64 support on P7IOC
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-15-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D8A.2050505@ozlabs.ru> <20151117014203.GC31584@gwshan>
 <564A92E2.1040506@ozlabs.ru> <20151117030406.GB10142@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564AB070.9040500@ozlabs.ru>
Date: Tue, 17 Nov 2015 15:43:28 +1100
MIME-Version: 1.0
In-Reply-To: <20151117030406.GB10142@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/17/2015 02:04 PM, Gavin Shan wrote:
> On Tue, Nov 17, 2015 at 01:37:22PM +1100, Alexey Kardashevskiy wrote:
>> On 11/17/2015 12:42 PM, Gavin Shan wrote:
>>> On Mon, Nov 16, 2015 at 07:02:18PM +1100, Alexey Kardashevskiy wrote:
>>>> On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>>>> This enables M64 window on P7IOC, which has been enabled on PHB3.
>>>>> Different from PHB3 where 16 M64 BARs are supported and each of
>>>>> them can be owned by one particular PE# exclusively or divided
>>>>> evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
>>>>> of them are divided to 8 segments. So every P7IOC PHB supports
>>>>> 128 M64 segments in total. P7IOC has M64DT, which helps mapping
>>>>> one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
>>>>> M64DT, indicating that one M64 segment can only be pinned to the
>>>>> fixed PE#. In order to have same code to support M64 on P7IOC and
>>>>> PHB3, we just provide 128 M64 segments on every P7IOC PHB and each
>>>>> of them is pinned to the fixed PE# by bypassing the function of
>>>>> M64DT. In turn, we just need different phb->init_m64() for P7IOC
>>>>> and PHB3 to support M64.
>>>>
>>>> I thought we decided (Ben suggested?) not to push P7IOC code now (or ever) as
>>>> there is no user for it, has this changed?
>>>>
>>>
>>> Remember that the code is mixed for P7IOC/PHB3. It's not harmful to support
>>> M64 window on P7IOC, which is much larger than M32.
>>
>>
>> The patchset starts with removing dead code and then adds more dead code.
>> This is not right...
>>
>
> Sorry, you mean it's fine to break the code on P7IOC as it's going to be dead.


I am saying that the _new_ code which implements PCI hotplug on P7IOC is 
dead, not the existing P7IOC support which needs to keep working. Reworks 
you make should keep P7IOC alive but they do not have to add hotplug.

imho it is more likely that we drop P7IOC support in the mainline kernel in 
next 5 years than someone plugs a PCI device to a running P7IOC machine 
anywhere.


> But I'm curious when it's going happen, any idea about that?
>
>>>> btw please put ioda1/ioda2/p7ioc/etc to the subject line to make it easier to
>>>> see how much work is there about particular PHB type. You rename quite many
>>>> functions and I generally want to ask you to group all renaming patches first
>>>> but it would also make sense to keep them close to (for example)
>>>> p7ioc-related patches so having more descriptive subject lines may help.
>>>> Thanks.
>>>>
>>>
>>> As the code is mixed for P7IOC/PHB3, I'm not following the line (IODA1/IODA2/p7ioc/phb3)
>>> in this patchset.
>>
>> But you should draw the bold line between PHB types imho.
>>
>>> Instead, the sequence of patchset is order related to: cod refactoring,
>>> IO/M32/M64, DMA, PE allocation/releaseing.
>>
>>
>> Some patches from this patchset are about P7IOC only. All I am asking is to
>> say specifically in the subject line what the patch touches -
>> IODA1/IODA2/p7ioc/phb3/all_of_them. Or I can walk through all of them, pick
>> P7IOC's ones, evaluate the amount of code and entropy they actually add and
>> then ask Ben what we do about it, it will just take longer rather than if you
>> did it.
>>
>
> Please give me a clear command what key words you need in the subject in next revision.
> What I understood is you want to see one of them:
>
> powerpc/powernv/ioda1:

Yes, looks good.

> powerpc/powernv/ioda2:


Yes.

> powerpc/powernv/all:

Just "powerpc/powernv".



-- 
Alexey
