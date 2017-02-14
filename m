Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753067AbdBNJpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Feb 2017 04:45:04 -0500
Date: Tue, 14 Feb 2017 09:45:02 +0000
From: Will Deacon <will.deacon@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        iommu@lists.linux-foundation.org,
        Vikram Sethi <vikrams@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: RFC on No ACS Support and SMMUv3 Support
Message-ID: <20170214094502.GA17822@arm.com>
References: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
 <20170213160652.7c141eb1@t450s.home>
 <2d199a00-a66a-e96c-b0c4-9dd4459d2589@codeaurora.org>
 <20170213184643.2d2bdce7@t450s.home>
 <546869d0-d05c-9550-86d5-276bc7a3c284@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <546869d0-d05c-9550-86d5-276bc7a3c284@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 13, 2017 at 08:54:04PM -0500, Sinan Kaya wrote:
> On 2/13/2017 8:46 PM, Alex Williamson wrote:
> >> My first goal is to support virtual function passthrough for device's that are directly
> >> connected. This will be possible with the quirk I proposed and it will be the most
> >> secure solution. It can certainly be generalized for other systems.
> > Why is this anything more than a quirk for the affected PCIe root port
> > vendor:device IDs and use of pci_device_group() to evaluate the rest of
> > the topology, as appears is already done?  Clearly a blanket exception
> > for the platform wouldn't necessarily be correct if a user could plugin
> > a device that adds a PCIe switch.
> 
> I was going to go this direction first. I wanted to check with everybody to see
> if there are other/better alternatives possible via either changing 
> pci_device_group or changing the smmuv3 driver.

Just to echo what Alex has been saying, I really don't think we should
support this type of system by quirking the topology code in the SMMU
driver. The SMMU isn't at fault here; the problems are all upstream of that.
Legitimising non-ACS machines in the SMMU driver gives little incentive for
people to build systems correctly and undermines the security guarantees
that the SMMU (and VFIO) are trying to provide.

I appreciate that I/O virtualisation on arm64 has been a learning curve for
everybody involved, but that's not an excuse for moving the goalposts when
it comes to device isolation.

Will
