Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35229 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbcBPVJE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 16:09:04 -0500
Received: by mail-yw0-f179.google.com with SMTP id g127so150251172ywf.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Feb 2016 13:09:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160215123901.1600f86f@t450s.home>
References: <1455487501-28630-1-git-send-email-jchandra@broadcom.com>
 <20160215182023.GB12641@localhost> <20160215123901.1600f86f@t450s.home>
From: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Date: Wed, 17 Feb 2016 02:38:24 +0530
Message-ID: <CAKc_7PUtm7443qv40DNWKqJneWnVT6Do7s7vr_hOerkGLOgkJg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] PCI: Add PCI device flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Jayachandran C <jchandra@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 16, 2016 at 1:09 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 15 Feb 2016 12:20:23 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>> [+cc Alex, iommu list]
>>
>> On Mon, Feb 15, 2016 at 03:35:00AM +0530, Jayachandran C wrote:
>> > Add a new flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS to indicate bridges
>> > that should not be considered during DMA alias search. This is
>> > to support hardware (in this case Broadcom Vulcan PCIe subsystem)
>> > that has internal bridges which have either missing or wrong PCIe
>> > capabilities.
>
> I figured this would come at some point, the right answer is of course
> to follow the PCIe spec and implement the required PCIe capability in
> the hardware.

There are  PCIe controllers on the chip that follows the spec, the issue is
how it is integrated to the northbridge (equivalent) on the chip, I have
tried to explain it below.

>> This needs more explanation, like what exactly is wrong with this
>> device?  A missing PCIe capability might cause other problems.
>>
>> What problem does this fix?  Without these patches, do we merely add
>> aliases that are unnecessary?  Do we crash because something goes
>> wrong in the pci_pcie_type() switch because of the incorrect
>> capability?

Here's how (for example) how the PCI enumeration of a 2 node Vulcan
processor will look like:


[0] +-0.0.0--[1]---+--1.a.0----[2]-----2.0.0---[3]----3.0.0
    |              +--1.a.1----[4]-----4.0.0---[5]----5.0.0
    |              .
    |              ... etc...
    |
    +-0.0.1--[10]--+-10.a.0----[11]---11.0.0---[12]---12.0.0
                   +-10.a.1----[13]---13.0.0---[14]---14.0.0
                   .
                   ... etc...

The devices 0.0.x and x.a.x are glue bridges that are there to
bring the real PCIe controllers (pcie cap type 4) 2.0.0, 4.0.0,
11.0.0, 13.0.0 under a single PCI hierarchy. The x.a.x bridges
have a PCIe capability (type 8) and 0.0.x does not have any pcie
capability.

In case of Vulcan, both the GICv3 ITS driver code and the SMMUv3
driver code does dma alias walk to find the device id to use
in ITS and SMMU. In both cases it will ignore the x.0.0 bridges
since they are type root port, but will continue on up and end
up with incorrect device id.

The flag I have added is to make the pci_for_each_dma_alias()
ignore the last 2 levels of glue/internal bridges.

> The change takes the same code path as it would for a real PCIe bridge
> port (downstream/upstream/root), which means they want to skip adding
> this bridge as an alias of the device.  So we're adding in aliases that
> don't exist, the bridge itself.
>
> If anything I'd suggest a flag that actually tries to address the
> problem rather than a symptom of the problem.  For example, maybe the
> flag should be PCI_DEV_FLAGS_IS_PCIE.  Maybe pci_is_pcie() should even
> take that into account.  That has some trickle through for
> pci_pcie_type() and all the accessor functions, but maybe it's a
> cleaner solution overall (or maybe it explodes further).  Thanks,

I didn't really want to mark the glue bridges as PCIe or have fake
PCIe capability there, the obvious simple solution was to add
the flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS

Any suggestions/comments on how to do this better would be welcome.

Thanks,
JC.
[Using gmail due to IT transition, hope the ascii art makes it thru]
