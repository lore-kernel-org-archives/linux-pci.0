Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <bug-199473-41252@https.bugzilla.kernel.org/> <CAErSpo4BOD3V7pgR75Gm7dYqvXYq1QfChjj16Jn1QgSK1W=Drw@mail.gmail.com>
 <000701d3dc6f$61f91230$25eb3690$@dommel.be>
In-Reply-To: <000701d3dc6f$61f91230$25eb3690$@dommel.be>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Apr 2018 19:05:14 +0000
Message-ID: <CAErSpo7FoAWrrCo9ifzCHtihsZUBG4HDS=kCT2ZjPi7qpVgWzg@mail.gmail.com>
Subject: Re: [Bug 199473] New: pcieport does not scan devices behind PEX
 switch, while resources are allocated
To: janpieter.sollie@dommel.be
Cc: linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Please retain the mailing list cc when replying]

On Wed, Apr 25, 2018 at 3:28 AM Janpieter Sollie
<janpieter.sollie@dommel.be>
wrote:

> Hi Bjorn,

> I'm at work now, but I saw your mail contained much more info than only
the remark "does it work at 4.17?", so I'll try to answer all your
questions:
> 1. as stated, it only assigns the address space of the second and 3rd
device when the PCI device is hotplugged and then the pc is restarted on a
port before the first device.  In this case:
>           - The Ellesmere 01.0-[4f] device is connected to port 3 (0-7) and
is always reported.  For other devices, this is not the case.
>           - The other devices are at port 1 and 2.  When adding them on a
higher port, the workaround does not work.
>           - The devices 05.0-[4c] and 07.0-[4b] are ALSO NOT VISIBLE in the
BIOS IRQ listing, it just talks about an endpoint.  Not even with the
workaround.  So a trick to discard bios info and let the PCIe switch report
its devices would be nice.

BIOS info is not used when we enumerate devices, so I don't think there's
really anything to discard.

> 2. I am always building my kernel from the kernel.org sources, not from
Gentoo sources, so it's not a distro problem.
> 3. The workaround only works with kernel 4.17
> 4. You are probably right about the Broadcom driver, as it only picks up
the endpoint at 42.00.1 when loaded.  I have no idea wat it does either,
besides taining the kernel.

Let's simplify the situation by focusing only on v4.17.  We can
also ignore the Broadcom driver, since it's not involved in enumeration.

> So, to summarize:
> - Why are ports 4-7 not working when a device is plugged in at port 3?

I don't know what "port 3" and "ports 4-7" refer to.  Are these labels on
slots in an expansion chassis?  Something from lspci, e.g., the port number
from Link Capabilites, or the slot number from Slot Capabilities?

> - Why do I need a hotplug event to push the device name into the kernel
after a cold start?  This is complete madness, isn't it?

I don't know why the hotplug would make a difference.  It does sound like
complete madness.

> - Why are resources allocated while the PCI slot is empty?

I don't know exactly what resources you're referring to (bus numbers, MMIO
space, I/O port space).  In general we try to allocate some space for all
of those even if the slot is currently empty, because that makes it
possible to hot-add devices in the slot later.

In this case, the bus number space is quite constrained because the host
bridge leading to the PEX switch only supports [bus 40-4f].  But I think
that should be enough for this case, since the only switch in this tree is
the PEX, and your Bonaire/Tobago/Ellesmere devices are all endpoints that
only require one bus number each.

If you run "lspci -vv" as root, it'll decode more details.

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: dinsdag 24 april 2018 21:31
> To: janpieter.sollie@dommel.be
> Cc: linux-pci@vger.kernel.org; Linux Kernel Mailing List
> Subject: Fwd: [Bug 199473] New: pcieport does not scan devices behind PEX
switch, while resources are allocated

> Thanks for the report!

> I don't understand exactly what the issue is yet.  You attached lspci
> output from v4.14.27 and v4.17-rc1.  The v4.17-rc1 output shows several
> devices (4b:00, 4c:00, 4f:00) below the PEX switch, while the v4.14.27
> output shows only the 4f:00 devices.

> Is the problem that v4.14.27 doesn't find the 4b:00 and 4c:00 devices?
> Does v4.17-rc1 work correctly?

> If v4.17-rc1 works but v4.14.27 does not, it's probably a question of
> working with your distro to see if they can (1) identify some change that
> fixed things, and (2) backport that change to the distro kernel.

> The Broadcom driver you attached at comment #4 shouldn't be related to
this
> problem.  Device enumeration is performed by the PCI core and doesn't
> require any additional drivers.  I didn't look at the Broadcom driver, so
I
> don't know what it does.  The PEX switch does include an endpoint
> (42:00.1); it's possible the driver is for some functionality provided by
> that endpoint.

> ---------- Forwarded message ---------
> From: <bugzilla-daemon@bugzilla.kernel.org>
> Date: Mon, Apr 23, 2018 at 12:20 AM
> Subject: [Bug 199473] New: pcieport does not scan devices behind PEX
> switch, while resources are allocated
> To: <bhelgaas@google.com>


> https://bugzilla.kernel.org/show_bug.cgi?id=199473

>                Bug ID: 199473
>               Summary: pcieport does not scan devices behind PEX switch,
>                        while resources are allocated
>               Product: Drivers
>               Version: 2.5
>        Kernel Version: 4.17-rc1
>              Hardware: x86-64
>                    OS: Linux
>                  Tree: Mainline
>                Status: NEW
>              Severity: normal
>              Priority: P1
>             Component: PCI
>              Assignee: drivers_pci@kernel-bugs.osdl.org
>              Reporter: janpieter.sollie@dommel.be
>            Regression: No

> Created attachment 275511
>      --> https://bugzilla.kernel.org/attachment.cgi?id=275511&action=edit
> dmesg stable kernel

> pcieport assigns the PEX 8619 pcie expander switch ports, but does not
scan
> them for additional objects behind the ports. only 1 device is added @ pci
> region 4f.  Workaround for getting all devices online: while pc is on,
> remove
> the card, reinsert it at a slot before the working device, and make a cold
> start.
> It would be nice if the pcie switches are scanned properly.

> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
