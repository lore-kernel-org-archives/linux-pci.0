Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42828 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754140Ab2HMXSj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Aug 2012 19:18:39 -0400
Received: by lagy9 with SMTP id y9so2341799lag.19
        for <linux-pci@vger.kernel.org>; Mon, 13 Aug 2012 16:18:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50294BCA.1070807@wwwdotorg.org>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50201E1D.5060200@wwwdotorg.org> <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de>
 <50294BCA.1070807@wwwdotorg.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 13 Aug 2012 16:18:16 -0700
Message-ID: <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Russell King <linux@arm.linux.org.uk>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 13, 2012 at 11:47 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/13/2012 11:40 AM, Thierry Reding wrote:
>> On Mon, Aug 06, 2012 at 01:42:21PM -0600, Stephen Warren wrote:
>>> On 07/26/2012 01:55 PM, Thierry Reding wrote:
>>>> This patch series adds support for device tree based probing of
>>>> the PCIe controller found on Tegra SoCs.
>>>
>>> Thierry, I just tested all Tegra boards in v3.6-rc1, and noticed
>>> that PCIe doesn't work on TrimSlice when booting use device tree.
>>> I think I found the cause, and I can't see why the same problem
>>> doesn't affect this series. Perhaps you can enlighten me?
> ...
>>> PCI: Device 0000:01:00.0 not available because of resource
>>> collisions
> ...
>> I've looked into this a bit, and it seems like ARM is using an
>> open- coded version of the pci_enable_resources() function here,
>> with the only difference being the unconditional enabling of both
>> I/O and memory- mapped access for bridges. On Tegra there is
>> already a PCI fixup to do this, so pci_enable_resources() can be
>> used as-is.

I'd prefer that bridge I/O & memory access enabling be done in a
mainline path, not in a fixup.  Fixups are intended for working around
defects in specific devices, not for the normal path.  I know various
architectures have fixups that are used in the normal path, but I've
been working on eliminating them.

> The patch did alter the behavior a little for TrimSlice, but didn't
> solve the problem. The old error messages:
>
>> [    2.173971] PCI: Device 0000:01:00.0 not available because of resource collisions
>> [    2.181453] r8169 0000:01:00.0: (unregistered net_device): enable failure
>> [    2.188254] r8169: probe of 0000:01:00.0 failed with error -22
>
> Were replaced with the following with your patch:
>
>> [    2.174010] r8169 0000:01:00.0: device not available (can't reserve [io  0x0000-0x00ff])
>> [    2.182098] r8169 0000:01:00.0: (unregistered net_device): enable failure
>> [    2.188900] r8169: probe of 0000:01:00.0 failed with error -22
>
> This message appears from drivers/pci/setup-res.c pci_enable_resources()
> due to:
>
>>               if (!r->parent) {
>>                       dev_err(&dev->dev, "device not available "
>>                               "(can't reserve %pR)\n", r);
>>                       return -EINVAL;
>>               }
>
> That check doesn't appear in ARM's custom pcibios_enable_device().
> Disabling that check yields:
>
>> [    2.174192] r8169 0000:01:00.0: enabling device (0140 -> 0143)
>> [    2.180041] r8169 0000:01:00.0: BAR 2: can't reserve [mem 0x00000000-0x00000fff 64bit pref]
>> [    2.188386] r8169 0000:01:00.0: (unregistered net_device): could not request regions
>> [    2.196140] r8169: probe of 0000:01:00.0 failed with error -16
>
> I think that's because the pci_dev's resources are initially assigned
> PCI-aperture-relative addresses, and then these are later patched up to
> take account of where the aperture is mapped into the CPU's address space.

We definitely shouldn't be calling the driver probe routine before the
device BARs are assigned.

> Boot log using board files:
>
>> [    1.146145] pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
>> [    1.151745] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 64bit pref]
>> [    1.159007] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 64bit pref]
>> [    1.166270] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
> ...
>> [    1.217829] pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa001ffff pref]
>> [    1.225264] pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa0023fff 64bit pref]
>> [    1.233236] pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa0024fff 64bit pref]
>> [    1.241206] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> ... (I added some extra printks:)
>> [    1.488007] r8169 0000:01:00.0: BAR 0: requesting [io  0x1000-0x10ff]
>> [    1.501483] r8169 0000:01:00.0: BAR 2: requesting [mem 0xa0024000-0xa0024fff 64bit pref]
>> [    1.516611] r8169 0000:01:00.0: BAR 4: requesting [mem 0xa0020000-0xa0023fff 64bit pref]
>
> whereas for a device tree boot:
>
> (same):
>> [    2.112217] pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
>> [    2.117635] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 64bit pref]
>> [    2.124690] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 64bit pref]
>> [    2.131731] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
> ... (request region happens early)
>> [    2.179838] r8169 0000:01:00.0: BAR 0: requesting [io  0x0000-0x00ff]
>> [    2.193312] r8169 0000:01:00.0: BAR 2: requesting [mem 0x00000000-0x00000fff 64bit pref]
>> [    2.201397] r8169 0000:01:00.0: BAR 2: can't reserve [mem 0x00000000-0x00000fff 64bit pref]
>> [    2.209742] r8169 0000:01:00.0: (unregistered net_device): could not request regions
> ... (same, just happens too late)
>> [    2.236818] pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa001ffff pref]
>> [    2.244027] pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa0023fff 64bit pref]
>> [    2.251794] pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa0024fff 64bit pref]
>> [    2.259542] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
>
> I suspect this is all still related to the PCI devices themselves being
> probed much earlier in the overall PCI initialization sequence when the
> PCI controller is probed later in the boot sequence, whereas PCI device
> probe is deferred until the overall PCI initialization sequence is
> complete if the PCI controller is probed very early in the boot sequence.

I don't know what to apply your patches to (they don't apply cleanly
to v3.6-rc2), so I can't see exactly what you're doing.  But it looks
like you might be calling pci_bus_add_devices() before
pci_bus_assign_resource(), which isn't going to work.

I don't know what it means to probe PCI devices before probing the PCI
controller (the host bridge) -- that shouldn't happen either.  In
order to probe PCI devices, we have to first know about the host
bridge so we know how to do config accesses and what the bridge
apertures are.
