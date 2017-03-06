Return-Path: <SRS0=crXP=2P=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=crXP=2P=free.fr=slash.tmp@kernel.org>
Subject: Re: Using the generic host PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Rob Herring <robh@kernel.org>, Phuong Nguyen
 <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 David Laight <david.laight@aculab.com>
References: <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
 <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
 <258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr>
 <20170303154628.GA21522@bhelgaas-glaptop.roam.corp.google.com>
 <8e1a0b5d-8dfb-4be1-a049-b16892a6c0d0@free.fr>
 <20170303200407.GB30375@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <267ec246-c32a-e0e2-b708-304a3dfb7342@free.fr>
Date: Mon, 6 Mar 2017 17:12:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170303200407.GB30375@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 03/03/2017 21:04, Bjorn Helgaas wrote:

> On Fri, Mar 03, 2017 at 06:18:02PM +0100, Mason wrote:
>
>> # /usr/sbin/lspci -v
>> 00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
>>         Flags: bus master, fast devsel, latency 0
>>         Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>         I/O behind bridge: 00000000-00000fff
> 
> Something's wrong with this.  You have no I/O windows through the host
> bridge, which implies that you can't generic PCI I/O transactions, so
> this I/O window should be disabled.  This might be an lspci issue;
> what does "lspci -xxx" show?
> 
>>         Memory behind bridge: 91000000-910fffff
>>         Prefetchable memory behind bridge: 00000000-000fffff
> 
> This prefetchable memory window is bogus, too.  It should probably be
> disabled.  If the bridge doesn't support a prefetchable window, the
> base and limit should be hardwired to zero.  If it supports a window
> but it's disabled, the limit should be less than the base.  For
> example, on my system I see this for a bridge with the window
> disabled:
> 
>   # setpci -s00:1c.0 PREF_MEMORY_BASE
>   fff1
>   # setpci -s00:1c.0 PREF_MEMORY_LIMIT
>   0001

MAJOR UPDATE: As pointed out by Ard, my DT was hopelessly wrong for
the non-prefetchable memory region (in the ranges prop).

In fact, my platform *multiplexes* config and MEM spaces.

In other words, there are *two* overlapping 256 MB windows at CPU
address 0x50000000. A register in MMIO space allows software to
select either config space or MEM space.

Current DT node:

		pcie@50000000 {
			compatible = "pci-host-ecam-generic";
			reg = <0x50000000 0x10000000>;
			device_type = "pci";
			#size-cells = <2>;
			#address-cells = <3>;
			#interrupt-cells = <1>;
			ranges = <0x02000000 0x0 0x0  0x50000000  0x0 0x10000000>;
		};


Ard pointed out that Linux does not support such a setup.

[    0.994011] OF: PCI: host bridge /soc/pcie@50000000 ranges:
[    0.999721] OF: PCI: Parsing ranges property...
[    1.004386] OF: PCI:   MEM 0x50000000..0x5fffffff -> 0x00000000
[    1.010471] pci-host-generic 50000000.pcie:
		can't claim ECAM area [mem 0x50000000-0x5fffffff]:
		address conflict with /soc/pcie@50000000 [mem 0x50000000-0x5fffffff]
[    1.025265] pci-host-generic: probe of 50000000.pcie failed with error -16

IIUC, there may be concurrent accesses to config space and MEM space?

I'm wondering what my options are for this controller at this point :-(

In a separate (related) thread ("Panic in quirk_usb_early_handoff",
David Laight wrote:

> So to do a config space access you have to use a pair of IPIs
> to stop the other cpus doing any PCIe data accesses while the
> MMIO bit makes the accesses all point to config space.
> (After taking a lock to get access to the MMIO register.)
> 
> Or has someone a better idea?

Regards.
