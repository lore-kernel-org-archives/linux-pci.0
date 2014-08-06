Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:47355 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbaHFQA0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 12:00:26 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so3073955igc.12
        for <linux-pci@vger.kernel.org>; Wed, 06 Aug 2014 09:00:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4A_71Lqnb_xCU3ddHmpD-iPdOAYTSO36d8KiEyf_5J2Q@mail.gmail.com>
References: <CAFJTrDt146269JkQ7eRcgGxk=4EEQ2XK+Rbe11Y+6URr=LQzrA@mail.gmail.com>
	<20140716220046.GD14366@google.com>
	<CAFJTrDtvbnY+-bLySWyOBYtbsujSf+E-wpb=FtAptZvquxzKuA@mail.gmail.com>
	<CAErSpo4A_71Lqnb_xCU3ddHmpD-iPdOAYTSO36d8KiEyf_5J2Q@mail.gmail.com>
Date: Wed, 6 Aug 2014 17:00:25 +0100
Message-ID: <CAFJTrDunHPoba3UXjYE3L8UHrycqScojyzL=_xoALJcK9oxCbA@mail.gmail.com>
Subject: Re: [PATCH RFC] Added code to ensure hot-added PCI devices are given
 an IRQ on rescan
From: Matthew Minter <matthew_minter@xyratex.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> This is basically the way ExpressCard works.  We use pciehp for
> ExpressCard, and it likely would work for you, too.
>
>> Having said that, this has the additional implication that this form
>> of hot-plug works on architectures which seem to have no PCIe hot-plug
>> support such as ARM. On the board we have here (based on an ARM server
>> chip-set) the PCIe switch we are using supports resource
>> pre-allocation for hot-adding but does not support power control or
>> plug/unplug interrupts but this is fine again as the connectors are
>> all physically hot-plug safe.
>
> The hotplug drivers are generally architecture-independent.  I haven't
> exercised pciehp on ARM, but it should work.
>
> I assume this:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/202371.html
>
> is your system, and the Downstream Ports on bus 03 lead to the 8639
> connectors.  These ports claim to support hotplug, e.g.,
>
>         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise-
>             Slot #1, PowerLimit 25.000W; Interlock+ NoCompl-
>
> so pciehp should claim these slots and should notice device addition
> and removal.
>
> Sure, you *can* use /sys/bus/pci/rescan, but you shouldn't have to.
> That basically exists as a workaround for various inadequacies in
> Linux PCI.

It appears that the HOTPLUG_PCI option has not been added to the
arch/arm/Kconfig file, thus making it hidden in the configuration tools.

This can simply be fixed as so:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b..cab167f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1369,6 +1369,7 @@ config PCI_HOST_ITE8152
        select DMABOUNCE

 source "drivers/pci/Kconfig"
+source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/pcie/Kconfig"

 source "drivers/pcmcia/Kconfig"


However I would therefore suppose that it has probably not been tested
before.

After some testing, I can say, the PCIe hotplug driver does seem to work
on arm, at least in the context of my own board. The only caveat seems
to be that my PCIe bridge does not correctly report the GPIOs for hotplug
forcing me to hard-code them into the device tree to make plug detection
work properly.

If the above patch was applied it should be possible to enable this on
any arm based board.

Thanks kindly for the suggestion to try that!

>> Hopefully this explains the situation a little. Please note however,
>> this applies to a wider issue, any system where there is no BIOS/BIOS
>> like object/ACPI to map irqs to unused slots (or if the firmware is
>> buggy and will not do so) currently has no way to allocate an irq to
>> those slots later should a device become connected to them. It does
>> not seem correct that this code should be reserved only to boot time
>> and would seem beneficial to have routines to do this later.
>>
>>> pci_fixup_irqs() has been broken from the beginning because it is only
>>> done for devices present at boot-time, and nothing happens for
>>> hot-added devices.
>>>
>>> I think you're on the right path by looking at the generic
>>> pci_bus_add_device() path that is used both at boot-time and hot
>>> add-time.  I would like to see something that works the same way at
>>> both times and gets rid of pci_fixup_irqs() altogether.
>>>
>>> I'm not sure this needs to be done as early as pci_bus_add_device();
>>> it could probably be done somewhere in the pci_enable_device() path,
>>> since drivers can't use interrupts before that anyway.
>>>
>>> Bjorn
>>
>> It should be entirely possible to factor out pci_fixup_irqs
>> completely, it seems most of the calls to it are in the virtual PCI
>> BIOSes of platforms which have no BIOS, I agree it would be far neater
>> to avoid the platform independent code as far as possible and unify
>> PCI irqs into a single place.
>>
>> If it is OK with you I would like to rework the patch-set so that that
>> instead of the boot time PCI code assigning the irqs it can instead
>> register an irq swizzling and an irq mapping function (which would
>> probably be stored either in the pci_host_bridge struct) or a default
>> could be used. Thich can then be called during the drvice-add code
>> path to both fix hot-plug irqs and unify the infrastructure a little
>> so it relies less on platform code. This registration could be done in
>> pcibios_root_bridge_prepare (as this can be overridden by each arch).
>
> That seems reasonable.

I have just emailed out the second version of this patch set, it should be a lot
more stable, eliminates pci_fixup_irqs completely and simplifies some of
the PCI init and fixup code.The only flaw is that it has required me to edit
architecture specific code for arches which I don't have and as such I have
not been able to test some of the small changes.

Thanks for the suggestions regarding  delaying the assignment until the device
is being enabled, I had not noticed that IRQs were unavailable before then.

In the mean time I hope that your holiday goes well.

Many thanks,
Matthew

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
