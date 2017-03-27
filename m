Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:40083 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752686AbdC0PdZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Mar 2017 11:33:25 -0400
Date: Mon, 27 Mar 2017 17:33:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shanker Donthineni <shankerd@qti.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@qti.qualcomm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Nate Watterson <nwatters@qti.qualcomm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a
 task
Message-ID: <20170327153312.GP7266@8bytes.org>
References: <20170322154429.GE7266@8bytes.org>
 <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
 <20170322225320.GF7266@8bytes.org>
 <a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
 <20170323143014.GK7266@8bytes.org>
 <20170323145311.GA22972@e106794-lin.localdomain>
 <20170323165218.GL7266@8bytes.org>
 <9d318e88-11af-6dab-b30e-d6b5c02443fe@arm.com>
 <20170324110045.GM7266@8bytes.org>
 <7386120a-2848-059f-4de0-7888a2698923@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7386120a-2848-059f-4de0-7888a2698923@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 24, 2017 at 07:08:47PM +0000, Jean-Philippe Brucker wrote:
> On 24/03/17 11:00, Joerg Roedel wrote:
> > The document you posted is an addition to the spec, so we can't rely on
> > a stop marker being sent by a device when it shuts down a context.
> > Current AMD GPUs don't send one, afaik.
> 
> Fair enough, though on the SMMU side we still don't know which shutdown
> model hardware vendors are more likely to choose. Devices could use the
> stop marker and never wait for completion of PPRs. In that case context
> shutdown would only have to make sure that PPRs are outside the PCI
> network, return immediately and allow the device driver to call unbind().

Yes, on a stop-marker we should immediatly remove the PASID from the
IOMMU and inform the driver. It might call unbind or do something with
the device.

> So to be on the safe side I think I will by default assume that PPRs are
> in flight during unbind, and drain both software and hardware queue to
> ensure we catch them all.

The AMD driver first removes the internal mapping of the PASID to its
managing data-structures, so that any follow-on faults will get
rejected.



	Joerg
