Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60700 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699Ab3CIDv3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2013 22:51:29 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so1876286obc.19
        for <linux-pci@vger.kernel.org>; Fri, 08 Mar 2013 19:51:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <51394317.20104@fold.natur.cuni.cz>
References: <50EDF8FE.6040607@fold.natur.cuni.cz> <CAErSpo6etF7_fZH9nNoAhtRXdGEmBrNE7v84TRkoawyG9s4AGw@mail.gmail.com>
 <51371AD9.4040801@fold.natur.cuni.cz> <CAErSpo5wmM8+Qd4FH0WeNS_DJEk2Tmmivk-FgEbD-UbTMQf+ZQ@mail.gmail.com>
 <51394317.20104@fold.natur.cuni.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 8 Mar 2013 20:51:08 -0700
Message-ID: <CAErSpo7wsduVN1Q6k_D7r24AhpVcARZRXtv6FvSfMMjFNJMcRA@mail.gmail.com>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 7, 2013 at 6:47 PM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Bjorn Helgaas wrote:
>> On Wed, Mar 6, 2013 at 3:30 AM, Martin Mokrejs
>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>> Bjorn Helgaas wrote:
>>>> On Wed, Jan 9, 2013 at 4:10 PM, Martin Mokrejs
>>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>>>   I am following up on a former thread
>>>>> Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
>>>>> about the same issue. I think I found some new info while playing with 3.7.1 kernel.
>>>>> It happened to me that my hotplug of express cards stopped working so it made me to
>>>>> to dive in a figure out what driver did I do to my .config, and what combinations
>>>>> of drivers and kernel command-line parameters work and which not. This email will
>>>>> cover just one case.
>>>>>
>>>>> On this Dell Vostro 3550 express card slot works if kernel is without pciehp
>>>>> altogether and pci_hotplug+acpiphp are loaded as modules later on. The problem
>>>>> is that I must use pcie_aspm=off.
>>>>
>>>> I confess I am completely bewildered here.  Something is clearly badly
>>>> broken, but I'm having a hard time figuring out exactly what it is.  I
>>>> think I'm overwhelmed by all the data :)
>
> It won't be easier now but you asked for it. ;)

Well, I didn't really ask for 500kB of logs with 150-character
pathnames.  I am unable to process that much stuff.  I'm not
interested in random lspci differences, virtual console bugs, or OHCI
driver crashes at this point, so let's not muddy the waters with them.
 I only want to figure out if pciehp can correctly detect and
enumerate a newly inserted card, and if it can correctly clean up when
a card is removed.  After we figure that out, we can worry about more
complicated issues.

I *think* the bottom line of the Slot Status experiment is that the
Presence Detect bit was reported correctly in every case, for every
card, regardless of BIOS settings.  Right?

There are three cards on the table now:

  pci 0000:11:00.0: [1095:3132] SiI 3132 Serial ATA Raid II Controller
  pci 0000:11:00.0: [1106:3403] VT6315 Series Firewire Controller
  pci 0000:11:00.0: [1033:0194] NEC Corporation uPD720200 USB 3.0 Host
Controller

I assume all the cards work fine if there's no hotplug, i.e., if the
card is present at boot and you never remove it.  Right?

> In Linux pciehp
> still complains about Surprise Removal even when I insert the card for the very
> first time after a coldboot

Hmm.  pciehp prints "Surprise Removal" whether you inserted or removed
the card.  Stupid driver.

> (so the ExpressCard slot is not completely dead but
> neither sata_sil24 nor fw_ohci picks up the device).

I thought the only card with a problem was the USB3.0 card.  But here
you suggest that there *is* a problem with the SATA and Firewire
cards.  Can you describe that problem in one sentence?

> My question is. Has the laptop hardwired the ExpressCard slot somehow through USB
> to the SandyBridge chip?

An ExpressCard slot (spec at [1]) supports both a PCIe interface and a
USB interface, so the slot *should* be connected to a USB controller
as well as to a PCIe root port.  An ExpressCard can contain either a
PCIe device or a USB device or both.  Section 6.3 of the spec talks
about ACPI requirements to describe the relationship between the PCIe
and USB devices.  I'm not sure that Linux pays any attention to this
in the hotplug paths, so I'm a little worried about this.  (Maybe it
doesn't need to in the PCIe-aware case; I don't know.)

It would be interesting to know exactly what devices are on your
cards.  Assuming they all work when present at boot, you could find
that by doing a single "lspci -vv" and "lsusb -v" after a boot with an
empty slot, and doing it again after a boot with a card in the slot.
The difference should be the ExpressCard devices.  I'm sure this is
buried in your tarball somewhere, but all I want is the info from a
machine in default configuration -- MediaCard enabled, etc.  Just the
way a typical user would be using the machine.

[1] http://www.usb.org/developers/expresscard/EC_specifications/ExpressCard_2_0_FINAL.pdf

> The hotplug issue itself. I do not understand the PCI(e) hotplug, lspci output but
> why is there any difference between a cold booted status of an empty expresscard slot
> compared to the status when a card is unloaded?

In principle there shouldn't be any difference, but Linux isn't that good yet.

> --- without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/lspci_vv_initial.txt   2013-03-07 22:27:30.000000000 +0100
> +++ without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/lspci_vv_unloading_USB3_card.txt       2013-03-07

> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>
> Shouldn't the MAbort been cleared sometimes? Doesn't this fool the PresDet interpretation in kernel?

I doubt it.  Presence Detect is a very simple mechanism that basically
just reports the current state of the CPPE# signal in the ExpressCard
slot.  There's no reason this should be related to MAbort.

> The eSATA behaves differently maybe because 0100 does not change to 0140 like USB3 card but to 0103?
> Um, the shell while loop calling setpci does not report 0103 but the driver say this:
>
> [  211.879397] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)

This is completely unrelated.  The shell "setpci" command is printing
the Slot Status register; the "0100 -> 0103" above is a change in the
PCI Command register.

> I do not remember with 3.2.x and 3.7x kernels seeing this with the USB3 card:
> +[  594.622211] pci 0000:11:00.0: calling quirk_usb_early_handoff+0x0/0x657
> +[  594.622223] pci 0000:11:00.0: device not available (can't reserve [mem 0x00000000-0x00001fff 64bit])
> +[  594.622225] pci 0000:11:00.0: Can't enable PCI device, BIOS handoff failed.

This is a result of trying to run the quirk on a hot-inserted device
where we haven't assigned resources to it yet.  I don't think we
should really be running quirks on a device that early.  We can look
at that later, if we think this is related to the immediate problem.

Bjorn
