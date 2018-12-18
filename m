Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E352C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 10:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9602184C
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 10:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeLRKVz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:21:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbeLRKVz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 05:21:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC8B76CA9961B;
        Tue, 18 Dec 2018 18:21:49 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 18:21:40 +0800
Date:   Tue, 18 Dec 2018 10:21:27 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Shaokun Zhang" <zhangshaokun@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>, <linuxarm@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex.umansky@huawei.com>,
        <Eric.Wehage@huawei.com>, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 2/2] PCI/portdrv Hisilicon PCIe transport layer Port
 PMU driver.
Message-ID: <20181218102127.0000018e@huawei.com>
In-Reply-To: <20181217181915.GL20725@google.com>
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
        <20181214131055.52253-3-Jonathan.Cameron@huawei.com>
        <20181214235505.GI20725@google.com>
        <20181217110906.0000003f@huawei.com>
        <20181217181915.GL20725@google.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 17 Dec 2018 12:19:15 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Logan for incidental Switchtec question below]
> 
> On Mon, Dec 17, 2018 at 11:09:06AM +0000, Jonathan Cameron wrote:
> > On Fri, 14 Dec 2018 17:55:05 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > On Fri, Dec 14, 2018 at 09:10:55PM +0800, Jonathan Cameron wrote:  
> > > > The Hip08 SoCs contain relatively detailed performance units for the
> > > > PCIe Transport Layer at each port.
> > > > 
> > > > The support here is a subset of what will come, but is intended to
> > > > provide some initial basic functionality.
> > > > 
> > > > Note that there is a _lot_ more functionality in this hardware unit
> > > > so this is the first RFC of several.
> > > > 
> > > > RFC questions:
> > > > 
> > > > 1. There is no standard for PCIe PMUs.  However, there are things that
> > > >    are elements of the PCIe protocol so any similar PMU is likely to
> > > >    support them.  Do we want to have a go at some consistent naming?    
> > > 
> > > Is this a perf question, i.e., are you asking about the event names
> > > from "perf list"?  If so, I have no idea :)  But you're right that the
> > > events on the PCIe side are mostly defined by the PCIe spec and I
> > > agree it would make a lot of sense to use common names for those
> > > things.  
> > 
> > Exactly that.  It's nice if users know what they are getting rather than
> > having lots of subtly different variants of posted write tlp counters etc.
> > Ideally this would be defined by the PCI SIG in a similar fashion to
> > architectural counters on Arm, but they aren't yet...
> > 
> > I'm far from an expert on PCIe but I can pull in some of our PCI hardware
> > people and see if I can sketch out some docs for what a hypothetical
> > magic PMU could count, then working out a naming scheme to cover that.
> > +CC Alex and Eric. 
> > 
> > We have things like bandwidth estimation and credits statistics to
> > potentially consider as well.  Right now I can only find limited precedence
> > for handling that sort of a thing in PMUs in general (there are similar
> > things in Intel's graphics drivers).
> >   
> > > > 2. We are using an ACPI DSDT description to find what is basically a
> > > >    platform device that is associated with a PCIe device. Is this an
> > > >    acceptable thing to do?    
> > > 
> > > If the PCIe device itself, e.g., a Root Port, consumes address space,
> > > it should have a BAR that describes it.  
> > 
> > I agree that would be the ideal / right way. Here we have an oddity
> > because the port is in the host SoC. It's not remotely compliant
> > with any standard.  We are looking at this for future hardware but I
> > don't think there is much we can do with this one.
> > 
> > Looking forwards, there isn't a huge amount of flexibility in port
> > definitions if we do want to put this in Bar space as only 2 Bars
> > available (type 1 config space header)  I have no idea if these are
> > in heavy use or not on existing hardware.  Looks like the Switchtec
> > parts use one of them.  I know from other activities that people get
> > very defensive of their BAR Space, particularly when looking to
> > retrofit in new versions of a long standing device.  
> 
> I *think* drivers/pci/switch/switchtec.c is for a type 0 endpoint that
> happens to be built into the switch, e.g., the type 1 bridge is
> function 0 and the type 0 management endpoint is function 1.  Logan,
> can you confirm/deny?

To bring the threads back together, Logan confirmed this.

> 
> The only use of BARs for type 1 devices that I'm aware of is portdrv
> (where a BAR may be used for MSI-X tables).  I'm sure there's other
> hardware out there that implements BARs, but I'm not aware of Linux
> drivers that use them.
> 
> This could be partly because Linux makes it very difficult for drivers
> to bind to these devices because portdrv is typically in the way.
> This is part of why I think we should rework portdrv so it's part of
> the core instead of binding as a driver.

That's certainly making sense to me as well.  Are we going to have issues
with backwards compatibility though?  It'll be fiddly to expose the existing
portdrv interface if this is reworked.  Probably possible though.

> 
> If the 2 BARs in type 1 devices is limiting, maybe multifunction
> devices as in the Switchtec parts is a possibility?


For some of the devices I'm looking at eating up functions is also
controversial :) They have an embedded switch and a 'lot' of functions.

People don't like spilling into additional bus numbers as that space is
also limited, so if you eat one of the 256 ARI functions they get annoyed.

One somewhat nasty trick might be to define a config space header
that tells you 'where' to find the PMU for a given port.  Pretty
much what MSIX does, but with the addition of a function number.

Down stream ports are trickier unless we assume their PMUs are in their
own bar space or that any reference to another function is one on the
upstream port.

There may also be advantages to doing it the other way around and have
the PMU function hold the cross referencing to the ports.  A port could
hold a reference to itself if it was all nicely integrated in the port
funciton.

Of course, another hardware design would have a unified counting system
for all downstream ports so describing that one is tricky as well.

Anyhow, that's a long term question and needs a lot of detailing filling in.

> 
> > > If the Root Complex, which is not a PCIe device and does not have an
> > > architected configuration or programming model, consumes address
> > > space, it would make sense to describe it via ACPI in the PNP0A03
> > > device like other host bridge registers.
> > > 
> > > From your cover letter, I think you have the latter situation, and if
> > > I understand correctly, you have something like this in ACPI:
> > > 
> > >   PNP0A03       PCI host bridge
> > >     HISIxxxx    PMU registers for Root Port 00:1c.0
> > >     HISIxxxx    PMU registers for Root Port 00:1c.2
> > > 
> > > The PNP0A03 _CRS describes the address space it consumes, which
> > > comprises (1) the register space that operates the bridge itself,
> > > e.g., sets apertures, performs PCI config accesses, etc., and
> > > (2) space that is converted to PCI transactions on the downstream
> > > side.  
> > 
> > Pretty much as you describe.  Here, roughly speaking, is the relevant
> > DSDT blob.  We have to play the slightly odd trick to get the association
> > with the port.  Note this sort of trick is sometimes done for RCiEPs to
> > provide for things that aren't quite handled in standard way (stuff
> > around resets etc for example - often as a work around for a hardware
> > limitation in a particular version).
> > 
> > Device (PCI0)
> > {
> > 	Name (_HID, "PNP0A08")
> > 	Name (_UID, Zero)
> > 	Name (_CID, "PNP0A03")
> > 	Name (_SEG, Zero)
> > 	Name (_BBN, Zero)
> > 	Name (_CCA, One)
> > 	Name (_PRT, Package (0x18))
> > 	Device (BR00) {
> > 	/* This device has it's class set to be a bridge so binds to portdrv */
> > 		Name (_HID, "19E5A120")
> > 		Name (_ADR, 0)
> > 		Name (_CRS, ResourceTemplate () {
> > 			QwordMemory(
> >  				ResourceConsumer,
> > 				PosDecode,
> > 				MinFixed,
> > 				MaxFixed,
> > 				NonCacheable,
> > 				ReadWrite,
> > 				0,
> > 				0x148284000,
> > 				0x148284FFF,
> > 				0x0,
> > 				0x1000)
> > 		})
> > 	}
> > }
> >   
> > > So this feels a little strange to me because ACPI says the HISIxxxx
> > > devices are below the host bridge, but instead of consuming PCI
> > > address space, they consume part of the PNP0A03 register space.
> > > But maybe that makes sense in ACPI, I dunno.  
> > 
> > From a logical point of view, it doesn't really - this should have been
> > firmly tied to PCIe.  Note they 'also' provide regular PCIe accesses paths
> > as they are standard compliant for their normal role as 'dumb' Root Ports.
> > 
> > The lack of any standardization around PMUs basically means that
> > people do this sort of nastiness.  To be fair to them, our hardware
> > team never thought this one would be exposed in general when they designed
> > it.
> > 
> > The requirements came along later when some of us got fed up with
> > internal only tooling to access this stuff.  I also wanted to explore
> > the space as it has quite a few impacts on future hardware specifications.
> >   
> > > As far as I can tell, you don't actually need *anything* supplied by
> > > portdrv except the pcie_device.port, which you only use to find the
> > > ACPI companion device and to hang the devm_ things on.  
> > 
> > Pretty much.  The 'obvious' option would have been to just have this as
> > an uncore PMU (which are platform devices instantiated from ACPI) but
> > then we loose the association with the PCIe topology entirely.
> > This is how internal interconnect, cache, memory controllers PMUs
> > are handled on most Arm64 platforms for example.  There are ACPI bindings
> > that could be used similar to how we associate caches with their
> > CPU clusters, but they are (to my mind) less elegant that above.   
> 
> I don't quite understand how this association works or why you would
> lose it if you made these platform devices.  I naively imagined an
> ACPI/platform driver that would bind to "19E5A120" devices and use
> _ADR to find the related PCI address.  I assume perf just needs the
> PCI address to present meaningful output, not to actually operate on
> the kernel's pci_dev, right?

I think we'd have to define a new HISIXXXX ID instead as it won't bind a
platform driver to a PCI device.  The explicit structure of the PCIe bus
representation would go as well.

That's not really a problem, but still feels somewhat ugly given this
really is a PCIe device as these counters are reflecting the traffic
through the Port.  Having that port represented in two places is a bit ugly
but not unheard of.  SMMUV3 PMCG (the iommu counter) is only loosely tied
to the smmu it is counting on for example.

I don't really care which way we go on this particularly device, but
the problem will come back to bite us when the device is done entirely
on PCIe.

> 
> > That also won't work when future hardware does it in the PCIe domain
> > either via a BAR or some other approach.
> >   
> > > As written, hisi_pcie_pmu will bind to any Port, including Switch
> > > Ports as well as Root Ports.  It has a poor-man's match() built into
> > > hisi_pcie_pmu_probe(), which is sort of sub-optimal.  It would be
> > > nicer to have a real match() function run by the bus driver.  I know
> > > portdrv doesn't give you that, and since portdrv claims every Port
> > > itself, there's no good way for other drivers like this to get
> > > connected to Ports.  
> > 
> > Agreed.  As it currently stands it is a dirty hack ;)  I wondered about
> > putting a standard bus register / match approach in there but wanted
> > to get the discussion going before adding non trivial infrastructure
> > in portdrv that might scare people off ;). From your comments below
> > it sounds like we might want to more radically change how the port
> > driver stuff works anyway.  
> 
> Yep.  I don't want to extend portdrv with more register/match stuff.
> IMHO it's already broken because we have both "pci" and "pci_express"
> things in sysfs for the same piece of hardware.
> 
> > > Do you have a hotplug strategy yet?  PMUs in Switches below the Root
> > > Ports sound like a useful thing.  Since you bind to every Port, you
> > > will bind to hot-added Switch Ports, but unless you use ACPI hotplug,
> > > you won't have a chance to add ACPI companion devices for them.  
> > 
> > The ACPI hack is very much because our hardware doesn't do it 'right'.
> > This particular root port is always in the host anyway so we are fine here.
> > 
> > You certainly couldn't pull this trick with switches out in the fabric,
> > but then they hopefully don't provide a non PCI backdoor to read their
> > PMUs anyway.  PCI hotplug is causing me enough headaches elsewhere
> > that I hope it'll just work with anything we do here!  
> 
> If the counters were in the PCIe device, things could work the same
> way for both Root Ports and Switch Ports, and hotplug wouldn't be an
> issue.  I think that's the ideal direction and we should treat this
> current hardware as an exception.

Agreed.

> 
> > > > Not yet fully established.
> > > > 
> > > > 1. I haven't done enough testing with high performance devices to
> > > >    establish the 'minimum' frequency of the high resolution timer.
> > > >    It may be that we just end up dropping some of the counters
> > > >    because the load is too high to sample them often enough.
> > > >    Once the basic approach is established I'll run the numbers
> > > >    on this. These are up to Gen4x16 ports so things go pretty quick.
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >  drivers/pci/pcie/Kconfig         |   9 +
> > > >  drivers/pci/pcie/Makefile        |   2 +
> > > >  drivers/pci/pcie/hisi_pcie_pmu.c | 528 +++++++++++++++++++++++++++++++
> > > >  include/linux/cpuhotplug.h       |   1 +
> > > >  4 files changed, 540 insertions(+)    
> > > 
> > > This looks like a nice piece of work, but I'm not sure where to put
> > > it.  It really doesn't feel like part of the PCI core in the sense
> > > that the PCI specs don't help you write it, and it doesn't provide any
> > > PCI services used by other parts of the kernel.  It feels more like
> > > just another driver for a device that happens to be on a PCI bus.
> > > 
> > > Granted, it currently requires portdrv, but I think the only reason
> > > for that is to resolve the "multiple drivers need the same device"
> > > problem.  I don't think portdrv is a good solution for that.
> > > 
> > > The other portdrv services (AER, hotplug, DPC, etc) are all defined in
> > > the spec, and they're related in strange ways like sharing interrupts.
> > > I would *like* to see those services moved into the PCI core directly
> > > so they're not *drivers*, they're just optional features like MSI,
> > > IOV, etc.
> > > 
> > > Then the Ports would by default not have a driver bound to them and
> > > device-specific drivers like this could directly bind to the Port PCI
> > > device.  
> > 
> > So the alternative is to just treat them as generic PMU drivers
> > and put them in drivers/perf.  That is fine but I would worry that would
> > lose the 'generalization' aspect because they weren't falling under
> > the scope of PCI.  I suppose we could just make it clear that any such
> > driver needs review from the PCI side as well as the perf side before being
> > merged.
> > 
> > However, we really are measuring things that are defined in the PCIe spec
> > even if we aren't doing it via PCI SIG defined methods (as there aren't
> > any currently), so it's a bit of a gray area to my mind.
> > 
> > Of course we don't have to get it right first time anyway as moving
> > drivers later is easy if it's just about where the code sits.  So we can
> > park this question until the more fundamental stuff is sorted!  
> 
> Agreed.  I could imagine a drivers/pci/pmu/ directory sort of like
> drivers/pci/switch/.

That might work.  Mark, Will what do you think? As long as you and Bjorn
agree I don't think it'll really matter which one is chosen.

driver/pci/pmu/ or drivers/perf/pci ?

> 
> Bjorn

Thanks

Jonathan


