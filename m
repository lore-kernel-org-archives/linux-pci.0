Return-Path: <SRS0=sSuZ=5A=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=sSuZ=5A=rock-chips.com=shawn.lin@kernel.org>
Subject: Re: [PATCH v4] PCI: use IDA to manage domain number if not getting it
 from DT
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1495611455-41952-1-git-send-email-shawn.lin@rock-chips.com>
 <20170525194353.GA3390@bhelgaas-glaptop.roam.corp.google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Brian Norris <briannorris@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <3950969a-53b8-96ce-7504-e0b578ea9443@rock-chips.com>
Date: Fri, 26 May 2017 15:08:21 +0800
MIME-Version: 1.0
In-Reply-To: <20170525194353.GA3390@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2017/5/26 3:43, Bjorn Helgaas wrote:
> On Wed, May 24, 2017 at 03:37:35PM +0800, Shawn Lin wrote:
>> If not getting domain number from DT, the domain number will
>> keep increasing once doing unbind/bind RC drivers. This could
>> introduce pointless tree view of lspci as shows below:
>>
>> -+-[0001:00]---00.0-[01]----00.0
>>   \-[0000:00]-
>>
>> The more test we do, the lengthier it would be. The more serious
>> issue is that if attaching two hierarchies for two different domains
>> belonging to two root bridges, so when doing unbind/bind test for one
>> of them and keep the other, then the domain number would finally
>> overflow and make the two hierarchies of devices share the some domain
>> number but actually they shouldn't. So it looks like we need to invent
>> a new indexing ID mechanism to manage domain number. This patch
>> introduces idr to achieve our purpose.
>>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v4:
>> - make domain_nr depends on CONFIG_PCI_DOMAINS instead of
>> CONFIG_PCI_DOMAINS_GENERIC.(reported by Kbuild Robot)
>
> I'm confused about why you posted this v4.  It addresses a kbuild
> issue, but not any of the questions from my review of v3, so reviewing
> v4 would be a waste of my time.
>

I feel very sorry about that if you were confused by my v4 which didn't
address your comment in v3. But the fact is that it's unfortunate
your comment for v3 arrived just right after I posted my v4, if you
checked the mail's timestamp. :(

> But since we're here, my naive suggestion:
>
>>> 1) If we're using ACPI, every host bridge must have a _SEG method,
>>> and it supplies the domain.  We ignore any bridge without _SEG.
>>>
>>> 2) If we're using DT, every host bridge must supply
>>> "linux,pci-domain", and it supplies the domain.  We ignore any
>>> bridge without "linux,pci-domain".
>>>
>>> 3) Otherwise, we always use IDA.
>
> was *too* simplistic.  _SEG is optional.  If it's missing we default
> to domain 0.
>
> The point is that we can't mix the IDA with either the ACPI or DT
> info.  I think for ACPI it should be easy: if _SEG exists, we use
> that.  If _SEG doesn't exist, the spec says we that bridge is in
> domain 0.  So I think we should never use IDA if we're using ACPI.

got it.

>
> For DT, I think we can't use IDA if *any* bridge uses
> "linux,pci-domain", because there's no way to allocate a specified
> domain from the IDA.
>
> Of course, we see the bridges one at a time, so we don't know ahead of
> time whether any uses "linux,pci-domain".  I think that means we have
> to decide when we see the very first host bridge which strategy to
> use.  If the first host bridge has "linux,pci-domain", we use that,
> and if future host bridges don't supply "linux,pci-domain", we
> probably have to ignore the whole bridge.
>
> If the first host bridge doesn't have "linux,pci-domain", we use IDA,
> and we probably have to ignore any future bridges that *do* have
> "linux,pci-domain".
>
> So it seems like "linux,pci-domain" is basically an all-or-none
> proposition.

That makes sense to me.

>



> Bjorn
>
>
>
