Return-Path: <SRS0=QWvV=DL=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=QWvV=DL=intel.com=keith.busch@kernel.org>
Date: Fri, 15 Dec 2017 08:08:51 -0700
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Maik Broemme <mbroemme@libmpq.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: Re: ASPM powersupersave change NVMe SSD Samsung 960 PRO capacity to
 0 and read-only
Message-ID: <20171215150851.GF26752@localhost.localdomain>
References: <20171214184701.GA6322@libmpq.org>
 <20171215002155.GR30595@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171215002155.GR30595@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 06:21:55PM -0600, Bjorn Helgaas wrote:
> [+cc Rajat, Keith, linux-kernel]
> 
> On Thu, Dec 14, 2017 at 07:47:01PM +0100, Maik Broemme wrote:
> > I have a Samsung 960 PRO NVMe SSD (Non-Volatile memory controller:
> > Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961). It
> > works fine until I enable powersupersave via
> > /sys/module/pcie_aspm/parameters/policy
> > 
> > ASPM is enabled in BIOS and works fine for all devices and in
> > powersave mode. I'm able to reproduce this always at any time while
> > the system is up and running via:
> > 
> > $> echo powersupersave > /sys/module/pcie_aspm/parameters/policy
> > 
> > The Linux kernel is 4.14.4 and APST for my device is working with
> > powersave. As soon as I enable powersupersave I get:
> > 
> > [11535.142755] dpc 0000:00:10.0:pcie010: DPC containment event, status:0x1f09 source:0x0000
> > [11535.142760] dpc 0000:00:10.0:pcie010: DPC unmasked uncorrectable error detected, remove downstream devices
> > [11535.159999] nvme0n1: detected capacity change from 1024209543168 to 0
> > ...
> 
> Can you start by opening a bug report at https://bugzilla.kernel.org,
> category Drivers/PCI, and attaching the complete "lspci -vv" output
> (as root) and the complete dmesg log?  Make sure you have a new enough
> lspci to decode the ASPM L1 Substates capability and the LTR bits.
> Source is at git://git.kernel.org/pub/scm/utils/pciutils/pciutils.git
> 
> powersupersave enables ASPM L1 Substates.  Rajat, do you have any
> ideas about this or how we might debug it?
>
> Keith, is this really all the information about the event that we can
> get out of DPC?  Is there some AER logging we might be able to get via
> "lspci -vv"?  Sounds like this is the boot disk, so Maik may not be
> able to run lspci after the DPC event.  If there *is* any AER info,
> can we connect up the DPC event so we can print the AER info from the
> kernel?

There should be information in the AER register. The base spec section
6.2.5 ("Sequence of Device Eror Signaling and Logging") says the
corresponding bit in the AER Uncorrectable Error Status register should
be set before triggerring DPC. The sequence ends with the DPC trigger,
so the Linux AER service was never notified to handle the event.

As an enhancement to the DPC driver, we may be able to enqueue an AER
event to see if that may provide additional details about the error. I can
implement that enhanmcement, and should have something for consideration
sometime in the next week.

On a side note, now that root ports are implementing DPC, we should
probably consult the platform for AER firmware first. The PCIe
specification strongly recommends linking DPC control to that of AER, so
I'll try to add that check as well.
