Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 8 Oct 2015 09:47:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Meelis Roos <mroos@linux.ee>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
Message-ID: <20151008144744.GA3885@localhost>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
 <CAE9FiQXwqvg0X7j6Ccek+ZU+uhCoxy5myXfU2W9AFzedUoO8nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXwqvg0X7j6Ccek+ZU+uhCoxy5myXfU2W9AFzedUoO8nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 07, 2015 at 04:16:37PM -0700, Yinghai Lu wrote:
> On Wed, Oct 7, 2015 at 2:25 AM, Meelis Roos <mroos@linux.ee> wrote:
> > amd64 machine:
> >
> > http://kodu.ut.ee/~mroos/dm/dm.x2100
> 
> [    0.156360] bus: [bus 00-05] on node 0 link 0
> [    0.156362] bus: 00 [io  0x0000-0xffff]
> [    0.156364] bus: 00 [mem 0x000a0000-0x000bffff]
> [    0.156365] bus: 00 [mem 0xfe030000-0xffffffff]
> [    0.156366] bus: 00 [mem 0xc0000000-0xefffffff]
> [    0.156368] bus: 00 [mem 0xf0000000-0xfe02ffff]
> [    0.156369] bus: 00 [mem 0x140000000-0xfcffffffff]
> 
> [    0.174069] PCI: Using host bridge windows from ACPI; if necessary,
> use "pci=nocrs" and report a bug
> [    0.180821] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-05])
> [    0.180943] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> ClockPM Segments MSI]
> [    0.181139] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> [    0.181917] PCI host bridge to bus 0000:00
> [    0.182030] pci_bus 0000:00: root bus resource [bus 00-05]
> [    0.182144] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
> [    0.182262] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
> [    0.182379] pci_bus 0000:00: root bus resource [io  0x6000-0xffff window]
> [    0.182494] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
> [    0.182609] pci_bus 0000:00: root bus resource [mem
> 0x000a0000-0x000bffff window]
> [    0.182799] pci_bus 0000:00: root bus resource [mem
> 0xc0000000-0xdfffffff window]
> [    0.182989] pci_bus 0000:00: root bus resource [mem
> 0xf0000000-0xfe02ffff window]
> [    0.183179] pci_bus 0000:00: root bus resource [mem
> 0xfeb00000-0xfebfffff window]
> 
> BIOS report different resource from _CRS setting and setting with cpu registers.
> 
> [    0.183379] pci 0000:00:00.0: [10de:005e] type 00 class 0x058000
> [    0.183542] pci 0000:00:01.0: [10de:0050] type 00 class 0x060100

I don't know how the above two devices are related, since they don't
have any BARs at all.

But 00:01.1 does have two I/O BARs that are invalid per _CRS:

  pci 0000:00:01.1: can't claim BAR 4 [io  0x1c00-0x1c3f]: no compatible bridge window
  pci 0000:00:01.1: can't claim BAR 5 [io  0x1c40-0x1c7f]: no compatible bridge window

> root bus io range from _CRS does not include that.
> 
> boot with pci=nocrs should avoid that and it is safe as we get ranges
> from register.

As far as I'm concerned, it is not safe to use "pci=nocrs" in this
situation.  The BIOS programmed the hardware aperture
("bus: 00 [io 0x0000-0xffff]") *and* it explicitly excluded pieces of
that range when it told the OS what it could use.  The OS has to
assume the BIOS knows what it is doing and is using those excluded
ranges for something else, so it is *not* safe for the OS to put
devices there.

It's certainly possible and even likely that this is a BIOS defect.
But we cannot assume "pci=nocrs" is safe in general.

If you want to tell users to boot with "pci=nocrs", that's up to you.
Personally, I don't think that's an acceptable user experience.

Bjorn
