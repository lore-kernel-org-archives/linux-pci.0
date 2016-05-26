Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52149 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbcEZA02 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2016 20:26:28 -0400
From: Mitchel Humpherys <mitchelh@codeaurora.org>
To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	"Alex Williamson" <alex.williamson@redhat.com>,
	"Will Deacon" <will.deacon@arm.com>,
	"Robin Murphy" <robin.murphy@arm.com>
Cc: Tony Truong <truong@codeaurora.org>, Yan He <yanhe@codeaurora.org>,
	Pratik Patel <pratikp@codeaurora.org>,
	"Hamad Kadmany" <hkadmany@codeaurora.org>,
	"Maya Erez" <qca_merez@qca.qualcomm.com>
Subject: How to keep PCI-e endpoints and RCs in distinct IOMMU groups?
Date: Wed, 25 May 2016 17:26:15 -0700
Message-ID: <vnkwoa7ty89k.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey there,

We're experiencing an issue with IOMMU groups and PCI-e devices.  The
system in question has a WLAN DMA master behind a PCI-e root complex
which is, in turn, behind an IOMMU.  There are no there devices behind
the RC.  This is on an ARM platform using the arm-smmu and pci-msm
drivers (pci-msm is in the MSM vendor tree, sorry...).

What we're observing is that the WLAN endpoint device is being added to
the same IOMMU group as the root complex device itself.  I don't think
they should be in the same group though, since they each have different
BDFs, which, in our system, are translated to different SMMU Stream IDs,
so their traffic is split onto separate SMMU context banks.  Since their
traffic is isolated from one other I don't think they need to be in the
same IOMMU group (as I understand IOMMU groups).

The result is that when the WLAN driver tries to attach to their IOMMU
it errors out due to the following check in iommu_attach_device:

        if (iommu_group_device_count(group) != 1)
                goto out_unlock;

I've come up with a few hacky workarounds:

  - Forcing PCI-e ACS to be "enabled" unconditionally (even though our
    platform doesn't actually support it).

  - Call iommu_attach_group instead of iommu_attach_device in the arm64
    DMA IOMMU mapping layer (yuck).

  - Don't use the pci_device_group helper at all from the arm-smmu
    driver.  Just allocate a new group for all PCI-e devices.

It seems like the proper solution would be to somehow make these devices
end up in separate IOMMU groups using the existing pci_device_group
helper, since that might be doing useful stuff for other configurations
(like detecting the DMA aliasing quirks).

Looking at pci_device_group, though, I'm not sure how we could tell that
these two devices are supposed to get separated.  I know very little
about PCI-e so maybe I'm just missing something simple.  The match
happens in the following loop where we walk up the PCI-e topology:

        /*
         * Continue upstream from the point of minimum IOMMU granularity
         * due to aliases to the point where devices are protected from
         * peer-to-peer DMA by PCI ACS.  Again, if we find an existing
         * group, use it.
         */
        for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
                if (!bus->self)
                        continue;

                if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
                        break;

                pdev = bus->self;

                group = iommu_group_get(&pdev->dev);
                if (group)
                        return group;
        }

Why do we do that?  If the devices have different BDFs can't we safely
say that they're protected from peer-to-peer DMA (assuming no DMA
aliasing quirks)?  Even as I write that out it seems wrong though since
the RC can probably do whatever it wants...

Maybe the IOMMU framework can't actually know whether the devices should
be kept in separate groups and we just need to do something custom in
the arm-smmu driver?

Sorry for the novel!  Thanks for any pointers.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
