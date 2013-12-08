Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:55947 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab3LHEzS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 23:55:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAE9FiQV_3SfigDfJuAoP4nX-q2qNR=Vd=YuQ3bE7Ur+WVM7hwg@mail.gmail.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
	<CAE9FiQV_3SfigDfJuAoP4nX-q2qNR=Vd=YuQ3bE7Ur+WVM7hwg@mail.gmail.com>
Date: Sun, 8 Dec 2013 12:55:17 +0800
Message-ID: <CABawtvPCf5LBd2j4hHv4iZRTzo4D3HU7vU+nveYOw4sBeoANeA@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
From: Ethan Zhao <ethan.kernel@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 8, 2013 at 11:19 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sat, Dec 7, 2013 at 10:35 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> This doesn't sound like a chipset bug.  It sounds like exactly what
>> the spec describes: "Presence Detect State – This bit indicates the
>> presence of an adapter in the slot, reflected by the logical “OR” of
>> the Physical Layer in-band presence detect mechanism and, if present,
>> any out-of-band presence detect mechanism defined for the slot’s
>> corresponding form factor" (PCIe 3.0, sec 7.8.11).
>
> Not sure. the silicon does not report in-band correctly if we turn off
> pcie link before turn the power of card.
>

Obvious there are both in-band and out-of band present detect
mechanism on Yinghai's test platform:

> case 1:
> a. disable pci link
> b. turn off power of pci cards

in-band-present = should be 'off ', but still 'on'
the hardware/FPGA of Yinghai's test platform has special temper here,
it couldn't set in-band-present right if disable pci link first.
but other platform could work well when commit 2debd9289997 applied ?
non report that.

> c. Present bit: card present.
> d. remove the card.

out-band-present = off

present = n-band-present  | out-band-present
                 on | off
               = on
not work well.
> e. Present bit: card is present.
>
> case 2:
> a. turn off power of pci cards
> b. disable pci link

in-band-present = off
works well

> c. Present bit: card present.
> d. remove the card.

out-band-present = off

> e. Present bit: card is NOT present.

present = n-band-present  | out-band-present
                 off | off
              = off
works well.
>
> case 3:
> a. disable pci link
> b. turn off power of pci cards

in-band-present = should be 'off' , but still 'on'

> c. Present bit: card present.
> d. turn on pcie link
> e. wait 20ms

in-band-present = on ?

> f. turn off pcie link
in-band-present = off ?
> g. remove the card.
 out-band-present = off

present = in-band-present  | out-band-present = off

It seems,  Yinghai's hardware logic that sets present bit with in-band
OR out-band detection has special nature, it coundn't see power_off
command and set in-band-present right if you disable link first.  and
it works well with original code path shown by case 2.

if so, we should revert 2debd9289997 and workaround the AER flood with
AER mask bit somewhere instead of play such trick in generic code.
because of the original code could work on both this 'buggy'
flatform  and others.  and these workaround just make the code hard to
understand and far away from simple and generic.

just my 2 cents, of coz, you could ignore it wildly.

Thanks,
Ethan

> h. Present bit: card is NOT present.
>
>>
>> So I want to fix this pciehp problem, but between 2debd9289997 and
>> this patch, pciehp_power_off_slot() is accumulating warts that make it
>> look like we're just reacting to things that break rather than making
>> a robust design to start with.
>
> We have 2debd9289997 (turn off link before turn off power) to avoid
> some AER ....
>
> with this patch we still keep that and link off
> also have presence detect work correctly.
>
> Yinghai
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
