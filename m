Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:52731 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbeGaSRA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2018 14:17:00 -0400
Cc: <mr.nuke.me@gmail.com>, <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <Austin.Bolen@dell.com>,
        <Stuart.Hayes@dell.com>, <Narendra.K@dell.com>,
        <Christopher.Arzola@dell.com>, <David.Chalfant@dell.com>,
        <okaya@kernel.org>
From: <Alex_Gagniuc@Dellteam.com>
To: <lukas@wunner.de>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Tue, 31 Jul 2018 16:35:51 +0000
Message-ID: <f05149cf4d9743878397de7763561221@ausx13mps321.AMER.DELL.COM>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de>
 <c9a2b3463fd04f3eb7725f985c569b03@ausx13mps321.AMER.DELL.COM>
 <20180731092857.GA13494@wunner.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/31/2018 04:29 AM, Lukas Wunner wrote:=0A=
> On Mon, Jul 30, 2018 at 09:38:04PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 07/28/2018 01:31 PM, Lukas Wunner wrote:=0A=
>>> On Fri, Jul 27, 2018 at 05:51:04PM +0000, Alex_Gagniuc@Dellteam.com wro=
te:=0A=
>>>> I think PCI_DEV_DISCONNECTED is a documentation issue above all else.=
=0A=
>>>> The history I was given is that drivers would take a very long time to=
=0A=
>>>> tear down a device. Config space IO to an nonexistent device took a lo=
ng=0A=
>>>> while to time out. Performance was one motivation -- and was not=0A=
>>>> documented.=0A=
>>>=0A=
>>> Often it is possible for the driver to detect surprise removal by=0A=
>>> checking if mmio reads return "all ones".  But in some cases that's=0A=
>>> a valid value to read from mmio and then this approach won't work.=0A=
>>> Also, checking every mmio read may negatively impact performance.=0A=
>>=0A=
>> A colleague and me beat that dead horse to the afterdeath. Consensus was=
=0A=
>> that the return value is less reliable than a coin toss (of a two-heads=
=0A=
>> coin).=0A=
> =0A=
> Can you elaborate why?  Because the "official" stance is that checking=0A=
> every read where "all ones" is an invalid value is the proper way to=0A=
> detect unplugged devices.  (Official as in, voiced by Greg KH and Bjorn.)=
=0A=
> In that sense, PCI_DEV_DISCONNECTED is sort of an unloved child.=0A=
=0A=
All ones is not necessarily invalid. The bug surface is every single =0A=
config read. This approach doesn't even cover config writes -- config =0A=
writes are non-posted requests too in PCIe.=0A=
"Build it, and they will come". That means that drivers would expect =0A=
-ENODEV when a device is gone. If we have that infrastructure, more =0A=
drivers will start using it over time, and it's something that can also =0A=
be used by generic parts of the PCI code. That also means you need a =0A=
generic mechanism to determine a device is bye-bye, and that's what =0A=
PCI_DEV_DISCONNECTED gives you.=0A=
=0A=
> See this thread:=0A=
> https://www.spinics.net/lists/linux-acpi/msg81445.html=0A=
=0A=
The discussion is based on the wrong assumptions that reads are =0A=
symmetrical wrt to a device being present or not. However, completion =0A=
timeouts and unsupported requests blow that assumption right out of the =0A=
water. Best case scenario, you just waste a little more time waiting for =
=0A=
hardware IO. More common is to end up crashing the machine.=0A=
=0A=
Greg's ideas work in a perfect world where PCI and PCIe are equivalent =0A=
at every level. And in that case, PCI_DEV_DISCONNECTED would have been =0A=
pure, 100% genuine Redmond bloatware. We wouldn't have gotten complaints =
=0A=
from Facebook and other industry players that it takes too damn long to =0A=
remove a device. We probably also wouldn't be seeing machines crash on =0A=
PCIe removal.=0A=
=0A=
Fun fact: Before PCI_DEV_DISCONNECTED, you could physically swap a =0A=
device before the the teardown path was done with the previous device. =0A=
Figuring out what problems that caused is left as an exercise to the reader=
.=0A=
=0A=
>>> FWIW, the below is what I had in mind (on top of Bjorn's pci/hotplug=0A=
>>> branch).  Does this work for you?=0A=
>>=0A=
>> This, and another patch (you have been CC'd) solve my problem of=0A=
>> crashing during surprise removal. Thanks!=0A=
> =0A=
> Ok thanks, I submitted the patch this morning with your Tested-by.=0A=
=0A=
Sweet. Thanks!=0A=
=0A=
> Unfortunately I forgot to cc all your Dell colleagues, sorry.=0A=
=0A=
They'll live. They already noticed it and sent me emails about it.=0A=
=0A=
Alex=0A=
=0A=
> Lukas=0A=
> =0A=
=0A=
