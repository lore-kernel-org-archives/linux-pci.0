Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:29292 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731630AbeG0BYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2018 21:24:02 -0400
Cc: <keith.busch@intel.com>, <linux-pci@vger.kernel.org>,
        <Austin.Bolen@dell.com>
From: <Alex_Gagniuc@Dellteam.com>
To: <rajatja@google.com>, <mr.nuke.me@gmail.com>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Fri, 27 Jul 2018 00:04:50 +0000
Message-ID: <10cd9fec5e524a389916d7bec6759575@ausx13mps321.AMER.DELL.COM>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <CACK8Z6GsOkhTgPA1HRtgdRgKta7d=vVP_1t0EhcyJMJCj+aV+A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/26/2018 06:01 PM, Rajat Jain wrote:=0A=
> On Thu, Jul 26, 2018 at 3:38 PM Alex G. <mr.nuke.me@gmail.com> wrote:=0A=
>>=0A=
>> Hi,=0A=
>>=0A=
>> I was under the impression that a DLLSC or PDSC would trigger the=0A=
>> PCI_DEV_DISCONNECTED bit to be set, blocking any further config access.=
=0A=
> =0A=
> This sounds like an good idea to me. Caveat below.=0A=
=0A=
=0A=
>>=0A=
>> Although I'm not seeing that happen after a  "Slot(xxx): Link Down"=0A=
>> event.=0A=
> =0A=
> It should eventually happen when the pciehp takes a note and finally=0A=
> processes the event in pciehp_unconfigure_device(). I suspect that the=0A=
> reason this was put towards the end of the event processing was to be=0A=
> absolutely be sure that the device removal won't be cancelled (Since=0A=
> the bit is not being cleared anywhere, if somehow the device removal=0A=
> is not processed, it may result in ghost devices that are permanently=0A=
> "unreadable").=0A=
=0A=
I think that's something that could be fixed by clearing the =0A=
DISCONNECTED bit on a link up.=0A=
What I'm confused about here is, I've put a dump_stack() in =0A=
pci_dev_set_disconnected(), and I'm not hitting it. I see the "Link =0A=
Down" message, from which I would expect the subordinate to get =0A=
disconnected eventually. I would expect this to get hit when removing a =0A=
device:=0A=
=0A=
[ 1256.290283] pciehp 0000:b0:05.0:pcie204: Slot(179): Link Down=0A=
[ 1256.300043] pciehp 0000:b0:05.0:pcie204: Slot(179): Card not present=0A=
[no other messages related to b0:05.0 or its children]=0A=
=0A=
=0A=
Alex=0A=
=0A=
> Thanks,=0A=
> =0A=
> Rajat=0A=
> =0A=
>> I suspect my understanding is then wrong. Or maybe=0A=
>> PCI_DEV_DISCONNECTED means something else.=0A=
>>=0A=
>> In the latter case, does it not make sense to have a separate bit to say=
=0A=
>> "Don't touch this device"?=0A=
>>=0A=
>> Alex=0A=
> =0A=
=0A=
