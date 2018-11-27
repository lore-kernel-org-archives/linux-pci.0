Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03D0C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881A52145D
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881A52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbeK1FJE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:09:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeK1FJE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 00:09:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17FB7A6E1E;
        Tue, 27 Nov 2018 18:10:21 +0000 (UTC)
Received: from redhat.com (ovpn-116-85.ams2.redhat.com [10.36.116.85])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B4D1100034A;
        Tue, 27 Nov 2018 18:10:11 +0000 (UTC)
Date:   Tue, 27 Nov 2018 13:10:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     mark.rutland@arm.com, virtio-dev@lists.oasis-open.org,
        lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com,
        devicetree@vger.kernel.org, marc.zyngier@arm.com,
        linux-pci@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com,
        virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        bhelgaas@google.com, robin.murphy@arm.com,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v5 5/7] iommu: Add virtio-iommu driver
Message-ID: <20181127130527-mutt-send-email-mst@kernel.org>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
 <20181122193801.50510-6-jean-philippe.brucker@arm.com>
 <20181123165206-mutt-send-email-mst@kernel.org>
 <e76a51ba-7a0f-3fca-a1ae-640131f9dfe1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e76a51ba-7a0f-3fca-a1ae-640131f9dfe1@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 27 Nov 2018 18:10:21 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 05:55:20PM +0000, Jean-Philippe Brucker wrote:
> On 23/11/2018 21:56, Michael S. Tsirkin wrote:
> >> +config VIRTIO_IOMMU
> >> +	bool "Virtio IOMMU driver"
> >> +	depends on VIRTIO=y
> >> +	select IOMMU_API
> >> +	select INTERVAL_TREE
> >> +	select ARM_DMA_USE_IOMMU if ARM
> >> +	help
> >> +	  Para-virtualised IOMMU driver with virtio.
> >> +
> >> +	  Say Y here if you intend to run this kernel as a guest.
> >> +
> > 
> > Given it is arm specific right now, shouldn't this depend on ARM?
> > E.g. there's a hack for x86 right now.
> 
> Sure, I'll make it depend on ARM64 for now
> 
> [..]
> >> +static int viommu_probe(struct virtio_device *vdev)
> >> +{
> >> +	struct device *parent_dev = vdev->dev.parent;
> >> +	struct viommu_dev *viommu = NULL;
> >> +	struct device *dev = &vdev->dev;
> >> +	u64 input_start = 0;
> >> +	u64 input_end = -1UL;
> >> +	int ret;
> >> +
> >> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
> >> +	    !virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP))
> > 
> > Why bother with a feature bit for this then btw?
> 
> We'll need a new feature bit for sharing page tables with the hardware,
> because they require different requests (attach_table/invalidate instead
> of map/unmap.) A future device supporting page table sharing won't
> necessarily need to support map/unmap.
> 
> Thanks,
> Jean

I don't see virtio iommu being extended to support ARM specific
requests. This just won't scale, too many different
descriptor formats out there.

If you want to go that way down the road, you should avoid
virtio iommu, instead emulate and share code with the ARM SMMU (probably
with a different vendor id so you can implement the
report on map for devices without PRI).

Others on the TC might feel differently.

If someone's looking into adding virtio iommu support in hardware,
that's a different matter. Which is it?

-- 
MST
