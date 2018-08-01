Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:43755 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729645AbeHAUxl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 16:53:41 -0400
Cc: <mr.nuke.me@gmail.com>, <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <Austin.Bolen@dell.com>,
        <Stuart.Hayes@dell.com>, <Narendra.K@dell.com>,
        <Christopher.Arzola@dell.com>, <David.Chalfant@dell.com>,
        <okaya@kernel.org>
From: <Alex_Gagniuc@Dellteam.com>
To: <David.Laight@ACULAB.COM>, <lukas@wunner.de>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Wed, 1 Aug 2018 19:06:24 +0000
Message-ID: <bd5b7c8a9a8d41baa061874eb3158cf3@ausx13mps321.AMER.DELL.COM>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
 <c9a2b3463fd04f3eb7725f985c569b03@ausx13mps321.AMER.DELL.COM>
 <20180731092857.GA13494@wunner.de>
 <f05149cf4d9743878397de7763561221@ausx13mps321.AMER.DELL.COM>
 <9870eb1907ae425bb9671c73845193f3@AcuMS.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/01/2018 03:57 AM, David Laight wrote:=0A=
> From: Alex_Gagniuc@Dellteam.com=0A=
>> Sent: 31 July 2018 17:36=0A=
>>=0A=
>> On 07/31/2018 04:29 AM, Lukas Wunner wrote:=0A=
>>> On Mon, Jul 30, 2018 at 09:38:04PM +0000, Alex_Gagniuc@Dellteam.com wro=
te:=0A=
>>>> On 07/28/2018 01:31 PM, Lukas Wunner wrote:=0A=
>>>>> On Fri, Jul 27, 2018 at 05:51:04PM +0000, Alex_Gagniuc@Dellteam.com w=
rote:=0A=
>>>>>> I think PCI_DEV_DISCONNECTED is a documentation issue above all else=
.=0A=
>>>>>> The history I was given is that drivers would take a very long time =
to=0A=
>>>>>> tear down a device. Config space IO to an nonexistent device took a =
long=0A=
>>>>>> while to time out. Performance was one motivation -- and was not=0A=
>>>>>> documented.=0A=
>>>>>=0A=
>>>>> Often it is possible for the driver to detect surprise removal by=0A=
>>>>> checking if mmio reads return "all ones".  But in some cases that's=
=0A=
>>>>> a valid value to read from mmio and then this approach won't work.=0A=
>>>>> Also, checking every mmio read may negatively impact performance.=0A=
>>>>=0A=
>>>> A colleague and me beat that dead horse to the afterdeath. Consensus w=
as=0A=
>>>> that the return value is less reliable than a coin toss (of a two-head=
s=0A=
>>>> coin).=0A=
> =0A=
> Something cheap-ish to find out whether a -1 was caused by a card=0A=
> removal might be sensible - Especially if it can be done without=0A=
> a config space read.=0A=
> Clearly you can't check anything BEFORE doing the read.=0A=
> And reading the pci-id from config space isn't entirely useful.=0A=
> If the card has reset itself (and the link recovered) then you=0A=
> need to read a BAR register and check it is setup.=0A=
> =0A=
> More interestingly a read request that is inside the bridge's address=0A=
> window but outside any BAR (fairly easy to setup if the target has=0A=
> a large BAR and a small one) will also timeout (and return -1) even=0A=
> though there is no failure of the link.=0A=
> =0A=
> If the target supports AER the information about the failed cycle=0A=
> ends up in the target's AER registers - even if the host bridge=0A=
> doesn't support AER (or it is being ignored).=0A=
> So it might be useful being able to read the AER registers even when=0A=
> no AER interrupt (or other notification) actually happens.=0A=
=0A=
There are a number of ways to know a device is kaput. Information from =0A=
AER and DPC has proven to be the most reliable. So much, that for the =0A=
problems I am trying to solve, this information is necessary and sufficient=
.=0A=
=0A=
> I've not managed to get linux to pick up AER interrupts even on=0A=
> systems where the hardware clearly supports them (at least on=0A=
> some slots).  I suspect the BIOS is carefully disabling them=0A=
> because of reports of message logs being spammed with AER errors.=0A=
=0A=
I suspect you've hit an FFS bug.=0A=
=0A=
> We also have one system (possibly a Dell 740)=0A=
=0A=
Not sure we make a "possibly 740" model. Let me ask around.=0A=
=0A=
> where any failure of a PCIe link leads to an NMI and a kernel crash!=0A=
=0A=
The kernel crash is a linux bug. I've worked on that extensively in the =0A=
past. We tried to fix it [1]. Unfortunately, due to an unprofessional =0A=
maintainer and months of spinning in circles, word came that our =0A=
resources are better spent elsewhere. Feel free to pick up where we left =
=0A=
off.=0A=
=0A=
> Not entirely useful in a server model that is supposed to have=0A=
> resilience against various errors.=0A=
=0A=
You're preaching to the choir. The architecture and features are driven =0A=
by customer demand. A lot of those "features" -- I haven't asked what =0A=
they are -- are easily implemented with FFS. If you have a problem with =0A=
FFS in particular -- and I do realize a lot of the specs around FFS are =0A=
poorly written and not well thought out -- then it's marketing, sales =0A=
and corporate that should know.=0A=
=0A=
Here's the thing. I think the FW's job is to do the absolute minimal =0A=
initialization to pass on control to the OS. uboot/linux stacks execute =0A=
this beautifully. But customers want features, that very often, OS =0A=
vendors are hesitant or outright refusing to implement. The only =0A=
remaining place to implement them is the platform.=0A=
=0A=
It sucks, but it's how things are. Anyway, the patches at [1] should =0A=
solve your system crashing issue.=0A=
=0A=
Alex=0A=
=0A=
=0A=
[1] https://lore.kernel.org/patchwork/patch/908811/=0A=
=0A=
