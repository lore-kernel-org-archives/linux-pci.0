Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58205 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3LHGEX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Dec 2013 01:04:23 -0500
MIME-Version: 1.0
In-Reply-To: <CABawtvPCf5LBd2j4hHv4iZRTzo4D3HU7vU+nveYOw4sBeoANeA@mail.gmail.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
	<CAE9FiQV_3SfigDfJuAoP4nX-q2qNR=Vd=YuQ3bE7Ur+WVM7hwg@mail.gmail.com>
	<CABawtvPCf5LBd2j4hHv4iZRTzo4D3HU7vU+nveYOw4sBeoANeA@mail.gmail.com>
Date: Sat, 7 Dec 2013 22:04:22 -0800
Message-ID: <CAE9FiQXxwzyXffALDDrm4F=9KovfywoqgtJPkn8UzrPzSLZcwg@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
From: Yinghai Lu <yinghai@kernel.org>
To: Ethan Zhao <ethan.kernel@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 7, 2013 at 8:55 PM, Ethan Zhao <ethan.kernel@gmail.com> wrote:
> On Sun, Dec 8, 2013 at 11:19 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Sat, Dec 7, 2013 at 10:35 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>
>>> This doesn't sound like a chipset bug.  It sounds like exactly what
>>> the spec describes: "Presence Detect State – This bit indicates the
>>> presence of an adapter in the slot, reflected by the logical “OR” of
>>> the Physical Layer in-band presence detect mechanism and, if present,
>>> any out-of-band presence detect mechanism defined for the slot’s
>>> corresponding form factor" (PCIe 3.0, sec 7.8.11).
>>
>> Not sure. the silicon does not report in-band correctly if we turn off
>> pcie link before turn the power of card.
>>
>
> Obvious there are both in-band and out-of band present detect
> mechanism on Yinghai's test platform:
>
>> case 1:
>> a. disable pci link
>> b. turn off power of pci cards
>
> in-band-present = should be 'off ', but still 'on'
> the hardware/FPGA of Yinghai's test platform has special temper here,
> it couldn't set in-band-present right if disable pci link first.
> but other platform could work well when commit 2debd9289997 applied ?
> non report that.

It happens on all intel platform from nehalem, westmere, sandybridge,
and ivybridge.

If the users are careful enough then they would find the presence is
still set even after
card is removed.

but hotadd back later is still working, as attention button pressing
will still generate interrupt,..

>
>> c. Present bit: card present.
>> d. remove the card.
>
> out-band-present = off
>
> present = n-band-present  | out-band-present
>                  on | off
>                = on
> not work well.
>> e. Present bit: card is present.
>>
>> case 2:
>> a. turn off power of pci cards
>> b. disable pci link
>
> in-band-present = off
> works well
>
>> c. Present bit: card present.
>> d. remove the card.
>
> out-band-present = off
>
>> e. Present bit: card is NOT present.
>
> present = n-band-present  | out-band-present
>                  off | off
>               = off
> works well.

We can not check in-band presence directly.

We only can check result after "OR", and out-band presence.
and out-band presence from FPGA always report correctly.

Yinghai
