Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63975 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab3LHDTo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 22:19:44 -0500
MIME-Version: 1.0
In-Reply-To: <CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
Date: Sat, 7 Dec 2013 19:19:43 -0800
Message-ID: <CAE9FiQV_3SfigDfJuAoP4nX-q2qNR=Vd=YuQ3bE7Ur+WVM7hwg@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 7, 2013 at 10:35 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> This doesn't sound like a chipset bug.  It sounds like exactly what
> the spec describes: "Presence Detect State – This bit indicates the
> presence of an adapter in the slot, reflected by the logical “OR” of
> the Physical Layer in-band presence detect mechanism and, if present,
> any out-of-band presence detect mechanism defined for the slot’s
> corresponding form factor" (PCIe 3.0, sec 7.8.11).

Not sure. the silicon does not report in-band correctly if we turn off
pcie link before turn the power of card.

case 1:
a. disable pci link
b. turn off power of pci cards
c. Present bit: card present.
d. remove the card.
e. Present bit: card is present.

case 2:
a. turn off power of pci cards
b. disable pci link
c. Present bit: card present.
d. remove the card.
e. Present bit: card is NOT present.

case 3:
a. disable pci link
b. turn off power of pci cards
c. Present bit: card present.
d. turn on pcie link
e. wait 20ms
f. turn off pcie link
g. remove the card.
h. Present bit: card is NOT present.

>
> So I want to fix this pciehp problem, but between 2debd9289997 and
> this patch, pciehp_power_off_slot() is accumulating warts that make it
> look like we're just reacting to things that break rather than making
> a robust design to start with.

We have 2debd9289997 (turn off link before turn off power) to avoid
some AER ....

with this patch we still keep that and link off
also have presence detect work correctly.

Yinghai
