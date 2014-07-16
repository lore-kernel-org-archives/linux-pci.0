Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:41174 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbaGPXtC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 19:49:02 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so5040083igb.14
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 16:49:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQW+GbprQZNvHC-ek1cSydP3KWcjgAU0ii5_jECC1+tXrg@mail.gmail.com>
References: <CAKAYmMLfxkmaVxaPDd6z=B0ESQ3mR=dUG4OFFgEoy0295qLYgg@mail.gmail.com>
	<CAKAYmMLhPhukBbR8NhPk3EigmvwiX+DEGj-Mod7zpHMnZKRsLw@mail.gmail.com>
	<CAErSpo7vooChRfSF6oY8GcqVYZruv-7_D0zm3a4M_KDVMbWNiA@mail.gmail.com>
	<CAE9FiQWomktcpSHeFwxWBLXmAsbdXEHv6sOrNXodobkBw=mRKA@mail.gmail.com>
	<CAE9FiQW+GbprQZNvHC-ek1cSydP3KWcjgAU0ii5_jECC1+tXrg@mail.gmail.com>
Date: Wed, 16 Jul 2014 16:49:01 -0700
Message-ID: <CAE9FiQX9p-nTGeRo365d9m10OXF9-QqUJ+4z6GD37ztd+s8EEQ@mail.gmail.com>
Subject: Re: Error assigning BAR 0 to hotplugged device
From: Yinghai Lu <yinghai@kernel.org>
To: Chuck Tuffli <ctuffli@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 16, 2014 at 4:47 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jul 16, 2014 at 1:55 PM, Yinghai Lu <yinghai@kernel.org> wrote:

>
> in the tree:
>    80:03.0 ==> 96:00.0 ==> 97:08.0 ==> 98:00.0 ==> 99:00.0 ==> 9a:00.0
> ==> 9b:15.0
>
> only 97:08.0 and 99:00.0 is hotplug+.
>
> and kernel will honor BIOS set value at first, and realloc will only work on
> unassigned/invalid assigned BARs. and hpmem_size will be only treated at
> optional size even on hotplug slots.
>
> a5:00.0 is not in 9b:15.0 at first, so yo just put the card in can
> rescan the card,
> right?
>
> In this case we don't to realloc, as other devices could already have
> driver loaded.
>
> You need to fix the BIOS to have correct setting for 96:1b.0.

should 9b:15.0

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
>
> And BIOS need to make sure parent bus/bridge have enough resource ranges
> for the hotplug slots.
>
> Yinghai
