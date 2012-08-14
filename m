Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60328 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab2HNXvh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 19:51:37 -0400
Message-ID: <502AE485.8060307@wwwdotorg.org>
Date: Tue, 14 Aug 2012 17:51:33 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
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
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de> <50201E1D.5060200@wwwdotorg.org> <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de> <50294BCA.1070807@wwwdotorg.org> <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com> <502AA96B.2050709@wwwdotorg.org> <20120814195834.GA10431@avionic-0098.mockup.avionic-design.de> <CAErSpo4Bm_Ryx=OK+svjqAwD4N8v0vrheLVdc-N1ijx8i_-N3w@mail.gmail.com> <502AD82F.3080702@wwwdotorg.org>
In-Reply-To: <502AD82F.3080702@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/14/2012 04:58 PM, Stephen Warren wrote:
> On 08/14/2012 03:55 PM, Bjorn Helgaas wrote:
>> On Tue, Aug 14, 2012 at 12:58 PM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>>> On Tue, Aug 14, 2012 at 01:39:23PM -0600, Stephen Warren wrote:
>>>> On 08/13/2012 05:18 PM, Bjorn Helgaas wrote:
>>>>> On Mon, Aug 13, 2012 at 11:47 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> ...
>>>>>> whereas for a device tree boot:
>>>>>>
>>>>>> (same):
>>>>>>> [    2.112217] pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
>>>>>>> [    2.117635] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 64bit pref]
>>>>>>> [    2.124690] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 64bit pref]
>>>>>>> [    2.131731] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
>>>>>> ... (request region happens early)
>>>>>>> [    2.179838] r8169 0000:01:00.0: BAR 0: requesting [io  0x0000-0x00ff]
>>>>>>> [    2.193312] r8169 0000:01:00.0: BAR 2: requesting [mem 0x00000000-0x00000fff 64bit pref]
>>>>>>> [    2.201397] r8169 0000:01:00.0: BAR 2: can't reserve [mem 0x00000000-0x00000fff 64bit pref]
>>>>>>> [    2.209742] r8169 0000:01:00.0: (unregistered net_device): could not request regions
>>>>>> ... (same, just happens too late)
>>>>>>> [    2.236818] pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa001ffff pref]
>>>>>>> [    2.244027] pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa0023fff 64bit pref]
>>>>>>> [    2.251794] pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa0024fff 64bit pref]
>>>>>>> [    2.259542] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
>>>>>>
>>>>>> I suspect this is all still related to the PCI devices themselves being
>>>>>> probed much earlier in the overall PCI initialization sequence when the
>>>>>> PCI controller is probed later in the boot sequence, whereas PCI device
>>>>>> probe is deferred until the overall PCI initialization sequence is
>>>>>> complete if the PCI controller is probed very early in the boot sequence.
>>>>>
>>>>> I don't know what to apply your patches to (they don't apply cleanly
>>>>> to v3.6-rc2), so I can't see exactly what you're doing.  But it looks
>>>>> like you might be calling pci_bus_add_devices() before
>>>>> pci_bus_assign_resource(), which isn't going to work.
>>>>
>>>> Yes, that's exactly what is happening.
>>>>
>>>> PCIe initialization starts in arch/arm/mach-tegra/pci.e
>>>> tegra_pcie_init() which calls arch/arm/kernel/bios32.c
>>>> pci_common_init(). That function first calls pcibios_init_hw() (in the
>>>> same file, more about this later) and then loops over PCI buses, calling
>>>> amongst other things pci_bus_assign_resources() then pci_bus_add_devices().
>>>>
>>>> The problem is that ARM's pcibios_init_hw() calls pci_scan_root_bus()
>>>> (or a host-driver-specific function which that also calls
>>>> pci_scan_root_bus() in Tegra's case) which in turn calls
>>>> pci_bus_add_devices() right at the end, before control has returned to
>>>> pci_common_init() and hence before pci_bus_assign_resources() has been
>>>> called.
>>>>
>>>> If I modify pci_scan_root_bus() and remove the call to
>>>> pci_bus_add_devices(), everything works as expected.
>>>>
>>>> So, I guess the question is: Should ARM's pcibios_init_hw() not be
>>>> calling pci_scan_root_bus(), or at least presumably the ARM PCI code
>>>> needs to do things in a slightly different order?
>>
>> I think you need to do something like this instead of using pci_scan_root_bus():
>>
>>     pci_create_root_bus()
>>     pci_scan_child_bus()
>>     pci_bus_assign_resources()
>>     pci_bus_add_devices()
>>
>> This is the effective order used by most of the pci_create_root_bus() callers.
> 
> That would pretty much duplicate everything in pci_scan_root_bus(). That
> might cause divergence down the road.
> 
> Can't we make the call to pci_bus_add_devices() optional in
> pci_scan_root_bus() somehow; one of:

Sigh, that turns out not to work correctly; it solves at least this part
of the problem when booting using device tree, but when booting using a
board file, it causes the IRQ number passed to the PCIe device to be
bogus:-(

I give up for now.
