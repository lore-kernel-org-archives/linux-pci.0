Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45C1C6787C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 18:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE32320835
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 18:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE32320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJMC3B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:29:01 -0400
Received: from foss.arm.com ([217.140.101.70]:56356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbeJMC3A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 22:29:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5F71F;
        Fri, 12 Oct 2018 11:55:07 -0700 (PDT)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85AE03F5D3;
        Fri, 12 Oct 2018 11:55:05 -0700 (PDT)
Subject: Re: [PATCH v3 5/7] iommu: Add virtio-iommu driver
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     mark.rutland@arm.com, peter.maydell@linaro.org,
        kevin.tian@intel.com, tnowicki@caviumnetworks.com,
        devicetree@vger.kernel.org, jasowang@redhat.com,
        linux-pci@vger.kernel.org, will.deacon@arm.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        marc.zyngier@arm.com, robin.murphy@arm.com,
        kvmarm@lists.cs.columbia.edu
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-6-jean-philippe.brucker@arm.com>
 <20181012120953-mutt-send-email-mst@kernel.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <ba8d7b94-a806-276b-e64c-9e6c5c9e107b@arm.com>
Date:   Fri, 12 Oct 2018 19:54:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012120953-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/10/2018 17:35, Michael S. Tsirkin wrote:
>> +		list_del(&req->list);
>> +		kfree(req);
> 
> So with DEBUG set, this will actually free memory that device still
> DMA's into. Hardly pretty. I think you want to mark device broken,
> queue the request and then wait for device to be reset.

Ok, let's remove DEBUG for the moment

>> +static int viommu_probe(struct virtio_device *vdev)
>> +{
>> +	struct device *parent_dev = vdev->dev.parent;
>> +	struct viommu_dev *viommu = NULL;
>> +	struct device *dev = &vdev->dev;
>> +	u64 input_start = 0;
>> +	u64 input_end = -1UL;
>> +	int ret;
>> +
>> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>> +		return -ENODEV;
> 
> I'm a bit confused about what will happen if this device
> happens to be behind an iommu itself.
>
> If we can't handle that, should we clear PLATFORM_IOMMU
> e.g. like the balloon does?

I think the DMA API can handle this device doing DMA through another
IOMMU. I haven't tested this case because it is very unusual (IOMMUs
themselves generally access the physical address space) but I don't see
anything preventing it.

What we can't handle is a device performing DMA through two
daisy-chained IOMMUs, but clearing PLATFORM_IOMMU on the first one
wouldn't make things work in that case, we'd need some core changes.

>> +struct virtio_iommu_config {
>> +	/* Supported page sizes */
>> +	__u64					page_size_mask;
>> +	/* Supported IOVA range */
>> +	struct virtio_iommu_range {
> 
> I'd rather we moved the definition outside even though gcc allows it -
> some old userspace compilers might not.
> 
>> +		__u64				start;
>> +		__u64				end;
>> +	} input_range;
>> +	/* Max domain ID size */
>> +	__u8					domain_bits;
> 
> Let's add explicit padding here as well?

Ok

Thanks,
Jean
