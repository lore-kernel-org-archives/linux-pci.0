Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:48039 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbaGQBAb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 21:00:31 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so3180248vcb.37
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 18:00:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQW+GbprQZNvHC-ek1cSydP3KWcjgAU0ii5_jECC1+tXrg@mail.gmail.com>
References: <CAKAYmMLfxkmaVxaPDd6z=B0ESQ3mR=dUG4OFFgEoy0295qLYgg@mail.gmail.com>
	<CAKAYmMLhPhukBbR8NhPk3EigmvwiX+DEGj-Mod7zpHMnZKRsLw@mail.gmail.com>
	<CAErSpo7vooChRfSF6oY8GcqVYZruv-7_D0zm3a4M_KDVMbWNiA@mail.gmail.com>
	<CAE9FiQWomktcpSHeFwxWBLXmAsbdXEHv6sOrNXodobkBw=mRKA@mail.gmail.com>
	<CAE9FiQW+GbprQZNvHC-ek1cSydP3KWcjgAU0ii5_jECC1+tXrg@mail.gmail.com>
Date: Wed, 16 Jul 2014 18:00:31 -0700
Message-ID: <CAKAYmMJf=TdpdyALZQOoAmdgPjpzFu-OP7rMLzyaFRno-36F6Q@mail.gmail.com>
Subject: Re: Error assigning BAR 0 to hotplugged device
From: Chuck Tuffli <ctuffli@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 16, 2014 at 4:47 PM, Yinghai Lu <yinghai@kernel.org> wrote:
...
> in the tree:
>    80:03.0 ==> 96:00.0 ==> 97:08.0 ==> 98:00.0 ==> 99:00.0 ==> 9a:00.0
> ==> 9b:15.0
>
> only 97:08.0 and 99:00.0 is hotplug+.
>
> and kernel will honor BIOS set value at first, and realloc will only work on
> unassigned/invalid assigned BARs. and hpmem_size will be only treated at
> optional size even on hotplug slots.

Does this mean the only time the kernel will re-allocate the BARs and
use hpmemsize is if they have the value 0x0? If so, does realloc have
any limitations with respect to where in the tree the invalid BAR
exists? In my example, could realloc fix 80:03.0? 9b:15.0?

> a5:00.0 is not in 9b:15.0 at first, so yo just put the card in can
> rescan the card,
> right?

Correct. I did an echo 1 > /sys/bus/pci/rescan

> In this case we don't to realloc, as other devices could already have
> driver loaded.

I can understand why this is true after the PCI subsystem is up and
running, but at boot time, before any other drivers have loaded,
wouldn't it be possible for the PCI driver to honor realloc and
hpmemsize and override the values written by the BIOS? This way,
devices added later would have memory available for their BARs.

> You need to fix the BIOS to have correct setting for 96:1b.0.
>
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> HotPlug- Surprise-
>                         Slot #21, PowerLimit 25.000W; Interlock- NoCompl-
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
> CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown,
> Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> PresDet+ Interlock-
>                         Changed: MRL- PresDet+ LinkState+
>
> to make it really hotplug slot.

Agreed. The slot actually is hot plug capable, and I was considering
adding a quirk and then using hpmemsize to provide enough resources
for devices. But given your description, it sounds like this won't
work.

> And BIOS need to make sure parent bus/bridge have enough resource ranges
> for the hotplug slots.
>
> Yinghai

If the BIOS doesn't allocate enough memory mapped IO resources for
devices, it sounds like the kernel can't really fix this problem,
right?

--chuck
