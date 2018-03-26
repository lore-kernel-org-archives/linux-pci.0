Return-Path: <SRS0=HzDk=GQ=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=HzDk=GQ=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 26 Mar 2018 18:59:04 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
Message-ID: <20180326155904.GJ2703@lahna.fi.intel.com>
References: <20180322184840.E31D4247251@gemini.denx.de>
 <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com>
 <20180323084855.E3EAF247251@gemini.denx.de>
 <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com>
 <20180325122828.7FC55247245@gemini.denx.de>
 <20180326112647.GC2703@lahna.fi.intel.com>
 <20180326150050.086232476FF@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180326150050.086232476FF@gemini.denx.de>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 26, 2018 at 05:00:50PM +0200, Wolfgang Denk wrote:
> Dear Mika,
> 
> In message <20180326112647.GC2703@lahna.fi.intel.com> you wrote:
> >
> > > I have updated the information (lspci output, dmesg output) for all
> > > three boards here:
> > > 
> > > https://owncloud.denx.de/index.php/s/wXiCMMYJodGj5Kr
> > 
> > Looking at the MSI Tomahawk dmesg when you have the adaptec card
> > connected, the BIOS adds an additional ACPI SSDT table:
> > 
> > [    0.000000] ACPI: SSDT 0x000000008C039120 002611 (v02 PegSsd PegSsdt 00001000 INTL 20160422)
> > 
> > This is missing when LSI card is connected. There might be some sort of
> > preboot protocol or whitelist that prevents the root port to be enabled
> > in BIOS.
> > 
> > Wolfgang, could you also add acpidump output of these systems to that
> > share site?
> 
> Done.
> 
> [I hope this is what you need.  Fedora does not seem to provide the
> acpidump tool ready to use in any package, but I found the sources
> in the kcbench package.]

Yes, that's exactly what I wanted. Thanks!

> All three boards behave a bit different here, but see yourself...
> 
> [What they have in common is that none works as I would like to have
> it :-( ]

I compared DSDT of the MSI Tomahawk with Adaptec connected to LSI
connected and there is pretty much no difference. So the BIOS decides to
load that PegSsd SSDT table based on something else than what is in DSDT.

The Gigabyte AB350 does not do any tricks with the ACPI tables. However,
comparing dmesgs you can see that the kernel simply does not find anything
below the bridge.

Adaptec:
[    0.064806] pci 0000:04:04.0: PCI bridge to [bus 07-08]
[    0.064912] pci 0000:04:04.0:   bridge window [io  0xd000-0xdfff]
[    0.064915] pci 0000:04:04.0:   bridge window [mem 0xfd200000-0xfd3fffff]
[    0.065004] pci 0000:08:04.0: [9005:8017] type 00 class 0x010000
[    0.065050] pci 0000:08:04.0: reg 0x10: [io  0xd100-0xd1ff]
[    0.065077] pci 0000:08:04.0: reg 0x14: [mem 0xfd280000-0xfd281fff 64bit]
[    0.065095] pci 0000:08:04.0: reg 0x1c: [io  0xd000-0xd0ff]
[    0.065145] pci 0000:08:04.0: reg 0x30: [mem 0xfd200000-0xfd27ffff pref]
[    0.065312] pci 0000:07:00.0: PCI bridge to [bus 08]
[    0.065424] pci 0000:07:00.0:   bridge window [io  0xd000-0xdfff]
[    0.065429] pci 0000:07:00.0:   bridge window [mem 0xfd200000-0xfd2fffff]

LSI:
[    0.064312] pci 0000:04:04.0: PCI bridge to [bus 07]

I guess MSI Tomahawk BIOS enumerates PCI devices as well and perhaps it
disables the PegSsd SSDT table because it cannot find anything below the
PCI bridge 04:04.

So at this point I have no idea either what else you could try except
perhaps booting to Windows and see if it detects the LSI card.
