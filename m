Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:38361 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeHXToT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Aug 2018 15:44:19 -0400
Date: Fri, 24 Aug 2018 17:42:12 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Daniel Drake <drake@endlessm.com>
Cc: linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [Nouveau] Rewriting Intel PCI bridge prefetch base address bits
 solves nvidia graphics issues
Message-ID: <20180824154212.GB8601@al>
References: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Daniel,

On Fri, Aug 24, 2018 at 11:31:54AM +0800, Daniel Drake wrote:
> Hi,
> 
> We are facing a suspend/resume problem with many different Asus laptop
> models (30+ products) with Intel chipsets (multiple generations) and
> nvidia GPUs (several different ones). Reproducers include:

Are these systems also affected through runtime power management? For
example:

    modprobe nouveau    # should enable runtime PM
    sleep 6             # wait for runtime suspend to kick in
    lspci -s1:          # runtime resume by reading PCI config space

On laptops from about 2015-2016 with a GTX 9xxM this sequence results in
hangs on various laptops
(https://bugzilla.kernel.org/show_bug.cgi?id=156341).

I wonder if you are experiencing the same issue. Do you have a list of
affected models, an acpidump, the output of "lspci -nnvvvxxxx" and the
corresponding BIOS version (e.g. from /sys/class/dmi/id/)?

> After a lot of experimentation I found a workaround: during resume,
> set the value of PCI_PREF_BASE_UPPER32 to 0 on the parent PCI bridge.
> Easily done in drivers/pci/quirks.c. Now all nvidia stuff works fine.

I am curious, how did you discover this? While this could work, perhaps
there are alternative workarounds/fixes?

When you say "parent PCI" bridge, is that actually the device you see in
"lspci -tv"? On a Dell XPS 9560, the GPU is under a different device:

  -[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
             +-01.0-[01]----00.0  NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile]

 00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 05)

Under 00:1c.0, there is a wireless adapter.

> As an example of an affected product, take the Asus X542UQ (Intel
> KabyLake i7-7500U with Nvidia GeForce 940MX). The PCI bridge is:
> 
> 00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
> Express Root Port [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 120
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>     I/O behind bridge: 0000e000-0000efff
>     Memory behind bridge: ee000000-ef0fffff
>     Prefetchable memory behind bridge: 00000000d0000000-00000000e1ffffff
>     Capabilities: [40] Express Root Port (Slot+), MSI 00
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>     Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Sunrise
> Point-LP PCI Express Root Port [1043:1a00]
>     Capabilities: [a0] Power Management version 3
>     Capabilities: [100] Advanced Error Reporting
>     Capabilities: [140] Access Control Services
>     Capabilities: [200] L1 PM Substates
>     Capabilities: [220] #19
>     Kernel driver in use: pcieport
> 
> The really weird thing here is that the workaround register
> PCI_PREF_BASE_UPPER32 already appears to have value 0, as shown above
> and also verified during resume. But simply writing value 0 again
> definitely results in all the problems going away.
> 
> 1. Is the Intel PCI bridge misbehaving here? Why does writing the same
> value of PCI_PREF_BASE_UPPER32 make any difference at all?

At what point in the suspend code path did you insert this write? It is
possible that the write somehow acted as a fence/memory barrier?

> 2. Who is responsible for saving and restoring PCI bridge
> configuration during suspend and resume? Linux? ACPI? BIOS?

Not sure about PCI bridges, but at least for the PCI Express Capability
registers, it is in control of the OS when control is granted via the
ACPI _OSC method.

> I could not see any Linux code to save and restore these registers.
> Likewise I didn't find anything in the ACPI DSDT/SSDT - neither on the
> affected products, nor on a similar product that does not suffer this
> nvidia issue. Linux does put the PCI bridge into D3 power state during
> suspend, and upon resume the lower 32 bits of the prefetch address are
> still set to the same value, so through some means this info is not
> being lost.
> 
> 
> 3. Any other suggestions, hints or experiments I could do to help move
> forward on this issue?
> 
> My goal is to add a workaround to Linux (perhaps as a pci quirk) for
> existing devices, but also we are in conversation with Asus engineers
> and if we can come up with a concrete diagnosis, we should be able to
> have them fix this at the BIOS level in future products.

As Windows is probably not affected by this issue, a change must be
possible to make Linux more compatible with Windows. Though I am not
sure what change is needed.

I recently compared PCI configuration space access and ACPI method
invocation using QEMU + VFIO with Linux 4.18, Windows 7 and Windows 10
(1803). There were differences like disabling MSI/interrupts before
suspend, setting the Enable Clock Power Management bit in PCI Express
Link Control and more, but applying these changes were so far not really
successful.

Some supporting files for that investigation are here:
https://github.com/Lekensteyn/acpi-stuff/tree/master/d3test

Karol noticed that by not setting the State in PMCSR to D3 for the
Nvidia GPU during runtime suspend, then the device would successfully
resume. However, based on traces using VFIO-PCI, it does not seem a good
solution as Windows does not behave like that.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
