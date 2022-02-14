Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DF8C433EF
	for <linux-pci@archiver.kernel.org>; Mon, 14 Feb 2022 14:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiBNOXT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:23:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbiBNOXS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 09:23:18 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502A49FB8;
        Mon, 14 Feb 2022 06:23:10 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1C490374; Mon, 14 Feb 2022 15:23:09 +0100 (CET)
Date:   Mon, 14 Feb 2022 15:23:07 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/8] iommu/amd: Use iommu_attach/detach_device()
Message-ID: <YgplyyjofwlM+1tc@8bytes.org>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-6-baolu.lu@linux.intel.com>
 <20220106143345.GC2328285@nvidia.com>
 <Ygo8iek2CwtPp2hj@8bytes.org>
 <20220214131544.GX4160@nvidia.com>
 <Ygpb6CxmTdUHiN50@8bytes.org>
 <20220214140236.GC929467@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214140236.GC929467@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 10:02:36AM -0400, Jason Gunthorpe wrote:
> That works for VFIO, but it doesn't work for other in-kernel
> drivers.. Is there something ensuring the group is only the GPU and
> sound device? Is the GPU never an addin card?

GPUs supporting this functionality are always iGPUs, AFAIK.

> I'd say the right way to code this after Lu's series to have both the
> GPU and sound driver call iommu_attach_device() during their probe()'s
> and specify the identity domain as the attaching domain.
> 
> That would be quite similar to how the Tegra drivers got arranged.
> 
> And then maybe someone could better guess what the "sound driver" is
> since it would be marked with an iommu_attach_device() call.

Device drivers calling into iommu_attach_device() is seldom a good
idea.  In this case the sound device has some generic hardware
interface so that an existing sound driver can be re-used. Making this
driver call iommu-specific functions for some devices is something hard
to justify.

With sub-groups on the other hand it would be a no-brainer, because the
sound device would be in a separate sub-group. Basically any device in
the same group as the GPU would be in a separate sub-group.

Regards,

	Joerg
