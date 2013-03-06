Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:57550 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3CFVcl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 16:32:41 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so3901356obc.26
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2013 13:32:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <51371AD9.4040801@fold.natur.cuni.cz>
References: <50EDF8FE.6040607@fold.natur.cuni.cz> <CAErSpo6etF7_fZH9nNoAhtRXdGEmBrNE7v84TRkoawyG9s4AGw@mail.gmail.com>
 <51371AD9.4040801@fold.natur.cuni.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 6 Mar 2013 14:32:20 -0700
Message-ID: <CAErSpo5wmM8+Qd4FH0WeNS_DJEk2Tmmivk-FgEbD-UbTMQf+ZQ@mail.gmail.com>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Sarah because problem only seems to happen with xhci.  I'm
assuming this is a pciehp issue for now]

On Wed, Mar 6, 2013 at 3:30 AM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Hi Bjorn,
>   thank you for your time on this issue.
>
> Bjorn Helgaas wrote:
>> On Wed, Jan 9, 2013 at 4:10 PM, Martin Mokrejs
>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>> Hi,
>>>   I am following up on a former thread
>>> Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
>>> about the same issue. I think I found some new info while playing with 3.7.1 kernel.
>>> It happened to me that my hotplug of express cards stopped working so it made me to
>>> to dive in a figure out what driver did I do to my .config, and what combinations
>>> of drivers and kernel command-line parameters work and which not. This email will
>>> cover just one case.
>>>
>>> On this Dell Vostro 3550 express card slot works if kernel is without pciehp
>>> altogether and pci_hotplug+acpiphp are loaded as modules later on. The problem
>>> is that I must use pcie_aspm=off.
>>
>> I confess I am completely bewildered here.  Something is clearly badly
>> broken, but I'm having a hard time figuring out exactly what it is.  I
>> think I'm overwhelmed by all the data :)
>>
>>>From your previous "3.2.11: PCI Express card cannot be re-detected
>> withing cca 60sec timeframe" thread, I think:
>>
>> 1) With pciehp, insertion and removal of an NEC uPD720200 USB3.0 card
>> doesn't work correctly [1].  The insertion/removal events don't seem
>> to be detected immediately.
>
> ... except for the FireWire, serial/parallel and eSATA port-providing cards in 2) and 3).
> The one doing SATA is based on Silicon Image3132 chip, using sata_sil24
> driver.
>
>> 2) Insertion/removal of firewire card works correctly [2]
>
> Yes.
>
>> 3) Insertion/removal of AXAGO ECA-SP serial/parallel card works correctly [3]
>
> Yes.
>
>> 4) When the xhci driver is not loaded, insertion/removal events of the
>> NEC USB3.0 card *are* detected correctly [4]
>
> And my suspicion was that when a USB device is attached to the
> ExpressCard USB3.0 controller the "usb-storage?" or whichever driver"
> realizes much earlier (in time) that the ExpressCard is gone and system thus
> behaves properly. I think something is delayed by xhci driver until a poll
> happens after every 60 seconds. With usb-storage the change gets visible
> "immediately".

I'm going to ignore this speculation about xhci and other drivers for
now and see if we can just get pciehp to work.  We need to reduce the
number of variables here.

I opened https://bugzilla.kernel.org/show_bug.cgi?id=54921
"pciehp/xhci ExpressCard failure on Dell Vostro 3550" for this issue.

> Or, the card is not PCI or PCIe hotplug capable [6]?
> Could that be the difference in behior?

All ExpressCards should support hotplug.  The hotplug support is in
the root port and other circuitry on the motherboard.

>> But I think it's a bad idea to go down the road of using acpiphp.
>
> Unfortunately I was forced to switch to acpiphp because commit
> 0d52f54e2ef64c189dedc332e680b2eb4a34590a (as diagnosed by Yinghai)
> becuase pciehp stopped working (although it worked badly anyways).

I understand you have to use acpiphp to make things work right now.
But I think we can make pciehp work, and I think that's what distros
will want to use in this situation, so that's what I want to debug.

As background for the whole collection of hotplug drivers we have,
here's my understanding of the history:

1) Originally there was no standard for PCI hotplug hardware, and we
have drivers like cpqphp, ibmphp, etc. to deal with various hardware
designs.

2) ACPI defined an abstract hotplug model so an OS can have a single
driver, e.g., acpiphp, for that model, and the BIOS can map the
abstract model to various hardware designs.

3) PCIe defined a single hardware model, so an OS can have a single
driver, e.g., pciehp.  ACPI is not really involved here except that
the OS has to ask the BIOS for permission to use this native hotplug
driver.

Many machines, including yours, support both ACPI (acpiphp) and PCIe
native (pciehp) hotplug so they can run both old OSes that don't have
pciehp, and newer OSes that prefer to use pciehp.

> Yighai in the 3.2.x thread postulated it is a BIOS or silicon bug
> incorrectly providing PresDet status. I was glad that I can show
> that with acpiphp the PresDet is *always* correct (3.7. kernel)
> *provided* I disabled MediaCard reader in BIOS.

Can you build a v3.9-rc1 kernel with this config:

  CONFIG_HOTPLUG_PCI_PCIE=y
  CONFIG_HOTPLUG_PCI_ACPI=n
  CONFIG_USB_XHCI_HCD=n

I want to use pciehp, not acpiphp, and leave the xhci driver out of
the picture for now.  Boot it with pciehp.pciehp_debug=1 and the
ExpressCard slot empty, and run this command:

  # while true; do echo -n "$(date +%T) SlotStatus "; setpci -s1c.7
0x5a.w; sleep 1; done

That command reads the SlotStatus register from the bridge leading to
your ExpressCard slot every second.  While that command is running, do
insertions and removals of all your ExpressCards.  Bit 6 (0x0040) is
the Presence Detect bit.  It should change as you insert and remove
cards.

I'd like to see the complete dmesg log, the output of "lspci -vv", and
the output of the above command while you insert/remove cards (with
notes about which card is being hotplugged when).  Since there seems
to be some interaction with the MediaCard reader BIOS settings, maybe
you could do this whole experiment with the reader disabled, then with
it enabled.

You can attach these logs to the bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=54921) if you want, or
point me to them and I'll do it.

Thanks,
  Bjorn
