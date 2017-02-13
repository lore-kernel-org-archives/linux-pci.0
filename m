Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbdBMXGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Feb 2017 18:06:54 -0500
Date: Mon, 13 Feb 2017 16:06:52 -0700
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
Message-ID: <20170213160652.7c141eb1@t450s.home>
In-Reply-To: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
References: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 13 Feb 2017 17:24:40 -0500
Sinan Kaya <okaya@codeaurora.org> wrote:

> Hi,
> I am getting ready to submit a quirk patch. Before I go ahead and submit
> it for review, I wanted to get ARM IOMMU developers and PCI/VFIO maintainers
> together to figure out what the best approach would be.
> 
> The Qualcomm QDF2400 server does not support the ACS functionality. 
> The server chip implements the ARM SMMUv3 specification with Stream Id = BDF. 
> 
> SMMUv3 allows each PCIe function to have unique SMMU mappings and provides
> some level of isolation. 

"some level"?  Regardless, this is irrelevant.  ACS is how PCIe
describes the specific forwarding behavior of transactions within the
PCIe hierarchy.  The granularity of the SMMU translation is different
from ACS.

> With the current upstream SMMUv3 driver, we are unable to do a passthrough
> for a virtual function. This is caused by the pci_device_group() function's
> failure to find the smallest isolation group in pci_acs_path_enabled()
> function. 
> 
> Since no group is found, all the PCI functions are placed into the same
> group at the end of the function. 
> 
> There are numerous quirk patches when it comes to ACS.
> 
> pci_quirk_amd_sb_acs()
> pci_quirk_cavium_acs()
> pci_quirk_intel_pch_acs_match()
> 
> These quirk patches allow a group to be generated per PCI function. Everything
> works fine.
> 
> I can go ahead and add 
> 
> pci_quirk_qualcomm_acs() with the same contents as pci_quirk_cavium_acs()

Creating a quirk is not simply a matter of making the code do what you
want, an ACS quirk is you, on behalf of Qualcomm, vouching for the
hardware behaving in a certain way.  Specifically you're saying that
the device does Source Validation (ie. a downstream device cannot spoof
translations for devices on a different bus), the device does not do
Request Redirection (ie. peer-to-peer shortcuts that may bypass the
IOMMU), the device does not do Completion Redirection (same, but for
completions), and the device does Upstream Forwarding (ie. no
shortcuts).  If the hardware does not honor these behaviors then adding
a quirk is only putting customers at risk.

> Tomorrow, some other ARM64 vendors like up and start adding pci_quirk_vendor_acs()
> functions. IMO, it leads to unnecessary code duplication. 

Which is exactly why they should be implementing ACS in their hardware!

> I can go ahead and try to make the patches similar with generic names like pci_quirk_no_acs()
> so that every vendor can use to it. Still, it would require some quirk patch from a vendor.
> 
> Nate has been changing the arm_smmu_device_group() function internally to always
> use generic_device_group(). This provides support for the Virtual Function passthrough
> but it is not future proof. Tomorrow, some HW with ACS capability can show up and
> the ARM SMMUv3 driver wouldn't bother to see if there is actual HW isolation path
> available.
> 
> What I really would like to do is to find a balance between what Nate has been doing
> internally and what pci_device_group() does by changing the SMMUv3 driver to query if
> ACS path is supported or not similar to the loop in pci_device_group. If not supported,
> fallback to generic_device_group() function in arm_smmu_device_group().

Intel VT-d and AMD-Vi already manage to do this, what is it about an
SMMU topology that makes it significantly different.  Note that like
SMMU, both of these have BDF level granularity for identifying devices,
but defer to the ACS based isolation for grouping based on downstream
components.  The best IOMMU available cannot overcome transactions that
it never sees because they're rerouted before reaching the IOMMU.

> I'm just looking for a more permanent solution rather than relying on quirks for chips
> A, B, C and D.

Implement ACS in all downstream ports and multifunction endpoints!
Thanks,

Alex
