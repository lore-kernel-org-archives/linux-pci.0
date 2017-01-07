Return-Path: <SRS0=nVb9=YV=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=nVb9=YV=linux.intel.com=mika.westerberg@kernel.org>
Date: Sat, 7 Jan 2017 08:50:53 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>, Peter Wu <peter@lekensteyn.nl>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170107065053.GL3353@lahna.fi.intel.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170104210954.GA11946@al>
 <20170105144220.GA21446@wunner.de>
 <2634193.tHuT6mNBBA@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2634193.tHuT6mNBBA@aspire.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 06, 2017 at 02:21:11AM +0100, Rafael J. Wysocki wrote:
> On Thursday, January 05, 2017 03:42:20 PM Lukas Wunner wrote:
> > On Wed, Jan 04, 2017 at 10:09:54PM +0100, Peter Wu wrote:
> > > [ Help/ideas are welcome, I suspect that these failures to restore power
> > > on laptops designed for Win8+ all have the same cause, related to some
> > > unknown interaction between ACPI and PCI. Some links:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=190861
> > > https://bugzilla.kernel.org/show_bug.cgi?id=156341 ]
> > 
> > Looking at Kilian's acpidump again I notice that the methods to power
> > the GPU on or off (GPON / GPOF) are called from two places:
> > 
> > - From the _PS0 and _PS3 methods of the GPU and
> > - from the _PR3 power resource of the root port above the GPU.
> > 
> > In the former case they're called for pre Windows 2013 or if VDAD is true.
> > In the latter case they're called unconditionally but GPOF becomes a no-op
> > in the pre Windows 2013 case.
> > 
> > This means that GPOF would be executed *twice* on Windows 2013+ if VDAD
> > is true.  I could imagine this to cause issues.
> 
> Right.  Exactly my observation (http://marc.info/?l=linux-pci&m=148362622326066&w=2).
> 
> So on (newer) Windows something is done in order to make it work in addition to
> the _PR3 _OSC handshake.
> 
> So, I'd like to try to follow the Mika's suggestion to use the response we get
> from the _OSC handshake for \_SB and if that says "no _PR3", ignore power
> resources for PCIe ports at least.

Kilian send the dmesg back to me and unfortunately the BIOS on that
machine acks use of _PR3:

[    0.699776] ACPI: Added _OSI(Module Device)
[    0.699777] ACPI: Added _OSI(Processor Device)
[    0.699777] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.699778] ACPI: Added _OSI(Processor Aggregator Device)
[    0.699783] ACPI : EC: EC started
[    0.700466] ACPI: \: Used as first EC
[    0.700467] ACPI: \: GPE=0x11, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.700468] ACPI: \: Used as boot ECDT EC to handle transactions
[    0.703905] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.880246] ACPI: \_SB_: Supported caps: 0x0000009f
[    0.880278] ACPI: \_SB_: Acked caps: 0x0000009f (_PR3: on)

So ignoring _PR3 based on that will not solve the issue :-(
