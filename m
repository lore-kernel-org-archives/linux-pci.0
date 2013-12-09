Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63836 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710Ab3LISeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 13:34:17 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so6819194ief.10
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 10:34:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQV_3SfigDfJuAoP4nX-q2qNR=Vd=YuQ3bE7Ur+WVM7hwg@mail.gmail.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
 <CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com> <CAE9FiQV_3SfigDfJuAoP4nX-q2qNR=Vd=YuQ3bE7Ur+WVM7hwg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Dec 2013 11:33:54 -0700
Message-ID: <CAErSpo401m4e4vPhrMmy6f6nPoiVnKrYqGegY-S7V7xTNf25Eg@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 7, 2013 at 8:19 PM, Yinghai Lu <yinghai@kernel.org> wrote:
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

Yes, that's exactly what the spec says: "Note that the in-band
presence detect mechanism requires that power be applied to an adapter
for its presence to be detected."  So pciehp has to be designed to
take that into account.

Presence detect is obviously important for things like ExpressCard
where there's no attention button.  I expect that pciehp will use
presence detect to notice when a device is inserted and removed.

But I assume your hotplug situation is slots with attention buttons,
and I don't think presence detect is as important there.  If you
insert a card into an empty slot, nothing should happen until the
attention button is pressed.  We don't need presence detect there.  If
pciehp turns off a device to prepare for its physical removal, why do
we care about presence detect after the power is turned off?  I think
all pciehp can say is "this slot is powered off, and I don't know
whether there's still a card in it."

I think pciehp is somewhat buggy here -- it looks like
pciehp_enable_slot() looks at presence detect before turning on the
power.  I don't know why it does that, and it doesn't seem valid per
the spec statement I quoted above.

Bjorn
