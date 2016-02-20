Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35196 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759244AbcBTSQ1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 20 Feb 2016 13:16:27 -0500
Received: by mail-yk0-f182.google.com with SMTP id r207so47568303ykd.2
        for <linux-pci@vger.kernel.org>; Sat, 20 Feb 2016 10:16:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160218071450.6b65676e@t450s.home>
References: <1455487501-28630-1-git-send-email-jchandra@broadcom.com>
 <20160215182023.GB12641@localhost> <20160215123901.1600f86f@t450s.home>
 <CAKc_7PUtm7443qv40DNWKqJneWnVT6Do7s7vr_hOerkGLOgkJg@mail.gmail.com>
 <20160216152529.33855bc1@t450s.home> <CAKc_7PVExWkm0NqoGcf4d5bSPEcbhzn45oBgYRc7xZ8CJg+WEw@mail.gmail.com>
 <20160217082828.3d164080@t450s.home> <CAKc_7PXwAUVc1=Sh2B9+BFts2bDGObtQCMCBg-bYrKfjE9iwVw@mail.gmail.com>
 <20160218071450.6b65676e@t450s.home>
From: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Date: Sat, 20 Feb 2016 23:45:47 +0530
Message-ID: <CAKc_7PVHjAe8ZhfLJXdQTRkh21WDmn2S_T9knNON9Uv=L4ecVw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] PCI: Add PCI device flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Jayachandran C <jchandra@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

On Thu, Feb 18, 2016 at 7:44 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Thu, 18 Feb 2016 18:57:12 +0530
> Jayachandran Chandrashekaran Nair
> <jayachandran.chandrashekaran@broadcom.com> wrote:
>
>> On Wed, Feb 17, 2016 at 8:58 PM, Alex Williamson
>> <alex.williamson@redhat.com> wrote:
>> > On Wed, 17 Feb 2016 17:15:09 +0530
>> > Jayachandran Chandrashekaran Nair
>> > <jayachandran.chandrashekaran@broadcom.com> wrote:
>> >
>> >> On Wed, Feb 17, 2016 at 3:55 AM, Alex Williamson
>> >> <alex.williamson@redhat.com> wrote:
>> >> > On Wed, 17 Feb 2016 02:38:24 +0530
>> >> > Jayachandran Chandrashekaran Nair
>> >> > <jayachandran.chandrashekaran@broadcom.com> wrote:
>> >> >
>> >> >> On Tue, Feb 16, 2016 at 1:09 AM, Alex Williamson
>> >> >> <alex.williamson@redhat.com> wrote:
>> >> >> > On Mon, 15 Feb 2016 12:20:23 -0600
>> >> >> > Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >> >> >
>> >> >> >> [+cc Alex, iommu list]
>> >> >> >>
>> >> >> >> On Mon, Feb 15, 2016 at 03:35:00AM +0530, Jayachandran C wrote:
>> >> >> >> > Add a new flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS to indicate bridges
>> >> >> >> > that should not be considered during DMA alias search. This is
>> >> >> >> > to support hardware (in this case Broadcom Vulcan PCIe subsystem)
>> >> >> >> > that has internal bridges which have either missing or wrong PCIe
>> >> >> >> > capabilities.
>> >> >> >
>> >> >> > I figured this would come at some point, the right answer is of course
>> >> >> > to follow the PCIe spec and implement the required PCIe capability in
>> >> >> > the hardware.
>> >> >>
>> >> >> There are  PCIe controllers on the chip that follows the spec, the issue is
>> >> >> how it is integrated to the northbridge (equivalent) on the chip, I have
>> >> >> tried to explain it below.
>> >> >>
>> >> >> >> This needs more explanation, like what exactly is wrong with this
>> >> >> >> device?  A missing PCIe capability might cause other problems.
>> >> >> >>
>> >> >> >> What problem does this fix?  Without these patches, do we merely add
>> >> >> >> aliases that are unnecessary?  Do we crash because something goes
>> >> >> >> wrong in the pci_pcie_type() switch because of the incorrect
>> >> >> >> capability?
>> >> >>
>> >> >> Here's how (for example) how the PCI enumeration of a 2 node Vulcan
>> >> >> processor will look like:
>> >> >>
>> >> >>
>> >> >> [0] +-0.0.0--[1]---+--1.a.0----[2]-----2.0.0---[3]----3.0.0
>> >> >>     |              +--1.a.1----[4]-----4.0.0---[5]----5.0.0
>> >> >>     |              .
>> >> >>     |              ... etc...
>> >> >>     |
>> >> >>     +-0.0.1--[10]--+-10.a.0----[11]---11.0.0---[12]---12.0.0
>> >> >>                    +-10.a.1----[13]---13.0.0---[14]---14.0.0
>> >> >>                    .
>> >> >>                    ... etc...
>> >> >
>> >> > So we have:
>> >> >
>> >> >     "Glue Bridge"---"Glue Bridges"---Root Ports---Endpoints
>> >> >       (no pcie)      (pci/x-pcie)
>> >>
>> >> The top level is one glue bridge per chip in a multi-chip board,
>> >> but otherwise this is accurate.
>> >>
>> >> >>
>> >> >> The devices 0.0.x and x.a.x are glue bridges that are there to
>> >> >> bring the real PCIe controllers (pcie cap type 4) 2.0.0, 4.0.0,
>> >> >> 11.0.0, 13.0.0 under a single PCI hierarchy. The x.a.x bridges
>> >> >> have a PCIe capability (type 8) and 0.0.x does not have any pcie
>> >> >> capability.
>> >> >>
>> >> >> In case of Vulcan, both the GICv3 ITS driver code and the SMMUv3
>> >> >> driver code does dma alias walk to find the device id to use
>> >> >> in ITS and SMMU. In both cases it will ignore the x.0.0 bridges
>> >> >> since they are type root port, but will continue on up and end
>> >> >> up with incorrect device id.
>> >> >>
>> >> >> The flag I have added is to make the pci_for_each_dma_alias()
>> >> >> ignore the last 2 levels of glue/internal bridges.
>> >> >
>> >> > Per the PCIe spec, I'm not even sure what you have is a valid
>> >> > hierarchy, root ports sit on root complexes, not behind a PCI-to-PCIe
>> >> > bridge.  So really you're pretending that the downstream "glue bridge"
>> >> > is your host bridge and therefore root complex, but the PCI topology
>> >> > would clearly dictate that the top-most bus is conventional PCI and
>> >> > therefore everything is an alias of everything else and the DMA alias
>> >> > code is doing exactly what it should.
>> >>
>> >> Yes, I am not arguing that there is any issue in the current code. I
>> >> am trying to figure out the correct way to implement the quirk. We
>> >> have to support the hardware we have, not the hardware we want to
>> >> have :)
>> >>
>> >> > Also note that the caller of pci_for_each_dma_alias() owns the callback
>> >> > function triggered for each alias, that function could choose to prune
>> >> > out these "glue bridges" itself if that's the appropriate thing to do.
>> >>
>> >> I had implemented this first, but moved to the current approach because
>> >> it is needed in multiple places. The problem is: "On vulcan, while
>> >> going up the pcie bus heirarchy for finding aliases, skip the glue bridges",
>> >> So the logical place to put the fix is in pci_for_each_dma_alias()
>> >>
>> >> > Where do the SMMU and ITS actually reside in the above diagram?  You
>> >> > can use the callout function to stop the traversal anywhere you wish,
>> >> > it's free to return a -errno to stop or positive number, which the
>> >> > caller can interpret as error or non-failure stop condition.
>> >>
>> >> The SMMU (for translation requests) and ITS (for MSI writes for
>> >> interrupts) are connected directly to the proper PCIe controller
>> >> (2/4/11/13.0.0 above)
>> >
>> >
>> > If the translation unit is on the root port then DMA aliases upstream of
>> > the translation unit are irrelevant and the callback function should
>> > stop the traversal at that point.
>> >
>> >> > You could even think about changing what Linux considers to be the host
>> >> > bridge.  Maybe these glue bridges shouldn't even be visible to Linux,
>> >> > would that also solve the issue with the broken BAR?
>> >>
>> >> The glue bridges have to seen by Linux for assigning resources like
>> >> bus ranges and memory windows. So these are required bridges in
>> >> the topology and will work with the standard linux code
>> >> (provided we skip them for aliases, and and ignore the BAR).
>> >>
>> >> >> > The change takes the same code path as it would for a real PCIe bridge
>> >> >> > port (downstream/upstream/root), which means they want to skip adding
>> >> >> > this bridge as an alias of the device.  So we're adding in aliases that
>> >> >> > don't exist, the bridge itself.
>> >> >> >
>> >> >> > If anything I'd suggest a flag that actually tries to address the
>> >> >> > problem rather than a symptom of the problem.  For example, maybe the
>> >> >> > flag should be PCI_DEV_FLAGS_IS_PCIE.  Maybe pci_is_pcie() should even
>> >> >> > take that into account.  That has some trickle through for
>> >> >> > pci_pcie_type() and all the accessor functions, but maybe it's a
>> >> >> > cleaner solution overall (or maybe it explodes further).  Thanks,
>> >> >>
>> >> >> I didn't really want to mark the glue bridges as PCIe or have fake
>> >> >> PCIe capability there, the obvious simple solution was to add
>> >> >> the flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS
>> >> >>
>> >> >> Any suggestions/comments on how to do this better would be welcome.
>> >> >
>> >> > I definitely don't think either flag idea is the right solution, I
>> >> > think you've actually already got the tools you need to solve it by
>> >> > putting the intelligence in the callback function or by going further
>> >> > down the path of pretending the glue bridge is really a host bridge.
>> >>
>> >> If I understand your suggestion, I need to fake the PCIe capability
>> >> for the glue bridges, which may be reasonable for the second level.
>> >> But for the first level, there is no pcie capability and faking that
>> >> becomes more difficult.
>> >
>> > That's not what I'm suggesting.
>> >
>> >> If the concern is adding a flag for just one platform, I can check
>> >> for the vendor ID/device ID in the pci_for_each_dma_alias()
>> >> function, which would be slightly uglier, but still a simple and
>> >> maintainable solution.
>> >>
>> >> Another option is to break the pci_for_each_dma_alias when it
>> >> reaches to root port (for vulcan), this too can be done without
>> >> a flag.
>> >
>> > Exactly, this can be done by the callback function provided on vulcan
>> > systems and requires no core changes.  The IOMMU needs to provide a
>> > callback function that makes sense for collecting aliases on the
>> > specific platform.  If the translation unit is not on the root bus, the
>> > callback function should stop the topology walk earlier.  Thanks,
>>
>> Fixing every callback function is going to be painful and ugly.
>> I will have to change drivers/irqchip/irq-gic-v3-its-pci-msi.c,
>> drivers/pci/msi.c, and drivers/iommu/arm-smmu-v3.c with the
>> same check for vendor/device ids and return early.
>>
>> I can update the patch to check the vendor/device id in the
>> case of ROOT_PORT in pci_for_each_dma_alias(). If you
>> think that will not be acceptable, I don't have any reasonable
>> options left.
>
> I've never known there to necessarily be a correlation between the
> easiest solution and the correct one, but I think there's probably
> still an easy and clean solution not far from your original approach.
> pci_for_each_dma_alias() is meant to collect all the aliases for a
> given device.  It stops at the root bus both because it can't go
> further and because on many platforms, that's where the translation
> unit lives.  If we want to have a common and easy way to stop it above
> the root bus then we could flag a device as being the DMA alias root
> and exit at that point.  I think that makes more sense architecturally
> than some mystery devices flagged to skip reporting an alias.  Thanks,

Thanks for the suggestion, I will try to implement this approach and
submit a newer patchset.

JC.
