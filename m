Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E9C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598C02147D
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598C02147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbeK1Ety (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:49:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43920 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbeK1Etx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 23:49:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC0441DC8;
        Tue, 27 Nov 2018 09:51:13 -0800 (PST)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35F833F575;
        Tue, 27 Nov 2018 09:51:11 -0800 (PST)
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
 <20181123165742-mutt-send-email-mst@kernel.org>
Message-ID: <fd221210-7e12-1d15-0c80-52a761f6893d@arm.com>
Date:   Tue, 27 Nov 2018 17:50:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181123165742-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/11/2018 22:02, Michael S. Tsirkin wrote:
>> +/*
>> + * __viommu_sync_req - Complete all in-flight requests
>> + *
>> + * Wait for all added requests to complete. When this function returns, all
>> + * requests that were in-flight at the time of the call have completed.
>> + */
>> +static int __viommu_sync_req(struct viommu_dev *viommu)
>> +{
>> +	int ret = 0;
>> +	unsigned int len;
>> +	size_t write_len;
>> +	struct viommu_request *req;
>> +	struct virtqueue *vq = viommu->vqs[VIOMMU_REQUEST_VQ];
>> +
>> +	assert_spin_locked(&viommu->request_lock);
>> +
>> +	virtqueue_kick(vq);
>> +
>> +	while (!list_empty(&viommu->requests)) {
>> +		len = 0;
>> +		req = virtqueue_get_buf(vq, &len);
>> +		if (!req)
>> +			continue;
>> +
>> +		if (!len)
>> +			viommu_set_req_status(req->buf, req->len,
>> +					      VIRTIO_IOMMU_S_IOERR);
>> +
>> +		write_len = req->len - req->write_offset;
>> +		if (req->writeback && len == write_len)
>> +			memcpy(req->writeback, req->buf + req->write_offset,
>> +			       write_len);
>> +
>> +		list_del(&req->list);
>> +		kfree(req);
>> +	}
> 
> I didn't notice this in the past but it seems this will spin
> with interrupts disabled until host handles the request.
> Please do not do this - host execution can be another
> task that needs the same host CPU. This will then disable
> interrupts for a very very long time.

In the guest yes, but that doesn't prevent the host from running another
task right? My tests run fine when QEMU is bound to a single CPU, even
though vcpu and viommu run in different threads

> What to do then? Queue in software and wake up task.

Unfortunately I can't do anything here, because IOMMU drivers can't
sleep in the iommu_map() or iommu_unmap() path. The problem is the same
for all IOMMU drivers. That's because the DMA API allows drivers to call
some functions with interrupts disabled. For example
Documentation/DMA-API-HOWTO.txt allows dma_alloc_coherent() and
dma_unmap_single() to be called in interrupt context.

> As kick is vm exit, kick under interrupts disabled is discouraged too:
> better to prepare for kick enable interrupts then kick.

That was on my list of things to look at, because it could relax
things for device drivers that don't call us with interrupts disabled. I
just tried it and I can see some performance improvement (7% and 4% on
tcp_stream and tcp_maerts respectively, +/-2.5%).

Since it's an optimization I'll leave it for later (ACPI and module
support is higher on my list). The resulting change is complicated
because we now need to deal with threads adding new requests while
sync() is running. With my current prototype one thread could end up
staying in sync() while other threads add new async requests, so I need
to find a way to bound it.

Thanks,
Jean
