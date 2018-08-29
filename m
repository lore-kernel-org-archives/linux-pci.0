Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51350 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeH2EOJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Aug 2018 00:14:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so3523590wma.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Aug 2018 17:20:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180828095722.GA8820@al>
References: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
 <20180824154212.GB8601@al> <CAD8Lp45D6=pqsgr_tXS08pE0dbG1XhcwnDB3mGZQ=P3ETxywzw@mail.gmail.com>
 <20180828095722.GA8820@al>
From: Karol Herbst <kherbst@redhat.com>
Date: Wed, 29 Aug 2018 02:19:59 +0200
Message-ID: <CACO55tsLJ4_Ff-T9OBf2XN=ScRcM83xs0mxwhPiaaSTdEceE2A@mail.gmail.com>
Subject: Re: [Nouveau] Rewriting Intel PCI bridge prefetch base address bits
 solves nvidia graphics issues
To: Peter Wu <peter@lekensteyn.nl>
Cc: Daniel Drake <drake@endlessm.com>, linux-pci@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hi everybody.

I came up with another workaround for the runtime suspend/resume
issues we have as well:
https://github.com/karolherbst/linux/commit/3cab4c50f77cf97c6c19a9b1e7884366f78f35a5.patch

I don't think this is really a bug inside the kernel or not directly.
If you for example not use Nouveau but simply enable the runpm
features without a driver or a very dumb stub driver, the GPU should
be able to suspend and resume correctly. At least this is the case on
my laptop.

I was able to disable enough part of Nouveaus code to be able to tell
that running some signed firmware embedded in the vbios on the GPU
embedded PMU is starting the runpm issues to appear on my laptop. This
firmware is also used by the nvidia driver, which makes the argument
"it happens with Nouveau and nvidia" a useless one.

I have no idea what this is all about, but it might be the
hardware/firmware just being overprotecting and bailing out on an
untrusted state, maybe it is a bug inside the kernel, maybe a bug
inside nvidias firmware, which would be super hard to fix as it's
embedded in the vbios.

On Tue, Aug 28, 2018 at 11:57 AM, Peter Wu <peter@lekensteyn.nl> wrote:
> On Tue, Aug 28, 2018 at 10:23:24AM +0800, Daniel Drake wrote:
>> On Fri, Aug 24, 2018 at 11:42 PM, Peter Wu <peter@lekensteyn.nl> wrote:
>> > Are these systems also affected through runtime power management? For
>> > example:
>> >
>> >     modprobe nouveau    # should enable runtime PM
>> >     sleep 6             # wait for runtime suspend to kick in
>> >     lspci -s1:          # runtime resume by reading PCI config space
>> >
>> > On laptops from about 2015-2016 with a GTX 9xxM this sequence results in
>> > hangs on various laptops
>> > (https://bugzilla.kernel.org/show_bug.cgi?id=156341).
>>
>> This works fine here. I'm facing a different issue.
>
> Just to be sure, after "sleep", do both devices report "suspended" in
> /sys/bus/pci/devices/0000:00:1c.0/power/runtime_status
> /sys/bus/pci/devices/0000:01:00.0/power/runtime_status
>
> and was this reproduced with a recent mainline kernel with no special
> cmdline options? The endlessm kernel on Github seems to have quite some
> patches, one of them explicitly disable runtime PM:
> https://github.com/endlessm/linux/commit/8b128b50cd6725eee2ae9025a1510a221d9b42f2
>
>> >> After a lot of experimentation I found a workaround: during resume,
>> >> set the value of PCI_PREF_BASE_UPPER32 to 0 on the parent PCI bridge.
>> >> Easily done in drivers/pci/quirks.c. Now all nvidia stuff works fine.
>> >
>> > I am curious, how did you discover this? While this could work, perhaps
>> > there are alternative workarounds/fixes?
>>
>> Based on the observation that the following procedure works fine (note
>> the addition of step 3):
>>
>> 1. Boot
>> 2. Suspend/resume
>> 3. echo rescan > /sys/bus/pci/devices/0000:00:1c.0/rescan
>> 4. Load nouveau driver
>> 5. Start X
>>
>> I worked through the rescan codepath until I had isolated the specific
>> code which magically makes things work (in pci_bridge_check_ranges).
>>
>> Having found that, step 3 in the above test procedure can be replaced
>> with a simple:
>>    setpci -s 00:1c.0 0x28.l=0
>>
>> > When you say "parent PCI" bridge, is that actually the device you see in
>> > "lspci -tv"? On a Dell XPS 9560, the GPU is under a different device:
>> >
>> >   -[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
>> >              +-01.0-[01]----00.0  NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile]
>> >
>> >  00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 05)
>>
>> Yes, it's the parent bridge shown by lspci. The address of this varies
>> from system to system.
>
> Could you share some details:
> - acpidump
> - lspci -nnxxxxvvv
> - BIOS version (from /sys/class/dmi/id/)
> - kernel version (mainline?)
>
> Perhaps there is some magic in the ACPI suspend or resume path that
> causes this.
>
>> >> 1. Is the Intel PCI bridge misbehaving here? Why does writing the same
>> >> value of PCI_PREF_BASE_UPPER32 make any difference at all?
>> >
>> > At what point in the suspend code path did you insert this write? It is
>> > possible that the write somehow acted as a fence/memory barrier?
>>
>> static void quirk_pref_base_upper32(struct pci_dev *dev)
>> {
>>        u32 pref_base_upper32;
>>        pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32, &pref_base_upper32);
>>        pci_write_config_dword(dev, PCI_PREF_BASE_UPPER32, pref_base_upper32);
>> }
>> DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,  0x9d10, quirk_pref_base_upper32);
>>
>> I don't think it's acting as a barrier. I tried changing this code to
>> rewrite other registers such as PCI_PREF_MEMORY_BASE and that makes
>> the bug come back.
>>
>> >> 2. Who is responsible for saving and restoring PCI bridge
>> >> configuration during suspend and resume? Linux? ACPI? BIOS?
>> >
>> > Not sure about PCI bridges, but at least for the PCI Express Capability
>> > registers, it is in control of the OS when control is granted via the
>> > ACPI _OSC method.
>>
>> I guess you are referring to pci_save_pcie_state(). I can't see
>> anything equivalent for the bridge registers.
>
> Yes that would be the function, called via pci_save_state.
>
>> > I recently compared PCI configuration space access and ACPI method
>> > invocation using QEMU + VFIO with Linux 4.18, Windows 7 and Windows 10
>> > (1803). There were differences like disabling MSI/interrupts before
>> > suspend, setting the Enable Clock Power Management bit in PCI Express
>> > Link Control and more, but applying these changes were so far not really
>> > successful.
>>
>> Interesting. Do you know any way that I could spy on Windows' accesses
>> to the PCI bridge registers?
>> Looking at at https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
>> I suspect VFIO would not help me here.
>> It says:
>>     Note: If they are grouped with other devices in this manner, pci
>> root ports and bridges should neither be bound to vfio at boot, nor be
>> added to the VM.
>
> Only non-bridge devices can be passed to a guest, but perhaps logging
> access to the emulated bridge is already sufficient. The Prefetchable
> Base Upper 32 Bits register is at offset 0x28.
>
> In a trace where the Nvidia device is disabled/enabled via Device
> Manager, I see writes on the enable path:
>
>     2571@1535108904.593107:rp_write_config (ioh3420, @0x28, 0x0, len=0x4)
>
> For Linux, I only see one write at startup, none on runtime resume.
> I did not test system sleep/resume. (disable/enable is arguably a bit
> different from system s/r, you may want to do additional testing here.)
>
> Full log for WIndows 10 and Linux:
> https://github.com/Lekensteyn/acpi-stuff/blob/master/d3test/XPS9560/slogs/win10-rp-enable-disable.txt#L3418
> https://github.com/Lekensteyn/acpi-stuff/blob/master/d3test/XPS9560/slogs/linux-rp.txt
> lspci for the emulated bridge:
> https://github.com/Lekensteyn/acpi-stuff/blob/master/d3test/XPS9560/lspci-vm-vfio.txt#L359
> The rp_*_config trace points are non-standard and require patches:
> https://github.com/Lekensteyn/acpi-stuff/blob/master/d3test/patches/qemu-trace.diff
> --
> Kind regards,
> Peter Wu
> https://lekensteyn.nl
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
