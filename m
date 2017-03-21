Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38491 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbdCURax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2017 13:30:53 -0400
Received: by mail-wm0-f42.google.com with SMTP id t189so17908283wmt.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2017 10:30:51 -0700 (PDT)
Received: from [10.82.95.35] (soho87-122.sohonet.co.uk. [193.203.87.122])
        by smtp.gmail.com with ESMTPSA id b17sm18454526wma.33.2017.03.21.10.30.39
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2017 10:30:39 -0700 (PDT)
From: Harry Mallon <hjmallon@gmail.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: PCIe native hotplug under root port with ACPI disable
Message-Id: <43292885-EA6C-48C1-87AD-5BC82AD60DAF@gmail.com>
References: <5AA13D87-AEC8-49A6-A826-FF17A5EEB35D@codex.london>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Tue, 21 Mar 2017 17:30:39 +0000
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all,

I have a PCIe switch attached to my root PCIe device. The switch =
supports native hotplug. I then try to hotplug devices into the =
downstream ports and it doesn't work without the kernel command line =
"pcie_ports=3Dnative" which ignores the ACPI setup when adding PCIe =
features. With "pcie_ports=3Dnative" command line interrupts are =
correctly attached and hotplugging works.

This is the layout:
[Intel Motherboard PCIe] - [PLX PCIe switch] - [Hotplug devices]

Linux currently checks (using ACPI _OSC command on PCI0) whether the =
root bridge (Intel motherboard device) will transfer command of native =
hotplug to the OS. The HP BIOS sets that bit to 0. I get the following =
trace in dmesg:

kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM =
Segments MSI]
kernel: acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug =
PME]
kernel: acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]

When the switch is added the kernel climbs the tree to the root port in =
pcie_port_acpi_setup and checks it's capabilities. Therefore native =
hotplug is disabled on my switch because the _OSC command refuses to =
give linux control of hotplug on the root port.

Does "_OSC applies to the entire hierarchy originated by a PCI Host =
Bridge" (PCI firmware spec, rev 3.2, sec 4.5.1, see Addendum) mean that =
I am not allowed to use the Native hotplug system all the way down the =
tree? Should I try to get hold of the BIOS vendor (HP) to find out why =
it refuses the transfer?

Thanks,
Harry

Addendum:

I asked this earlier on IRC and Bjorn looked some things up for me. Here =
they are so you don't have to look them up too:

from the PCI firmware spec, rev 3.2, sec 4.5.1:
The third DWORD in the _OSC Capabilities Buffer is the Control Field. =
Bits defined in the Control Field are used to submit requests by the =
operating system for control/handling of the associated feature, =
typically (but not excluded to) those features that utilize native =
interrupts or events handled by an operating system-level driver. If any =
bits in the Control Field are returned cleared (masked to zero) by the =
_OSC control method, the respective feature is designated unsupported by =
the platform and must not be enabled by the operating system. Some of =
these features may be controlled by platform firmware prior to operating =
system boot or during runtime for a legacy operating system, while =
others may be disabled/inoperative until native operating system support =
is available. System firmware must only mask a Control Field bit to zero =
if it has explicit knowledge that the feature will not work properly =
under native operating system control, due to platform errata or other =
incompatibilities.

Since _OSC applies to the entire hierarchy originated by a PCI Host =
Bridge, and system firmware cannot generally comprehend the features and =
capabilities of all devices that may be hot-plugged into a system, lack =
of explicit support of a feature in the system firmware is not a reason =
to mask a Control Field bit to zero. For example, unless system firmware =
has knowledge that the system contains hardware that does not work =
properly with Standard Hot-Plug Controller (SHPC) or PCI Express Native =
Hot Plug software, it must set both the PCI Express Native Hot Plug =
control and SHPC Native Hot Plug control bits, even if the system does =
not explicitly support hot plug. It is the operating system=C2=92s =
responsibility to determine whether a slot in the hierarchy is hot =
pluggable by incompatible encoding examining the status of the slots =
based on the PCI Express Base Specification and the PCI SHPC =
Specification.
For the above reason, system firmware must always assume that PCI-X =
features are supported

PCI Express Native Hot Plug control
The operating system sets this bit to 1 to request control over PCI =
Express native hot plug. If the operating system successfully receives =
control of this feature, it must track and update the status of hot plug =
slots and handle hot plug events as described in the PCI Express Base =
Specification (including determining whether the associated slot(s) =
support hot plug).
