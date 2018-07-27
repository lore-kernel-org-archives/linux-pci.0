Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:52099 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388739AbeG0TOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jul 2018 15:14:05 -0400
Cc: <mr.nuke.me@gmail.com>, <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <Austin.Bolen@dell.com>,
        <Stuart.Hayes@dell.com>, <Narendra.K@dell.com>,
        <Christopher.Arzola@dell.com>, <David.Chalfant@dell.com>
From: <Alex_Gagniuc@Dellteam.com>
To: <lukas@wunner.de>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Fri, 27 Jul 2018 17:51:04 +0000
Message-ID: <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/27/2018 12:05 PM, Lukas Wunner wrote:=0A=
> On Fri, Jul 27, 2018 at 03:52:04PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 07/27/2018 02:18 AM, Lukas Wunner wrote:=0A=
>>> On Thu, Jul 26, 2018 at 05:38:50PM -0500, Alex G. wrote:=0A=
>>>> I was under the impression that a DLLSC or PDSC would trigger the=0A=
>>>> PCI_DEV_DISCONNECTED bit to be set, blocking any further config access=
.=0A=
>>>=0A=
>>> Only if the Presence Detect State bit in the Slot Status register is=0A=
>>> not set.=0A=
>>>=0A=
>>> I think the idea was that if the card is still in the slot, its driver =
can=0A=
>>> be unbound orderly because the device is still accessible.  So there's =
no=0A=
>>> need to set PCI_DEV_DISCONNECTED.=0A=
>>=0A=
>> This sounds counter to what I had intuited. I mentally associate=0A=
>> DISCONNECTED with "the link is down". I don't understand the idea of a=
=0A=
>> driver doing an orderly removal when the link is down. Device registers=
=0A=
>> wouldn't be accessible in that case.=0A=
> =0A=
> That's basically what I meant, sorry for not being clear.=0A=
> =0A=
>>> However if there is a already a new card in the slot, PCI_DEV_DISCONNEC=
TED=0A=
>>> will erroneously not be set.  Also, if card removal was triggered by th=
e=0A=
>>> link going down but the card is still in the slot, PCI_DEV_DISCONNECTED=
=0A=
>>> will also erroneously not be set even though it's inaccessible.=0A=
>>>=0A=
>>> The only situations when PCI_DEV_DISCONNECTED should not be set is if t=
he=0A=
>>> card is being removed by sysfs or by the user pressing the Attention Bu=
tton.=0A=
>>> Anything else is a surprise removal.  What we need to do is pass down a=
=0A=
>>> flag to pciehp_unconfigure_device() to indicate whether one of those tw=
o=0A=
>>> situations is at hand or not, and PCI_DEV_DISCONNECTED should be set=0A=
>>> depending on that flag.=0A=
>>=0A=
>> That makes a little more sense. Is someone working on this?=0A=
> =0A=
> Me, but not for 4.19, we're too late in the cycle, I'm going to post=0A=
> a small number of fixup patches for Bjorn's pci/hotplug branch shortly,=
=0A=
> to be included in 4.19, and that's it.=0A=
> =0A=
> I posted a patch as part of the series that's now on Bjorn's pci/hotplug=
=0A=
> branch which touched PCI_DEV_DISCONNECTED code in pciehp_pci.c, but had=
=0A=
> to withdraw that particular patch:=0A=
> https://patchwork.ozlabs.org/patch/930403/=0A=
> =0A=
> The first problem with that patch was that I hadn't fully understood=0A=
> yet when to set PCI_DEV_DISCONNECTED and when not to set it.=0A=
=0A=
I think PCI_DEV_DISCONNECTED is a documentation issue above all else. =0A=
The history I was given is that drivers would take a very long time to =0A=
tear down a device. Config space IO to an nonexistent device took a long =
=0A=
while to time out. Performance was one motivation -- and was not documented=
.=0A=
=0A=
> The second problem was that it fixed a deadlock on unplug in a way=0A=
> that wasn't generic enough.  The same deadlock can occur in other=0A=
> situations.  The real fix is to unbind the driver lockless in=0A=
> pci_stop_dev().  That's non-trivial to achieve, but doable.=0A=
> I don't think there's a way around that to fix the problem:=0A=
> https://www.spinics.net/lists/linux-pci/msg73652.html=0A=
> =0A=
> There's (still) a lot that can be improved in pciehp, I hope to=0A=
> keep working on that as time permits.=0A=
=0A=
Thanks for all the info. The fix that I was settling on is (pasted) =0A=
below. Though that seems to conflict a bit with what you are trying to =0A=
do. Now I'm a little conflicted If I should try to submit the below or not.=
=0A=
=0A=
Alex=0A=
=0A=
diff --git a/drivers/pci/hotplug/pciehp_pci.c =0A=
b/drivers/pci/hotplug/pciehp_pci.c=0A=
index 3f518dea856d..5cf02639fa0b 100644=0A=
--- a/drivers/pci/hotplug/pciehp_pci.c=0A=
+++ b/drivers/pci/hotplug/pciehp_pci.c=0A=
@@ -74,6 +74,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)=0A=
         ctrl_dbg(ctrl, "%s: domain:bus:dev =3D %04x:%02x:00\n",=0A=
                  __func__, pci_domain_nr(parent), parent->number);=0A=
         pciehp_get_adapter_status(p_slot, &presence);=0A=
+       presence =3D presence && pciehp_check_link_active(ctrl);=0A=
=0A=
         pci_lock_rescan_remove();=0A=
=0A=
=0A=
=0A=
> Thanks,=0A=
> =0A=
> Lukas=0A=
> =0A=
=0A=
