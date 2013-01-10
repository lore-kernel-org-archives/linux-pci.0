Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:36526 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757821Ab3AJCE3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 21:04:29 -0500
Message-ID: <50EE21AA.2090004@fold.natur.cuni.cz>
Date: Thu, 10 Jan 2013 03:04:26 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
References: <50EDF8FE.6040607@fold.natur.cuni.cz> <CAE9FiQXoEWifAoJQ9-aROBo3KJDcMGPb-5+PH=GiD2PD1Ze9bw@mail.gmail.com>
In-Reply-To: <CAE9FiQXoEWifAoJQ9-aROBo3KJDcMGPb-5+PH=GiD2PD1Ze9bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,
  thank you for you answer, it is way too late here but a quick answer ...

Yinghai Lu wrote:
> On Wed, Jan 9, 2013 at 3:10 PM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>> - pci0000:00: Requesting ACPI _OSC control (0x1d)
>> - pci0000:00: ACPI _OSC control (0x19) granted
>> + pci0000:00: Unable to request _OSC control (_OSC support mask: 0x19)
> 
> according to _OSC related game in acpi_pci_root_add()
> it will query_osc_support with flags |=
>                                 OSC_EXT_PCI_CONFIG_SUPPORT \
>                                 | OSC_ACTIVE_STATE_PWR_SUPPORT \
>                                 | OSC_CLOCK_PWR_CAPABILITY_SUPPORT \
>                                 | OSC_MSI_SUPPORT
> and the firmware should not return ACPI FAILURE, and if it return
> failure, flags will get reset.
> 
> then if and only if flags keep there five bits, kernel will try to set control
> to _OSC for
>                         OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
>                         | OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
>                         | OSC_PCI_EXPRESS_PME_CONTROL;
> and may be AER.
> 
> that will let pciehp own the device <pciehp will claim that later...>
> 
> in acpiphp there is module that will check if port is owned by pciehp,
> and it will bail out early.
> in device_is_managed_by_native_pciehp...
> 
> pcie_aspm=off will stop all _osc setting, like pciehp, pme and aer.
> 
> the checking in acpiphp is introduced by:
> commit 0d52f54e2ef64c189dedc332e680b2eb4a34590a
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Sat Oct 22 00:43:38 2011 +0200
> 
>     PCI / ACPI: Make acpiphp ignore root bridges using PCIe native hotplug
> 
> so it is a regression.

It is true that since the time around 3.3.x when I reported the problem I had in
grub.conf kept pcie_aspm=force. And as I fiddled with .config now for 3.7.1 the
hotplug stopped working. Sure, because I used pciehp so far, now we know. ;-) Only
now I realized that if I switch to acpiphp, the 'Surprise removal' message is gone
(acpiphp maybe does not even try to print something similar to it?). But as you see,
I convinced myself the BIOS/hardware is correct and does change PresDet properly
under acpiphp. But in one case I saw a change between two seemingly same states,
when in lspci output a difference was in "BadDLLP", whatever that is. Just in case
you come across that in the diff output. I wish I could prove with contents that
the builtin EHCI on the C6/C200 chip interferes with the express card slot and the
card reader. That was the reason why I disabled the CardReader in BIOS, because
from the diffs you can see the card reader was detected only after I plugged in
an express card. I speculate this could be also why the PresDet behaves differently
with various express cards.

> 
> Rafael,
> 
> can you fix that? otherwise user will have specify weird
> "pcie_aspm=off" to make acpiphp working.
> 
> looks like we need to have other way to do handshaking between pciehp
> and acpiphp.

I am pushing now out the collected files. I am terribly slow in making up the other bug
reports. I sent out already those bugs reported by kmemleak but there were other crashes.
So, if you have the time; do something along:


wget 195.113.57.32/~mmokrejs/tmp/PCIe_hotplug_scenarios.tar.bz2
unpack
ls -latr foo
ls -latr bar

The names of directories are long/ugly but should be clear also to you what I did.

for f in dmesg.notiming lspci_vvxx interrupts; do diff -u -w foo/$f bar/$f | less; done

You will see that when I enabled pciehp (dirnames with HOTPLUG_PCI_PCIE in the name)
the PresDet+ is not changed to PresDet- when a card is removed. But it differs what card
was removed. This seems to be broken only for the USB3 card based on the NEC chip.
It looks the PresDet issue does NOT happen for OHCI firewire card, nor PL2303 based
serial card (for the Prolific I did not collect the data).

Well, if you don't have time I will poke through during next days. But you might be faster
in interpreting the diffs. Just follow the directory timestamps to have least diff
output. Compare states when a slot was with a card plugged in together. Similarly
look for those dirnames which end with "card_unplugged" to see whether the PresDet and
were all set to minus.
Oh, yeah, I think with 3.[34] kernel series the PresDet on the "Changed:" line
from lspci did not follow the actual change, inferable from the SltSta line
(thread "linux-3.4-rc5: eSATA Sil3132 ExpressCard removal results in warn_slowpath_common").
Not sure if it still happens with 3.7.1, you will see. ;-)

Finally, I have no idea what was changed in the new BIOS release, now I have A11, previously
had A9 and A10. I did not observe any fix in that but as I was using the pciehp module
maybe I could not even realize PresDet is working now. But why not for all cards, thats is
still unclear.

Cheers,
Martin
