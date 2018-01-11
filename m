Return-Path: <SRS0=r7LY=EG=libmpq.org=mbroemme@kernel.org>
Return-Path: <SRS0=r7LY=EG=libmpq.org=mbroemme@kernel.org>
Date: Thu, 11 Jan 2018 18:50:40 +0100
From: Maik Broemme <mbroemme@libmpq.org>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ASPM powersupersave change NVMe SSD Samsung 960 PRO capacity to
 0 and read-only
Message-ID: <20180111175040.GJ1377@libmpq.org>
References: <20171214184701.GA6322@libmpq.org>
 <20171215002155.GR30595@bhelgaas-glaptop.roam.corp.google.com>
 <CACK8Z6HyBgNdav_Atzpxe1RGvpviJF2vsLhkgATjL2B7GnYnwg@mail.gmail.com>
 <20171215190126.GI19904@libmpq.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171215190126.GI19904@libmpq.org>
List-ID: <linux-pci.vger.kernel.org>

Hi Rajat,

On Dec 15, 2017, at 20:01, Maik Broemme <mbroemme@libmpq.org> wrote:
> Hi Rajat,
> 
> On Dec 15, 2017, at 18:33, Rajat Jain <rajatja@google.com> wrote:
> > On Thu, Dec 14, 2017 at 4:21 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > [+cc Rajat, Keith, linux-kernel]
> > >
> > > On Thu, Dec 14, 2017 at 07:47:01PM +0100, Maik Broemme wrote:
> > >> I have a Samsung 960 PRO NVMe SSD (Non-Volatile memory controller:
> > >> Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961). It
> > >> works fine until I enable powersupersave via
> > >> /sys/module/pcie_aspm/parameters/policy
> > >>
> > >> ASPM is enabled in BIOS and works fine for all devices and in
> > >> powersave mode. I'm able to reproduce this always at any time while
> > >> the system is up and running via:
> > >>
> > >> $> echo powersupersave > /sys/module/pcie_aspm/parameters/policy
> > >>
> > >> The Linux kernel is 4.14.4 and APST for my device is working with
> > >> powersave. As soon as I enable powersupersave I get:
> > >>
> > >> [11535.142755] dpc 0000:00:10.0:pcie010: DPC containment event, status:0x1f09 source:0x0000
> > >> [11535.142760] dpc 0000:00:10.0:pcie010: DPC unmasked uncorrectable error detected, remove downstream devices
> > >> [11535.159999] nvme0n1: detected capacity change from 1024209543168 to 0
> > >> ...
> > >
> > > Can you start by opening a bug report at https://bugzilla.kernel.org,
> > > category Drivers/PCI, and attaching the complete "lspci -vv" output
> > > (as root) and the complete dmesg log?  Make sure you have a new enough
> > > lspci to decode the ASPM L1 Substates capability and the LTR bits.
> > > Source is at git://git.kernel.org/pub/scm/utils/pciutils/pciutils.git
> > >
> > > powersupersave enables ASPM L1 Substates.  Rajat, do you have any
> > > ideas about this or how we might debug it?
> > 
> > 
> > I know Maik mentioned that this is the boot device. Maik, is it
> > possible to boot off something else so that we can do some more
> > experiments on this port? If so,
> > - can you try to see if the device comes back if you switch the ASPM
> > policy back from "powersupersave" -> powersave, and potentially do a
> > rescan (echo 1 > /sys/bus/pci/rescan)?
> 
> Yes it is possible, will do later today.
> 

I've re-run the test with 4.15rc7.r111.g5f615b97cdea and the following
patches from Keith:

[PATCH 1/4] PCI/AER: Return approrpiate value when AER is not supported
[PATCH 2/4] PCI/AER: Provide API for getting AER information
[PATCH 3/4] PCI/DPC: Enable DPC in conjuction with AER
[PATCH 4/4] PCI/DPC: Print AER status in DPC event handling

The issue is still the same. Additionally to the output before I see now:

Jan 11 18:34:45 server.theraso.int kernel: dpc 0000:00:10.0:pcie010: DPC containment event, status:0x1f09 source:0x0000
Jan 11 18:34:45 server.theraso.int kernel: dpc 0000:00:10.0:pcie010: DPC unmasked uncorrectable error detected, remove downstream devices
Jan 11 18:34:45 server.theraso.int kernel: pcieport 0000:00:10.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0080(Receiver ID)
Jan 11 18:34:45 server.theraso.int kernel: pcieport 0000:00:10.0:   device [8086:19aa] error status/mask=00000020/00000000
Jan 11 18:34:45 server.theraso.int kernel: pcieport 0000:00:10.0:    [ 5] Surprise Down Error    (First)
Jan 11 18:34:46 server.theraso.int kernel: nvme0n1: detected capacity change from 1024209543168 to 0

> > - It would be good to get the complete lspci -vv for the root port
> > (assuming device is connected to root port i.e. no switch).
> > Specifically what does the Link status show?
> > - Also, do you know if your root port provides any debug registers
> > that could tell the current L1 substate of the link (My system's root
> > port had such register).
> > - I had usually resorted to a PCIe analyzer to peak at the packets
> > when I was debugging it. Not sure if that is an option here.
> > 
> > I don't see any debug prints in aspm.c that we could enable. Even if I
> > provide a patch, I suspect that the problem will start at the last
> > step of the pcie_config_aspm_l1ss() i.e. as soon as we really enable
> > it in HW. Maik, would you be open to take a debug patch that adds some
> > debug prints and try it out (compile your kernel with that patch)?
> > 
> 
> Sure that is fine. I will also re-run later today with 4.15rc3.
> 
> > >
> > > Keith, is this really all the information about the event that we can
> > > get out of DPC?  Is there some AER logging we might be able to get via
> > > "lspci -vv"?  Sounds like this is the boot disk, so Maik may not be
> > > able to run lspci after the DPC event.  If there *is* any AER info,
> > > can we connect up the DPC event so we can print the AER info from the
> > > kernel?
> > >
> > > I wonder if there's some way improper L1 Substate configuration could
> > > cause a DPC event.  There are lots of knobs there that seem to depend
> > > on devices, and I'm not sure we have them all correct yet.
> > >
> > > There are some recent changes in that area that are in linux-next:
> > >
> > >   PCI/ASPM: Enable Latency Tolerance Reporting when supported
> > >   PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
> > >   PCI/ASPM: Use correct capability pointer to program LTR_L1.2_THRESHOLD
> > >   PCI/ASPM: Account for downstream device's Port Common_Mode_Restore_Time
> > >
> > > It's conceivable that they could have some bearing on this problem.
> > > If you could give this a whirl on linux-next, that would be
> > > interesting.  If you do this, please also collect the "lspci -vv"
> > > output there so we can compare it with the v4.14 configuration.
> > >
> > >> It looks like APST feature cannot be set anymore after enabling
> > >> powersupersave. Also the PCIe device disappears completely
> > >> from lspci output.
> > >
> > > My guess is this is to be expected after the DPC event.  That
> > > basically disconnects the PCIe device from the system.
> > >
> > >> Any idea why the device is failing with powersupersave and how to avoid
> > >> it? Especially how to enable it but skip certain broken devices as this
> > >> is my boot device.
> > >
> > > We could conceivably add a quirk if we find that L1SS is broken on
> > > this particular device.  But L1SS is so new that I'd be more
> > > suspicious of the Linux code than the device.
> > >
> > > Bjorn
> > 
> 
> --Maik

--Maik
