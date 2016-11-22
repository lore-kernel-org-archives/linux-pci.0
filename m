Return-Path: <jthumshirn@suse.de>
Return-Path: <jthumshirn@suse.de>
Date: Tue, 22 Nov 2016 11:56:47 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] pci: Don't set RCB bit in LNKCTL if the upstream
 bridge hasn't
Message-ID: <20161122105647.dyt5nsst2sqbdf4y@linux-x5ow.site>
References: <20161102223552.14776-1-jthumshirn@suse.de>
 <20161102223552.14776-2-jthumshirn@suse.de>
 <20161116181158.GB26600@bhelgaas-glaptop.roam.corp.google.com>
 <20161121165352.GM25762@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161121165352.GM25762@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 21, 2016 at 10:53:52AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 16, 2016 at 12:11:58PM -0600, Bjorn Helgaas wrote:
> > Hi Johannes,

[...]

> > 
> > If you get a chance, collect the /proc/iomem contents, too.  That's
> > not for this bug; it's because I'm curious about the
> > 
> >   ERST: Can not request [mem 0xb928b000-0xb928cbff] for ERST
> >   
> > problem in your dmesg log.

It's pasted at the end (not sure whether attaching works).

> 
> Oops, I goofed and forgot to clear RCB by default.
> Here's the fixed one.

So this version works :-). 

Do you plan to merge it for 4.9-rc7 or is it more 4.10 material?

Byte,
	Johannes

/proc/iomem:

00000000-00000fff : reserved
00001000-0009bfff : System RAM
0009c000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000fffff : PCI Bus 0000:00
  000c0000-000c7fff : Video ROM
  000c8000-000c8fff : Adapter ROM
  000c9000-000c9fff : Adapter ROM
  000ca000-000cafff : Adapter ROM
  000cb000-000cbfff : Adapter ROM
  000cc000-000d3bff : Adapter ROM
  000e0000-000fffff : reserved
    000f0000-000fffff : System ROM
00100000-b6a32fff : System RAM
  01000000-015e8742 : Kernel code
  015e8743-01d549ff : Kernel data
  01f57000-021cefff : Kernel bss
b6a33000-b6a41fff : reserved
b6a42000-b7ffefff : System RAM
b7fff000-b83fefff : reserved
b83ff000-ba3fefff : ACPI Non-volatile Storage
ba3ff000-ba7a7fff : ACPI Tables
ba7a8000-ba7fffff : System RAM
ba800000-bb7fffff : RAM buffer
bb800000-cfffffff : reserved
  c0000000-cfffffff : PCI MMCONFIG 0000 [bus 00-ff]
d0004000-d0004fff : dmar3
d0007000-d3ffffff : PCI Bus 0000:00
  d0100000-d02fffff : PCI Bus 0000:11
  d0300000-d04fffff : PCI Bus 0000:17
  d20fd000-d20fdfff : 0000:00:05.4
  d20fe000-d20fe3ff : 0000:00:1a.0
    d20fe000-d20fe3ff : ehci_hcd
  d20ff000-d20ff3ff : 0000:00:1d.0
    d20ff000-d20ff3ff : ehci_hcd
  d2100000-d22fffff : PCI Bus 0000:01
    d2100000-d213ffff : 0000:01:00.0
    d2140000-d217ffff : 0000:01:00.1
    d2180000-d21bffff : 0000:01:00.2
    d21f0000-d21f3fff : 0000:01:00.0
      d21f0000-d21f3fff : igb
    d21f4000-d21f7fff : 0000:01:00.1
      d21f4000-d21f7fff : igb
    d21f8000-d21fbfff : 0000:01:00.2
      d21f8000-d21fbfff : igb
    d21fc000-d21fffff : 0000:01:00.3
      d21fc000-d21fffff : igb
    d2200000-d223ffff : 0000:01:00.0
      d2200000-d223ffff : igb
    d2240000-d227ffff : 0000:01:00.1
      d2240000-d227ffff : igb
    d2280000-d22bffff : 0000:01:00.2
      d2280000-d22bffff : igb
    d22c0000-d22fffff : 0000:01:00.3
      d22c0000-d22fffff : igb
  d2300000-d24fffff : PCI Bus 0000:07
    d23f0000-d23fffff : 0000:07:00.0
      d23f0000-d23fffff : megasas: LSI
    d2400000-d24fffff : 0000:07:00.0
  d2500000-d25fffff : PCI Bus 0000:1d
    d25fe000-d25fffff : 0000:1d:00.0
      d25fe000-d25fffff : xhci-hcd
  d2600000-d2ffffff : PCI Bus 0000:18
    d2600000-d2ffffff : PCI Bus 0000:19
      d2600000-d26fffff : PCI Bus 0000:1c
      d2700000-d2ffffff : PCI Bus 0000:1a
        d2700000-d2ffffff : PCI Bus 0000:1b
          d27fc000-d27fffff : 0000:1b:00.0
          d27fc000-d27fffff : mgadrmfb_mmio
          d2800000-d2ffffff : 0000:1b:00.0
  d3000000-d3ffffff : PCI Bus 0000:18
    d3000000-d3ffffff : PCI Bus 0000:19
      d3000000-d3ffffff : PCI Bus 0000:1a
        d3000000-d3ffffff : PCI Bus 0000:1b
          d3000000-d3ffffff : 0000:1b:00.0
          d3000000-d3ffffff : mgadrmfb_vram
d4000000-d4000fff : dmar0
d4003000-dbffffff : PCI Bus 0000:40
  d4100000-d42fffff : PCI Bus 0000:51
  d76ff000-d76fffff : 0000:40:05.4
  d7700000-d77fffff : PCI Bus 0000:41
    d7700000-d77fffff : 0000:41:00.0
  d7800000-db7fffff : PCI Bus 0000:47
  db800000-dbffffff : PCI Bus 0000:41
    db800000-dbffffff : 0000:41:00.0
dc000000-dc000fff : dmar1
dc003000-ebffffff : PCI Bus 0000:80
  dffff000-dfffffff : 0000:80:05.4
  e0000000-e3ffffff : PCI Bus 0000:81
  e4000000-e7ffffff : PCI Bus 0000:8b
  e8000000-ebffffff : PCI Bus 0000:95
ec000000-ec000fff : dmar2
ec003000-fbffffff : PCI Bus 0000:c0
  effff000-efffffff : 0000:c0:05.4
  f0000000-f3ffffff : PCI Bus 0000:c1
  f4000000-f7ffffff : PCI Bus 0000:cb
  f8000000-fbffffff : PCI Bus 0000:d5
fec00000-fecfffff : PNP0003:00
  fec00000-fec003ff : IOAPIC 0
  fec01000-fec013ff : IOAPIC 1
  fec21000-fec213ff : IOAPIC 2
  fec41000-fec413ff : IOAPIC 3
  fec61000-fec613ff : IOAPIC 4
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed12000-fed1200f : pnp 00:01
fed12010-fed1201f : pnp 00:01
fed1b000-fed1bfff : pnp 00:01
fed1c000-fed1ffff : reserved
  fed1f410-fed1f414 : iTCO_wdt.0.auto
fed45000-fed8bfff : pnp 00:01
fee00000-feefffff : pnp 00:01
  fee00000-fee00fff : Local APIC
ff000000-ffffffff : reserved
  ff000000-ffffffff : pnp 00:01
100000000-803fffffff : System RAM
20000000000-23fffffffff : PCI Bus 0000:00
  20000000000-200001fffff : PCI Bus 0000:07
  20000200000-200003fffff : PCI Bus 0000:11
  20000400000-200005fffff : PCI Bus 0000:17
  20000600000-200007fffff : PCI Bus 0000:1d
  23fffee0000-23fffee3fff : 0000:00:04.0
    23fffee0000-23fffee3fff : ioatdma
  23fffee4000-23fffee7fff : 0000:00:04.1
    23fffee4000-23fffee7fff : ioatdma
  23fffee8000-23fffeebfff : 0000:00:04.2
    23fffee8000-23fffeebfff : ioatdma
  23fffeec000-23fffeeffff : 0000:00:04.3
    23fffeec000-23fffeeffff : ioatdma
  23fffef0000-23fffef3fff : 0000:00:04.4
    23fffef0000-23fffef3fff : ioatdma
  23fffef4000-23fffef7fff : 0000:00:04.5
    23fffef4000-23fffef7fff : ioatdma
  23fffef8000-23fffefbfff : 0000:00:04.6
    23fffef8000-23fffefbfff : ioatdma
  23fffefc000-23fffefffff : 0000:00:04.7
    23fffefc000-23fffefffff : ioatdma
  23ffff00000-23fffffffff : PCI Bus 0000:01
    23ffff00000-23ffff1ffff : 0000:01:00.0
    23ffff20000-23ffff3ffff : 0000:01:00.0
    23ffff40000-23ffff5ffff : 0000:01:00.1
    23ffff60000-23ffff7ffff : 0000:01:00.1
    23ffff80000-23ffff9ffff : 0000:01:00.2
    23ffffa0000-23ffffbffff : 0000:01:00.2
    23ffffc0000-23ffffdffff : 0000:01:00.3
    23ffffe0000-23fffffffff : 0000:01:00.3
24000000000-27fffffffff : PCI Bus 0000:40
  24000000000-240001fffff : PCI Bus 0000:51
  26ffffe0000-26ffffe3fff : 0000:40:04.0
    26ffffe0000-26ffffe3fff : ioatdma
  26ffffe4000-26ffffe7fff : 0000:40:04.1
    26ffffe4000-26ffffe7fff : ioatdma
  26ffffe8000-26ffffebfff : 0000:40:04.2
    26ffffe8000-26ffffebfff : ioatdma
  26ffffec000-26ffffeffff : 0000:40:04.3
    26ffffec000-26ffffeffff : ioatdma
  26fffff0000-26fffff3fff : 0000:40:04.4
    26fffff0000-26fffff3fff : ioatdma
  26fffff4000-26fffff7fff : 0000:40:04.5
    26fffff4000-26fffff7fff : ioatdma
  26fffff8000-26fffffbfff : 0000:40:04.6
    26fffff8000-26fffffbfff : ioatdma
  26fffffc000-26fffffffff : 0000:40:04.7
    26fffffc000-26fffffffff : ioatdma
  27000000000-27fffffffff : PCI Bus 0000:47
28000000000-2bfffffffff : PCI Bus 0000:80
  28ffffe0000-28ffffe3fff : 0000:80:04.0
    28ffffe0000-28ffffe3fff : ioatdma
  28ffffe4000-28ffffe7fff : 0000:80:04.1
    28ffffe4000-28ffffe7fff : ioatdma
  28ffffe8000-28ffffebfff : 0000:80:04.2
    28ffffe8000-28ffffebfff : ioatdma
  28ffffec000-28ffffeffff : 0000:80:04.3
    28ffffec000-28ffffeffff : ioatdma
  28fffff0000-28fffff3fff : 0000:80:04.4
    28fffff0000-28fffff3fff : ioatdma
  28fffff4000-28fffff7fff : 0000:80:04.5
    28fffff4000-28fffff7fff : ioatdma
  28fffff8000-28fffffbfff : 0000:80:04.6
    28fffff8000-28fffffbfff : ioatdma
  28fffffc000-28fffffffff : 0000:80:04.7
    28fffffc000-28fffffffff : ioatdma
  29000000000-29fffffffff : PCI Bus 0000:95
  2a000000000-2afffffffff : PCI Bus 0000:8b
  2b000000000-2bfffffffff : PCI Bus 0000:81
2c000000000-2ffffffffff : PCI Bus 0000:c0
  2cffffe0000-2cffffe3fff : 0000:c0:04.0
    2cffffe0000-2cffffe3fff : ioatdma
  2cffffe4000-2cffffe7fff : 0000:c0:04.1
    2cffffe4000-2cffffe7fff : ioatdma
  2cffffe8000-2cffffebfff : 0000:c0:04.2
    2cffffe8000-2cffffebfff : ioatdma
  2cffffec000-2cffffeffff : 0000:c0:04.3
    2cffffec000-2cffffeffff : ioatdma
  2cfffff0000-2cfffff3fff : 0000:c0:04.4
    2cfffff0000-2cfffff3fff : ioatdma
  2cfffff4000-2cfffff7fff : 0000:c0:04.5
    2cfffff4000-2cfffff7fff : ioatdma
  2cfffff8000-2cfffffbfff : 0000:c0:04.6
    2cfffff8000-2cfffffbfff : ioatdma
  2cfffffc000-2cfffffffff : 0000:c0:04.7
    2cfffffc000-2cfffffffff : ioatdma
  2d000000000-2dfffffffff : PCI Bus 0000:d5
  2e000000000-2efffffffff : PCI Bus 0000:cb
  2f000000000-2ffffffffff : PCI Bus 0000:c1

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
