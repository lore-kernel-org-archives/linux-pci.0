Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-va3.bigfish.com ([216.32.180.10]:52577 "EHLO
	VA3EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753807Ab1KRP1U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2011 10:27:20 -0500
Date: Fri, 18 Nov 2011 16:27:10 +0100
From: Joerg Roedel <Joerg.Roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: <iommu@lists.linux-foundation.org>, <dwmw2@infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu: Include MSI susceptibility to DMA in creating
 iommu groups
Message-ID: <20111118152710.GA5098@amd.com>
References: <20111117170800.3125.84150.stgit@bling.home>
 <20111118104651.GJ5627@amd.com>
 <1321628190.26410.63.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1321628190.26410.63.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2011 at 07:56:30AM -0700, Alex Williamson wrote:
> As you say, the interface is to tell userspace what devices the IOMMU
> can safely distinguish between.  On x86, the IOMMU cannot distinguish
> DMA to the interrupt region between devices without interrupt remapping.
> Therefore, to only expose devices we can safely distinguish between, we
> shouldn't expose any devices by default if we don't provide this
> isolation.  The interrupt remapping capability of the IOMMU isn't
> exposed to userspace, nor should userspace need to make the leap in
> understanding how MSIs are generated on a specific platform and whether
> interrupt remapping is required to provide isolation.

But the isolation domains are different. The iommu-group interface is
about device isolation and interrupt remapping is about DMA address
space isolation (MSI range vs. the rest). The iommu can still
distinguish between devices when it can not distinguish between DMA and
MSI interrupts.
So what you want to do belongs to the VFIO driver or (as it is today)
into the KVM device assignment code and not into the iommu-group
interface.

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

