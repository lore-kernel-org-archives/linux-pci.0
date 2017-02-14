Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751918AbdBNBqp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Feb 2017 20:46:45 -0500
Date: Mon, 13 Feb 2017 18:46:43 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        iommu@lists.linux-foundation.org,
        Vikram Sethi <vikrams@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: RFC on No ACS Support and SMMUv3 Support
Message-ID: <20170213184643.2d2bdce7@t450s.home>
In-Reply-To: <2d199a00-a66a-e96c-b0c4-9dd4459d2589@codeaurora.org>
References: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
        <20170213160652.7c141eb1@t450s.home>
        <2d199a00-a66a-e96c-b0c4-9dd4459d2589@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 13 Feb 2017 19:14:31 -0500
Sinan Kaya <okaya@codeaurora.org> wrote:

> Hi Alex,
> 
> Thanks for your response. Other comments inline.
> 
> On 2/13/2017 6:06 PM, Alex Williamson wrote:
> > On Mon, 13 Feb 2017 17:24:40 -0500
> > Sinan Kaya <okaya@codeaurora.org> wrote:
> >   
> >> Hi,
> >> I am getting ready to submit a quirk patch. Before I go ahead and submit
> >> it for review, I wanted to get ARM IOMMU developers and PCI/VFIO maintainers
> >> together to figure out what the best approach would be.
> >>
> >> The Qualcomm QDF2400 server does not support the ACS functionality. 
> >> The server chip implements the ARM SMMUv3 specification with Stream Id = BDF. 
> >>
> >> SMMUv3 allows each PCIe function to have unique SMMU mappings and provides
> >> some level of isolation.   
> > 
> > "some level"?  Regardless, this is irrelevant.  ACS is how PCIe
> > describes the specific forwarding behavior of transactions within the
> > PCIe hierarchy.  The granularity of the SMMU translation is different
> > from ACS.  
> 
> Fair enough. SMMU just protects addresses that are not mapped. SMMU won't protect
> any transactions happening inside the PCIe hierarchy. The likelihood of common
> IO addresses varies from application to application.
> 
> >   
> >> With the current upstream SMMUv3 driver, we are unable to do a passthrough
> >> for a virtual function. This is caused by the pci_device_group() function's
> >> failure to find the smallest isolation group in pci_acs_path_enabled()
> >> function. 
> >>
> >> Since no group is found, all the PCI functions are placed into the same
> >> group at the end of the function. 
> >>
> >> There are numerous quirk patches when it comes to ACS.
> >>
> >> pci_quirk_amd_sb_acs()
> >> pci_quirk_cavium_acs()
> >> pci_quirk_intel_pch_acs_match()
> >>
> >> These quirk patches allow a group to be generated per PCI function. Everything
> >> works fine.
> >>
> >> I can go ahead and add 
> >>
> >> pci_quirk_qualcomm_acs() with the same contents as pci_quirk_cavium_acs()  
> >   
> 
> > Creating a quirk is not simply a matter of making the code do what you
> > want, an ACS quirk is you, on behalf of Qualcomm, vouching for the
> > hardware behaving in a certain way.    
> 
> Sure, let me clarify what the hardware does below.
> 
> > Specifically you're saying that
> > the device does Source Validation (ie. a downstream device cannot spoof
> > translations for devices on a different bus),   
> 
> Correct. Hardware supports source validation but it will report the issue
> as Completer Abort instead of ACS Violation. Also, each root port is a different
> segment on this particular design. 
> 
> > the device does not do
> > Request Redirection (ie. peer-to-peer shortcuts that may bypass the
> > IOMMU), the device does not do Completion Redirection (same, but for
> > completions),   
> 
> Hardware doesn't support peer-to-peer and no segment sharing across root ports
> unlike Intel architecture where most of the devices are sitting on segment 0
> with multiple bridges/switch.
> 
> > and the device does Upstream Forwarding (ie. no
> > shortcuts).  If the hardware does not honor these behaviors then adding
> > a quirk is only putting customers at risk.  
> 
> No p2p again. The assumption was that p2p would be possible with a PCIe switch
> connected to a root port but we missed the fact that there are security implications
> required by the ACS implementation. Note that this is ACS requirement is a Linux
> statement not PCIe spec.
> 
> >   
> >> Tomorrow, some other ARM64 vendors like up and start adding pci_quirk_vendor_acs()
> >> functions. IMO, it leads to unnecessary code duplication.   
> > 
> > Which is exactly why they should be implementing ACS in their hardware!
> >   
> 
> Note that I'm not disagreeing with you or telling that ACS is unnecessary and SMMU
> has a bigger hammer etc. I now understand the value of ACS and what it takes to build
> a secure peer-to-peer system. I also want to put a big fat warning about the fact that
> we are sharing the group to the next SOC designer's attention.
> 
> My only concern is the fact that the QDF2400 and QDF2432 missed this requirement and we have
> SoC out in the field. I wish this requirement was explicit somewhere like PCI/ACPI
> documentation.
> 
> I'll make sure that the next chip gets this feature. This is an iterative process with
> lessons learnt on the way.
> 
> >> I can go ahead and try to make the patches similar with generic names like pci_quirk_no_acs()
> >> so that every vendor can use to it. Still, it would require some quirk patch from a vendor.
> >>
> >> Nate has been changing the arm_smmu_device_group() function internally to always
> >> use generic_device_group(). This provides support for the Virtual Function passthrough
> >> but it is not future proof. Tomorrow, some HW with ACS capability can show up and
> >> the ARM SMMUv3 driver wouldn't bother to see if there is actual HW isolation path
> >> available.
> >>
> >> What I really would like to do is to find a balance between what Nate has been doing
> >> internally and what pci_device_group() does by changing the SMMUv3 driver to query if
> >> ACS path is supported or not similar to the loop in pci_device_group. If not supported,
> >> fallback to generic_device_group() function in arm_smmu_device_group().  
> >   
> 
> My first goal is to support virtual function passthrough for device's that are directly
> connected. This will be possible with the quirk I proposed and it will be the most
> secure solution. It can certainly be generalized for other systems.

Why is this anything more than a quirk for the affected PCIe root port
vendor:device IDs and use of pci_device_group() to evaluate the rest of
the topology, as appears is already done?  Clearly a blanket exception
for the platform wouldn't necessarily be correct if a user could plugin
a device that adds a PCIe switch.
 
> My second goal is extend the code such that ACS validation is up to the customer via 
> pci=noacs kernel command line for instance. This will let the customer choose what he
> really wants rather than kernel trying to be smart and protective. By passing pci=noacs
> parameter, customer acknowledges the risks this command line carries.

Be prepared that this will need to taint the kernel since we make
assertions with drivers like vfio to provide secure, isolated user
access to devices and we can't make that statement if the user has
bypassed ACS enforcement.  There is absolutely no way that such an
option would not be severely abused.  In fact, I tried adding such an
option with the pcie_acs_override= patch[1], Bjorn rejected it and I'm
thankful that he did.  I don't think this is a good idea, sometimes the
kernel does need to be smarter than the user to protect them from
themselves.  Any easy bypass also lets hardware vendors ignore the
issue longer.  Thanks,

Alex

[1] https://lkml.org/lkml/2013/5/30/513
