Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60567 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbbBKQ7k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Feb 2015 11:59:40 -0500
Message-ID: <54DB8A4C.9050002@ti.com>
Date: Wed, 11 Feb 2015 11:58:52 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>
Subject: Re: [PATCH v6 0/7] PCI: get DMA configuration from parent device
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com> <20150206151542.GD23190@e104818-lin.cambridge.arm.com> <54D4DD95.7000303@ti.com> <CAErSpo6GOXHeKKfU8s5jCS3+Mui=HupZd=jpkLEyWAE94Ory5w@mail.gmail.com> <54D509C9.9010204@ti.com> <54DB8960.9010707@ti.com>
In-Reply-To: <54DB8960.9010707@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/11/2015 11:54 AM, Murali Karicheri wrote:
> On 02/06/2015 01:36 PM, Murali Karicheri wrote:
>> On 02/06/2015 12:53 PM, Bjorn Helgaas wrote:
>>> On Fri, Feb 6, 2015 at 9:28 AM, Murali Karicheri<m-karicheri2@ti.com>
>>> wrote:
>>>> On 02/06/2015 10:15 AM, Catalin Marinas wrote:
>>>>>
>>>>> On Thu, Feb 05, 2015 at 09:52:52PM +0000, Murali Karicheri wrote:
>>>>>>
>>>>>> This patch add an important capability to PCI driver on Keystone. I
>>>>>> hope
>>>>>> to
>>>>>> have this merged to the upstream branch so that it is available for
>>>>>> v3.20.
>>>>>
>>>>> It's very late for 3.20 and the code hasn't been in linux-next at all
>>>>> (but it's not me who's merging this code), unless you can squeeze
>>>>> it in
>>>>> as a bug-fix.
>>>>
>>>> This is in fact a bug fix as PCI on Keystone is broken without this.
>>>
>>> Oh, sorry, I didn't realize that this was so urgent. I guess I read
>>> "this adds an important capability" in the cover letter and concluded
>>> that it was new functionality.
>> Bjorn,
>>
>> Thanks for responding.
>>
>> Let me give you some context on this without which my explanation won't
>> be complete. For using PCI driver on Keystone, I had submitted patches
>> related to machine and DTS to the arm mailing list to enable the driver
>> on Keystone. Subsequenty one of the patch from my series was Nack-ed and
>> I was asked to implememented in a different way and started this series.
>> You can refer to the discussion of this at
>>
>> http://www.gossamer-threads.com/lists/linux/kernel/2024591
>>
>> The PCI driver enablement on Keystone is still a working in progress and
>> I am trying to get it fully functional on the upstream. Another missing
>> piece is the SerDes phy driver patch. We have started working on the
>> other part (SerDes phy driver) already as the initial one was not
>> accepted. So it is fine if we are too late for the v3.20 merge window to
>> merge this series and this can be applied to the next branch for v3.21.
>>
>>>
>>> Anyway, if it's broken, presumably PCI on Keystone *did* work at one
>>> point. Can you identify the commit that broke it and requires these
>>> fixes, so we can figure out how far the fixes need to be backported?
>>>
>>
>> I am trying to get this driver enabled on Keystone by adding the missing
>> pieces as described above. So I guess we don't have to back port
>> anything here.
>>
>>> If I merge it, I would like to get into my for-linus branch and get a
>>> little time in -next before asking Linus to pull it. The merge window
>>> is a little wrinkle there -- I don't like to add new things to the mix
>>> during the window. But if it's an important fix we can still get it
>>> in before the final v3.20.
>>
>> Please apply this to next branch for v3.21. It currently apply cleanly
>> to v3.19-rc7. If you want me rebase to another branch, let me know I can
>> apply and send you an updated patch.
>>
> Bjorn, Arnd,
>
> I am assuming, Bjorn is going to merge this to his next branch for
> v3.21. If not, it might have to be merged through the arm soc? There are
> a couple of Tested-by and Acked-by received after v7. Do you want me to
> post v8 with these updated in the patches?
FYI.

These are the updates.
Series was

1) Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
    (on AMD Seattle platform w/ PCI Generic Host controller)
2) Acked-by: Will Deacon <will.deacon@arm.com>
3) Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

If you want to send a updated series with these, please let me know.

Thanks and regards,

Murali
>
> Murali
>
>> Thanks
>>
>> Murali
>>
>>>
>>> Bjorn
>>
>>
>
>


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
