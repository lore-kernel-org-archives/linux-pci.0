Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:54087 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388156AbeG0ROh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jul 2018 13:14:37 -0400
Cc: <keith.busch@intel.com>, <linux-pci@vger.kernel.org>,
        <Austin.Bolen@dell.com>, <Stuart.Hayes@dell.com>,
        <Narendra.K@dell.com>, <Christopher.Arzola@dell.com>,
        <David.Chalfant@dell.com>
From: <Alex_Gagniuc@Dellteam.com>
To: <lukas@wunner.de>, <mr.nuke.me@gmail.com>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Fri, 27 Jul 2018 15:52:04 +0000
Message-ID: <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lukas,=0A=
=0A=
+CC some more Dell folks.=0A=
=0A=
On 07/27/2018 02:18 AM, Lukas Wunner wrote:=0A=
> On Thu, Jul 26, 2018 at 05:38:50PM -0500, Alex G. wrote:=0A=
>> I was under the impression that a DLLSC or PDSC would trigger the=0A=
>> PCI_DEV_DISCONNECTED bit to be set, blocking any further config access.=
=0A=
> =0A=
> Only if the Presence Detect State bit in the Slot Status register is=0A=
> not set.=0A=
> =0A=
> I think the idea was that if the card is still in the slot, its driver ca=
n=0A=
> be unbound orderly because the device is still accessible.  So there's no=
=0A=
> need to set PCI_DEV_DISCONNECTED.=0A=
=0A=
This sounds counter to what I had intuited. I mentally associate =0A=
DISCONNECTED with "the link is down". I don't understand the idea of a =0A=
driver doing an orderly removal when the link is down. Device registers =0A=
wouldn't be accessible in that case.=0A=
=0A=
> However if there is a already a new card in the slot, PCI_DEV_DISCONNECTE=
D=0A=
> will erroneously not be set.  Also, if card removal was triggered by the=
=0A=
> link going down but the card is still in the slot, PCI_DEV_DISCONNECTED=
=0A=
> will also erroneously not be set even though it's inaccessible.=0A=
> =0A=
> The only situations when PCI_DEV_DISCONNECTED should not be set is if the=
=0A=
> card is being removed by sysfs or by the user pressing the Attention Butt=
on.=0A=
> Anything else is a surprise removal.  What we need to do is pass down a=
=0A=
> flag to pciehp_unconfigure_device() to indicate whether one of those two=
=0A=
> situations is at hand or not, and PCI_DEV_DISCONNECTED should be set=0A=
> depending on that flag.=0A=
=0A=
That makes a little more sense. Is someone working on this?=0A=
=0A=
> Are you testing Bjorn's pci/hotplug branch or something based on 4.18 or=
=0A=
> earlier?  There is a major event handling rework queued on that branch,=
=0A=
> so you may want to test with that.=0A=
=0A=
Been using 4.18-rc6. I'll take a look at Bjorn's latest and greatest. =0A=
Thank you for the heads-up.=0A=
=0A=
>> In the latter case, does it not make sense to have a separate bit to say=
=0A=
>> "Don't touch this device"?=0A=
> =0A=
> Hm, what would you need it for?=0A=
=0A=
Idiotic firmware bugs and unrefined device removal mechanisms. For =0A=
example, on removal, we shouldn't be touching MSI registers on a device =0A=
whose link is down. Firmware-first (FFS) systems tend to blow up, crash, =
=0A=
and burn when that happens.=0A=
=0A=
Another example is NVME subsystem resets (NSSR). NSSR resets the PCIe =0A=
link, and the PD state stays the same. Once teardown gets to masking the =
=0A=
MSI-X bits, it sends an MMIO to the downed link.=0A=
=0A=
I want to resolve such crashes by guarding teardown paths against =0A=
touching registers on the disconnected device -- yes, I know it's a =0A=
band-aid and not a cure.=0A=
=0A=
Alex=0A=
=0A=
> Thanks,=0A=
> =0A=
> Lukas=0A=
> =0A=
