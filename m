Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from AUSXIPPS310.us.dell.com ([143.166.148.211]:37231 "EHLO
	ausxipps310.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbaJBPpD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Oct 2014 11:45:03 -0400
From: <Jordan_Hargrave@Dell.com>
To: <wangyijing@huawei.com>, <keith.busch@intel.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<jdmason@kudzu.us>, <Jose_De_La_Rosa@Dell.com>,
	<Austin_Bolen@Dell.com>
Date: Thu, 2 Oct 2014 10:31:39 -0500
Subject: RE: [PATCH] PCI: update device mps when doing pci hotplug
Message-ID: <5B3AAEAF6B46EA4D955DF7AD46C2C48515FBE408DA@AUSX7MCPS303.AMER.DELL.COM>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>
 <20140903224201.GD26073@google.com> <540802D9.6000903@huawei.com>
 <CAErSpo6qy76zTX07Ufm0n1_HUA5G0MrAYxauEFa5QkibWsejFQ@mail.gmail.com>
 <5409117E.2000002@huawei.com> <alpine.LRH.2.03.1409241547430.4696@AMR>
 <CAErSpo5upA7KYVo=_SvwJ9pdNot_5ENi3OtiPpuzZjpwj3ghPA@mail.gmail.com>
 <54236E7B.5000905@huawei.com>
 <alpine.LRH.2.03.1409251029220.4688@AMR>,<5424DC01.6020906@huawei.com>
In-Reply-To: <5424DC01.6020906@huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

\My original proposed patch to handle MPS only lived in the hotplug code path, it wasn't part of the initial PCI configuration.
This is the code that we have had to insert into our drivers (MTIP32XX, NVME) as the current default setting doesn't work for hotplug.

http://www.spinics.net/lists/hotplug/msg04728.html

--jordan hargrave
Dell Enterprise Linux Engineering
________________________________________
From: Yijing Wang [wangyijing@huawei.com]
Sent: Thursday, September 25, 2014 10:22 PM
To: Keith Busch
Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; Hargrave, Jordan; Jon Mason
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug

On 2014/9/26 0:46, Keith Busch wrote:
> On Wed, 24 Sep 2014, Yijing Wang wrote:
>> On 2014/9/25 7:30, Bjorn Helgaas wrote:
>>> On Wed, Sep 24, 2014 at 4:41 PM, Keith Busch <keith.busch@intel.com> wrote:
>>>> Just poking this thread to make sure it's not dead. :)
>>>>
>>>> I tested Yijing's proposal and it is successful on our Intel server
>>>> platforms; hoping either this or something that derives similar behavior
>>>> will be applied so we can remove bus tuning kernel parameters.
>>>>
>>>> Tested-by: Keith Busch <keith.busch@intel.com>
>>>
>>> Oops, thanks for poking me, because this was indeed dead.
>>>
>>> My main objection was to testing "is_hotplug_bridge".  That doesn't
>>> seem right, because this issue really isn't specific to hotplug.  I
>>> didn't see a resolution of that, but let me know if I missed it.
>>
>> Why I introduced "is_hotplug_bridge" is to avoid to touch the MPS which is not
>> in hotplug case when pcie_bus_config == PCIE_BUS_TUNE_OFF.
>>
>> It's so sad that PCIe spec doesn't give a detailed guide to configure MPS.
>>
>> I'd like to refactor current MPS framework, but now there are still some puzzles
>> to me. I need to have a deeper understanding of pcie mps. I read Jon's mps patch
>> log from git, I found he turn off all this MPS config, because some issues were found
>> in some platforms, but no platforms detailed info and no bugzilla records.
>
> Just my opinion, I thought the hotplug check was a good idea: it addresses
> a known issue, and does not mess with current unknowns. Outside a hotplug
> scenario, I think we expect platform f/w to handle MPS settings and the
> kernel can stay out of the way because of the unknown platform issues. If
> it is hotplug, having the kernel set device's MPS to match the parent
> couldn't make things worse off than doing nothing, right?

Yes, I think so, but it all decided by Bjorn. I think he want a better solution,
and current patch just still is a temporary fix.

>
> On the side, I'll see if I can ping some comrades on PCI-SIG to propose
> an ECN to clarify configuring MPS. They usually ignore me though, so no
> promises. :)

Thanks in advance for your help :)

>
> .
>


--
Thanks!
Yijing

