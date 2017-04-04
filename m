Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 4 Apr 2017 15:56:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wesley Terpstra <wesley@sifive.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: PCI enumeration without a BIOS
Message-ID: <20170404205617.GG27692@bhelgaas-glaptop.roam.corp.google.com>
References: <CAMgXwTjX1j2dhi7n+APNef0di5oo+iK57Cq0S+3NdMtQzAc=Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMgXwTjX1j2dhi7n+APNef0di5oo+iK57Cq0S+3NdMtQzAc=Vw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Wesley,

On Tue, Apr 04, 2017 at 12:31:57PM -0700, Wesley Terpstra wrote:
> Good morning,
> 
> I am trying to clean up PCIe support for the RISC-V port. On this
> architecture, PCIe enumeration may not have been performed by the
> "BIOS", of which there is none. However, it looks like linux is
> expecting a valid PCIe configuration during boot. I've attached the
> output of dmesg.

If firmware has already configured PCI, Linux generally will use that
configuration.  Linux *should* be able to enumerate PCI devices and
configure them even without any prior firmware configuration.  But
there may be bugs there, since those paths aren't exercised as much.

> In particular, these are the lines that seem wrong to me:
> [    5.920000] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [    5.930000] pci 0000:01:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring

This is normal but possibly worded more alarmingly than necessary.
Bridges power up with secondary/subordinate bus numbers as zero, so
this just means nothing has changed their configuration from the
power-up default.

> [    6.000000] pci 0000:04:00.0: [Firmware Bug]: reg 0x10: invalid BAR
> (can't size)
> [    6.010000] pci 0000:06:00.0: [Firmware Bug]: reg 0x10: invalid BAR
> (can't size)

These are more worrisome.  We discover the size of a BAR by writing
all ones to it and reading it back, which tells us how many bits of
the BAR are hard-wired to zero.  This behavior is prescribed by the
PCI specs, so it's likely a hardware defect.

It's tagged as a "Firmware Bug" because sometimes this problem is a
consequence of a BIOS forgetting to configure something in the device
or forgetting to hide the device from the OS completely.  Possibly the
tag is a little too aggressive -- it's making assumptions that aren't
always true.

> To my eyes the above looks like linux was expecting a pre-enumerated
> bus. How can I tell linux to just enumerate everything and not be
> surprised? Ideally, I'd like this to be optional, in case a future
> boot loader might enumerate PCIe in order to netboot or whatever.
> 
> These warnings are also troubling, but seem to be a general weakness
> of the xilinx PCIe bridge:
> [    6.210000] pci 0000:02:01.0: BAR 7: no space for [io  size 0x1000]
> [    6.210000] pci 0000:02:01.0: BAR 7: failed to assign [io  size 0x1000]

This is because the xilinx host bridge doesn't support I/O space (it
could be that the hardware itself doesn't support it, or maybe the
Linux driver just doesn't support it).  In any event, you have no PCI
devices that actually require I/O space, so this doesn't hurt
anything.  The messages about "BAR 7" are really referring to the
bridge I/O windows, which Linux tries to configure by default.

I wish we had more informative messages about this situation, but it's
a little subtle to detect this situation, so we don't.

> Everything actually works in the end, so this is mostly a cosmetic concern.

Yeah, everything seems mostly working.  The "invalid BAR" things
*could* be an issue -- those registers are not what the PCI spec says
they should be.  Occasionally people put non-BAR registers where BARs
are supposed to be.  We write 0xffffffff to those registers (as the
spec says we must), and if they are non-BARs, we have no idea what
that might do, so it's possible it could break something.  See the
quirks that set non_compliant_bars for examples.

Bjorn
