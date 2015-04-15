Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 15 Apr 2015 18:04:55 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tony Luck <tony.luck@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-acpi <linux-acpi@vger.kernel.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH v1 2/4] PCI: Mark invalid BARs as unassigned
Message-ID: <20150415230455.GB27352@google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150312173533.1052.46464.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CA+8MBbJv-RwX_RDzk85X_sHAHUG6cTsCAKd-_iE7wrdQ9wYKsQ@mail.gmail.com>
 <CAErSpo6PV7+cZKgDPBA7tDn4oyp_hONqJFegTFxVLz2KaTeK4A@mail.gmail.com>
 <CA+8MBbLnFQ2_zWniBFN6=kJMo-3PbBQvdsfPFV+zyApYpN6BQA@mail.gmail.com>
 <20150415144819.GD19151@google.com>
 <CA+8MBbJEf9gOyWq_Urw3T5s7jj2-2pHkuQRcn9X3TxSYYUK5ZA@mail.gmail.com>
 <20150415194226.GA27352@google.com>
 <CA+8MBb++T5MEtCbcduxym08MPjDF7pCj50Ae2Mvw2U0a-gkb2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+8MBb++T5MEtCbcduxym08MPjDF7pCj50Ae2Mvw2U0a-gkb2A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 15, 2015 at 02:28:08PM -0700, Tony Luck wrote:
> On Wed, Apr 15, 2015 at 12:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > I think we're about to conclude that the Producer/Consumer bit is useless
> > and should be ignored.
> >
> > Can you drop the previous debug patch and try this one?
> 
> That producer/consumer thing sounds horribly familiar ... did we venture along
> this path before many years ago?

463eb297401e ("[IA64] respect ACPI producer/consumer flag for PCI root
bridges") from 2005 added this check.  There's also been recent discussion
about Jiang's patches and how to handle that bit in some more generic code
[1].

I think if we strictly follow the spec, it is correct to check the
producer/consumer bit.  If we don't check the bit, we are basically
assuming that all Address Space Resource Descriptors are windows that are
forwarded downstream, and I don't think there's a way for a host bridge to
use those descriptors to describe its own CSR space.

But either we haven't figured out how to interpret producer/consumer
correctly, or BIOSes haven't used it consistently, and we end up with
problems like this one.  So I suspect we'll have to give up and just
ignore the producer/consumer bit.

> I applied the new patch on top of Linus latest (from this morning
> HEAD=6c373ca89399c5a3f7ef210ad8f63dc3437da345) without any
> reverts.  System booted OK with both disks online and networking
> functional).

This looks better ... I think.  Here's the change this patch makes:

   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
   acpi PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
   acpi PNP0A08:00: host bridge window [io  0x1000-0x8fff]
  +acpi PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
  +acpi PNP0A08:00: host bridge window [mem 0x000c0000-0x000fffff]
  +acpi PNP0A08:00: host bridge window [mem 0xfec00000-0xfec3ffff]
  +acpi PNP0A08:00: host bridge window [mem 0xfed1c000-0xfed1c0ff]
  +acpi PNP0A08:00: host bridge window [mem 0xfed40000-0xfedfffff]
   acpi PNP0A08:00: host bridge window [mem 0x50000000-0x9fffffff]
  +acpi PNP0A08:00: host bridge window [mem 0x10000000000-0x100fffffffe]
  +acpi PNP0A08:00: host bridge window [mem 0x10100000000-0x101fffffffe]
  +acpi PNP0A08:00: host bridge window [mem 0x10200000000-0x102fffffffe]
  +acpi PNP0A08:00: host bridge window [mem 0x10300000000-0x103fffffffe]

   ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-ff])
   acpi PNP0A08:01: host bridge window [io  0x9000-0xfffe]
  +acpi PNP0A08:01: host bridge window [mem 0xfec40000-0xfec7ffff]
  +acpi PNP0A08:01: host bridge window [mem 0xa0000000-0xefffffff]
  +acpi PNP0A08:01: host bridge window [mem 0x10400000000-0x104fffffffe]
  +acpi PNP0A08:01: host bridge window [mem 0x10500000000-0x105fffffffe]
  +acpi PNP0A08:01: host bridge window [mem 0x10600000000-0x106fffffffe]
  +acpi PNP0A08:01: host bridge window [mem 0x10700000000-0x107fffffffe]

The addition of the [mem 0xa0000000-0xefffffff] window for PCI1, which we
previously ignored, is what makes your igb and mptsas devices work again.

It concerns me a little bit that the BIOS apparently did set the producer
bit for the PCI0 [mem 0x50000000-0x9fffffff] window, but not for any of
the other windows, not even the ones that fit in 32 bits.  But maybe that
inconsistency is just a little BIOS lint that doesn't mean anything.

Anyway, I guess I'll package up this patch and post it.

Bjorn

[1] http://lkml.kernel.org/r/20150404030411.GG10892@google.com

