Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41684 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeH3EMi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2018 00:12:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so6373407wrb.8
        for <linux-pci@vger.kernel.org>; Wed, 29 Aug 2018 17:13:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACO55tsoOYfrA2Wqf38JA6n83yz8YGxzvfLun+kOisWN6pjb8A@mail.gmail.com>
References: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
 <20180824154212.GB8601@al> <CAD8Lp45D6=pqsgr_tXS08pE0dbG1XhcwnDB3mGZQ=P3ETxywzw@mail.gmail.com>
 <CACO55tsoOYfrA2Wqf38JA6n83yz8YGxzvfLun+kOisWN6pjb8A@mail.gmail.com>
From: Karol Herbst <kherbst@redhat.com>
Date: Thu, 30 Aug 2018 02:13:11 +0200
Message-ID: <CACO55tsY8id344Zs+MeHV7fM0qD7fcU6LZ1VZ=87SGGm7B7jsg@mail.gmail.com>
Subject: Re: [Nouveau] Rewriting Intel PCI bridge prefetch base address bits
 solves nvidia graphics issues
To: Daniel Drake <drake@endlessm.com>
Cc: Peter Wu <peter@lekensteyn.nl>, linux-pci@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ohh actually, I was testing with a kernel without this workaround
applied, so I need to retest it later.

On Wed, Aug 29, 2018 at 2:40 PM, Karol Herbst <kherbst@redhat.com> wrote:
> On Tue, Aug 28, 2018 at 4:23 AM, Daniel Drake <drake@endlessm.com> wrote:
>> On Fri, Aug 24, 2018 at 11:42 PM, Peter Wu <peter@lekensteyn.nl> wrote:
>>> Are these systems also affected through runtime power management? For
>>> example:
>>>
>>>     modprobe nouveau    # should enable runtime PM
>>>     sleep 6             # wait for runtime suspend to kick in
>>>     lspci -s1:          # runtime resume by reading PCI config space
>>>
>>> On laptops from about 2015-2016 with a GTX 9xxM this sequence results in
>>> hangs on various laptops
>>> (https://bugzilla.kernel.org/show_bug.cgi?id=156341).
>>
>> This works fine here. I'm facing a different issue.
>>
>>>> After a lot of experimentation I found a workaround: during resume,
>>>> set the value of PCI_PREF_BASE_UPPER32 to 0 on the parent PCI bridge.
>>>> Easily done in drivers/pci/quirks.c. Now all nvidia stuff works fine.
>>>
>>> I am curious, how did you discover this? While this could work, perhaps
>>> there are alternative workarounds/fixes?
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
>>> When you say "parent PCI" bridge, is that actually the device you see in
>>> "lspci -tv"? On a Dell XPS 9560, the GPU is under a different device:
>>>
>>>   -[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
>>>              +-01.0-[01]----00.0  NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile]
>>>
>>>  00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 05)
>>
>> Yes, it's the parent bridge shown by lspci. The address of this varies
>> from system to system.
>>
>>>> 1. Is the Intel PCI bridge misbehaving here? Why does writing the same
>>>> value of PCI_PREF_BASE_UPPER32 make any difference at all?
>>>
>>> At what point in the suspend code path did you insert this write? It is
>>> possible that the write somehow acted as a fence/memory barrier?
>>
>> static void quirk_pref_base_upper32(struct pci_dev *dev)
>> {
>>        u32 pref_base_upper32;
>>        pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32, &pref_base_upper32);
>>        pci_write_config_dword(dev, PCI_PREF_BASE_UPPER32, pref_base_upper32);
>> }
>> DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,  0x9d10, quirk_pref_base_upper32);
>>
>
> this workaround fixes runtime suspend/resume on my laptop as well...
> but what baffles me most is, unloading nouveau does as well. I will
> see what bits are exactly "fixing" it in the nouveau unloading path
> and maybe we can get around this issue inside nouveau. It would be
> still nice to get to the root cause of all of this as there are three
> known workarounds (at least on my system):
> 1. unload nouveau
> 2. skip setting the D3 power state via PCI config space (and still do
> the ACPI bits)
> 3. write value of PCI_PREF_BASE_UPPER32
>
>> I don't think it's acting as a barrier. I tried changing this code to
>> rewrite other registers such as PCI_PREF_MEMORY_BASE and that makes
>> the bug come back.
>>
>>>> 2. Who is responsible for saving and restoring PCI bridge
>>>> configuration during suspend and resume? Linux? ACPI? BIOS?
>>>
>>> Not sure about PCI bridges, but at least for the PCI Express Capability
>>> registers, it is in control of the OS when control is granted via the
>>> ACPI _OSC method.
>>
>> I guess you are referring to pci_save_pcie_state(). I can't see
>> anything equivalent for the bridge registers.
>>
>>> As Windows is probably not affected by this issue, a change must be
>>> possible to make Linux more compatible with Windows. Though I am not
>>> sure what change is needed.
>>
>> I agree. There's a definite difference with Windows here and it would
>> be great to find a fix along those lines.
>>
>>> I recently compared PCI configuration space access and ACPI method
>>> invocation using QEMU + VFIO with Linux 4.18, Windows 7 and Windows 10
>>> (1803). There were differences like disabling MSI/interrupts before
>>> suspend, setting the Enable Clock Power Management bit in PCI Express
>>> Link Control and more, but applying these changes were so far not really
>>> successful.
>>
>> Interesting. Do you know any way that I could spy on Windows' accesses
>> to the PCI bridge registers?
>> Looking at at https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
>> I suspect VFIO would not help me here.
>> It says:
>>     Note: If they are grouped with other devices in this manner, pci
>> root ports and bridges should neither be bound to vfio at boot, nor be
>> added to the VM.
>>
>> Thanks
>> Daniel
>> _______________________________________________
>> Nouveau mailing list
>> Nouveau@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/nouveau
