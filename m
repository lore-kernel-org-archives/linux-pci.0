Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:52956 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbaGTXtN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Jul 2014 19:49:13 -0400
Received: by mail-oa0-f45.google.com with SMTP id i7so6470181oag.32
        for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2014 16:49:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFJTrDtvbnY+-bLySWyOBYtbsujSf+E-wpb=FtAptZvquxzKuA@mail.gmail.com>
References: <CAFJTrDt146269JkQ7eRcgGxk=4EEQ2XK+Rbe11Y+6URr=LQzrA@mail.gmail.com>
 <20140716220046.GD14366@google.com> <CAFJTrDtvbnY+-bLySWyOBYtbsujSf+E-wpb=FtAptZvquxzKuA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 20 Jul 2014 17:41:26 -0600
Message-ID: <CAErSpo4A_71Lqnb_xCU3ddHmpD-iPdOAYTSO36d8KiEyf_5J2Q@mail.gmail.com>
Subject: Re: [PATCH RFC] Added code to ensure hot-added PCI devices are given
 an IRQ on rescan
To: Matthew Minter <matthew_minter@xyratex.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 17, 2014 at 4:54 AM, Matthew Minter
<matthew_minter@xyratex.com> wrote:
> On 16 July 2014 23:00, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> This is a tangent, but I'm curious about this part of the hotplug
>> process.  Since this is PCIe, I assume the switch leading to the 8639
>> connector supports hotplug and the pciehp driver would be involved.
>> Why doesn't it notice the device addition and handle it automatically?
>> You shouldn't have to do anything with /sys/bus/pci/rescan.
>
> That is a good question and possibly exposes some of the background here.
>
> 8639 connectors do not require hot-plug support from PCIe layer at
> all. This is because the hot-plug does not rely on the power to the
> port being shut down first. They have a power connector based on a
> modified SATA power connector including the staged power pins and such
> can be surprised hot-(un)plugged without consequence (of course the
> file-systems should be unmounted and ideally the driver stopped
> first).

This is basically the way ExpressCard works.  We use pciehp for
ExpressCard, and it likely would work for you, too.

> Having said that, this has the additional implication that this form
> of hot-plug works on architectures which seem to have no PCIe hot-plug
> support such as ARM. On the board we have here (based on an ARM server
> chip-set) the PCIe switch we are using supports resource
> pre-allocation for hot-adding but does not support power control or
> plug/unplug interrupts but this is fine again as the connectors are
> all physically hot-plug safe.

The hotplug drivers are generally architecture-independent.  I haven't
exercised pciehp on ARM, but it should work.

I assume this:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/202371.html

is your system, and the Downstream Ports on bus 03 lead to the 8639
connectors.  These ports claim to support hotplug, e.g.,

        SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise-
            Slot #1, PowerLimit 25.000W; Interlock+ NoCompl-

so pciehp should claim these slots and should notice device addition
and removal.

> I was concerned myself about using hot-plug without a hot-plug driver
> but the guys on the arm kernel mailing list confirmed that this was
> normal and should be fine. Thus we have taken a system for hot adding
> where we just connect the device to a pre-allocated resource port and
> the run rescan. To hot-swap a device we unmount it's file-systems,
> stop it's driver where possible, remove it using
> /sys/bus/pci/devices/xxxx/remove then follow the hot-add procedure
> above to install it's replacement. (note in our case the devices are
> storage devices but this could apply equally to any peripheral).

Sure, you *can* use /sys/bus/pci/rescan, but you shouldn't have to.
That basically exists as a workaround for various inadequacies in
Linux PCI.

> Hopefully this explains the situation a little. Please note however,
> this applies to a wider issue, any system where there is no BIOS/BIOS
> like object/ACPI to map irqs to unused slots (or if the firmware is
> buggy and will not do so) currently has no way to allocate an irq to
> those slots later should a device become connected to them. It does
> not seem correct that this code should be reserved only to boot time
> and would seem beneficial to have routines to do this later.
>
>> pci_fixup_irqs() has been broken from the beginning because it is only
>> done for devices present at boot-time, and nothing happens for
>> hot-added devices.
>>
>> I think you're on the right path by looking at the generic
>> pci_bus_add_device() path that is used both at boot-time and hot
>> add-time.  I would like to see something that works the same way at
>> both times and gets rid of pci_fixup_irqs() altogether.
>>
>> I'm not sure this needs to be done as early as pci_bus_add_device();
>> it could probably be done somewhere in the pci_enable_device() path,
>> since drivers can't use interrupts before that anyway.
>>
>> Bjorn
>
> It should be entirely possible to factor out pci_fixup_irqs
> completely, it seems most of the calls to it are in the virtual PCI
> BIOSes of platforms which have no BIOS, I agree it would be far neater
> to avoid the platform independent code as far as possible and unify
> PCI irqs into a single place.
>
> If it is OK with you I would like to rework the patch-set so that that
> instead of the boot time PCI code assigning the irqs it can instead
> register an irq swizzling and an irq mapping function (which would
> probably be stored either in the pci_host_bridge struct) or a default
> could be used. Thich can then be called during the drvice-add code
> path to both fix hot-plug irqs and unify the infrastructure a little
> so it relies less on platform code. This registration could be done in
> pcibios_root_bridge_prepare (as this can be overridden by each arch).

That seems reasonable.

> I might be way off here but if that is the sort of thing you were
> looking for I can certainly begin working on a new patch-set however I
> also have a  question which is possibly on a bit of a tangent, the
> pci_assign_unassigned_resources function seems to be called in every
> PCI supporting arch yet the function is still called from the arch
> specific code, is there reason for this?

No.  It's only in the arch code because hotplug has been added on
afterwards, and it's not very well integrated yet.  It should be done
in the core.  But it's not trivial to fix, because some arches have
ordering dependencies.  For example, on x86, we enumerate PCI devices,
then ACPI devices, then we assign unassigned PCI resources.  We can't
assign those PCI resources without knowledge of what the ACPI devices
use, of course.  The sensible order would be to enumerate ACPI devices
first, then PCI (since the PCI host bridges themselves are ACPI
devices), but again, there's lots of historical baggage that makes it
hard to clean this up.

I'm going to be on vacation for a few weeks, but I would love to hear
about any issues you find with using pciehp on ARM.

Bjorn
