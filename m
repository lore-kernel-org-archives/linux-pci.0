Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C5EC433EF
	for <linux-pci@archiver.kernel.org>; Mon, 14 Feb 2022 11:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352802AbiBNLmk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:42:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354147AbiBNLmL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 06:42:11 -0500
X-Greylist: delayed 418 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 03:34:10 PST
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFAD67343
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 03:34:10 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AC95B36D; Mon, 14 Feb 2022 12:27:06 +0100 (CET)
Date:   Mon, 14 Feb 2022 12:27:05 +0100
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
Message-ID: <Ygo8iek2CwtPp2hj@8bytes.org>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-6-baolu.lu@linux.intel.com>
 <20220106143345.GC2328285@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106143345.GC2328285@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 06, 2022 at 10:33:45AM -0400, Jason Gunthorpe wrote:
> But I'm not sure how this can work with multi-device groups - this
> seems to assigns a domain setup for direct map, so perhaps this only
> works if all devices are setup for direct map?

Right, at boot all devices in this group are already setup for using a
direct map. There are usually two devices in those groups, the GPU
itself and the sound device for HDMI sound output.

Regards,

	Joerg

