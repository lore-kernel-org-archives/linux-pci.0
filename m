Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68DDC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6B02082F
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6B02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeK1EyZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:54:25 -0500
Received: from foss.arm.com ([217.140.101.70]:44046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732019AbeK1EyY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 23:54:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 763841DC8;
        Tue, 27 Nov 2018 09:55:43 -0800 (PST)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A83B93F575;
        Tue, 27 Nov 2018 09:55:40 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v5 5/7] iommu: Add virtio-iommu driver
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     mark.rutland@arm.com, virtio-dev@lists.oasis-open.org,
        lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com,
        devicetree@vger.kernel.org, marc.zyngier@arm.com,
        linux-pci@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com,
        virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        bhelgaas@google.com, robin.murphy@arm.com,
        kvmarm@lists.cs.columbia.edu
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
 <20181122193801.50510-6-jean-philippe.brucker@arm.com>
 <20181123165206-mutt-send-email-mst@kernel.org>
Message-ID: <e76a51ba-7a0f-3fca-a1ae-640131f9dfe1@arm.com>
Date:   Tue, 27 Nov 2018 17:55:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181123165206-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/11/2018 21:56, Michael S. Tsirkin wrote:
>> +config VIRTIO_IOMMU
>> +	bool "Virtio IOMMU driver"
>> +	depends on VIRTIO=y
>> +	select IOMMU_API
>> +	select INTERVAL_TREE
>> +	select ARM_DMA_USE_IOMMU if ARM
>> +	help
>> +	  Para-virtualised IOMMU driver with virtio.
>> +
>> +	  Say Y here if you intend to run this kernel as a guest.
>> +
> 
> Given it is arm specific right now, shouldn't this depend on ARM?
> E.g. there's a hack for x86 right now.

Sure, I'll make it depend on ARM64 for now

[..]
>> +static int viommu_probe(struct virtio_device *vdev)
>> +{
>> +	struct device *parent_dev = vdev->dev.parent;
>> +	struct viommu_dev *viommu = NULL;
>> +	struct device *dev = &vdev->dev;
>> +	u64 input_start = 0;
>> +	u64 input_end = -1UL;
>> +	int ret;
>> +
>> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
>> +	    !virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP))
> 
> Why bother with a feature bit for this then btw?

We'll need a new feature bit for sharing page tables with the hardware,
because they require different requests (attach_table/invalidate instead
of map/unmap.) A future device supporting page table sharing won't
necessarily need to support map/unmap.

Thanks,
Jean
