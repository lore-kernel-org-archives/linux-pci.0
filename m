Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7238C04EBA
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA252133F
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA252133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbeK1FwT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:52:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730813AbeK1FwT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 00:52:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43CDA37EE0;
        Tue, 27 Nov 2018 18:53:29 +0000 (UTC)
Received: from redhat.com (ovpn-116-85.ams2.redhat.com [10.36.116.85])
        by smtp.corp.redhat.com (Postfix) with SMTP id 90266600C2;
        Tue, 27 Nov 2018 18:53:19 +0000 (UTC)
Date:   Tue, 27 Nov 2018 13:53:17 -0500
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
Message-ID: <20181127131455-mutt-send-email-mst@kernel.org>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
 <20181122193801.50510-6-jean-philippe.brucker@arm.com>
 <20181123165742-mutt-send-email-mst@kernel.org>
 <fd221210-7e12-1d15-0c80-52a761f6893d@arm.com>
 <20181127125424-mutt-send-email-mst@kernel.org>
 <ef97313f-4795-9537-e0b8-8bf6751db6a6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef97313f-4795-9537-e0b8-8bf6751db6a6@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 27 Nov 2018 18:53:29 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 06:10:46PM +0000, Jean-Philippe Brucker wrote:
> On 27/11/2018 18:04, Michael S. Tsirkin wrote:
> > On Tue, Nov 27, 2018 at 05:50:50PM +0000, Jean-Philippe Brucker wrote:
> >> On 23/11/2018 22:02, Michael S. Tsirkin wrote:
> >>>> +/*
> >>>> + * __viommu_sync_req - Complete all in-flight requests
> >>>> + *
> >>>> + * Wait for all added requests to complete. When this function returns, all
> >>>> + * requests that were in-flight at the time of the call have completed.
> >>>> + */
> >>>> +static int __viommu_sync_req(struct viommu_dev *viommu)
> >>>> +{
> >>>> +	int ret = 0;
> >>>> +	unsigned int len;
> >>>> +	size_t write_len;
> >>>> +	struct viommu_request *req;
> >>>> +	struct virtqueue *vq = viommu->vqs[VIOMMU_REQUEST_VQ];
> >>>> +
> >>>> +	assert_spin_locked(&viommu->request_lock);
> >>>> +
> >>>> +	virtqueue_kick(vq);
> >>>> +
> >>>> +	while (!list_empty(&viommu->requests)) {
> >>>> +		len = 0;
> >>>> +		req = virtqueue_get_buf(vq, &len);
> >>>> +		if (!req)
> >>>> +			continue;
> >>>> +
> >>>> +		if (!len)
> >>>> +			viommu_set_req_status(req->buf, req->len,
> >>>> +					      VIRTIO_IOMMU_S_IOERR);
> >>>> +
> >>>> +		write_len = req->len - req->write_offset;
> >>>> +		if (req->writeback && len == write_len)
> >>>> +			memcpy(req->writeback, req->buf + req->write_offset,
> >>>> +			       write_len);
> >>>> +
> >>>> +		list_del(&req->list);
> >>>> +		kfree(req);
> >>>> +	}
> >>>
> >>> I didn't notice this in the past but it seems this will spin
> >>> with interrupts disabled until host handles the request.
> >>> Please do not do this - host execution can be another
> >>> task that needs the same host CPU. This will then disable
> >>> interrupts for a very very long time.
> >>
> >> In the guest yes, but that doesn't prevent the host from running another
> >> task right?
> > 
> > Doesn't prevent it but it will delay it significantly
> > until scheduler decides to kick the VCPU task out.
> > 
> >> My tests run fine when QEMU is bound to a single CPU, even
> >> though vcpu and viommu run in different threads
> >>
> >>> What to do then? Queue in software and wake up task.
> >>
> >> Unfortunately I can't do anything here, because IOMMU drivers can't
> >> sleep in the iommu_map() or iommu_unmap() path.
> >>
> >> The problem is the same
> >> for all IOMMU drivers. That's because the DMA API allows drivers to call
> >> some functions with interrupts disabled. For example
> >> Documentation/DMA-API-HOWTO.txt allows dma_alloc_coherent() and
> >> dma_unmap_single() to be called in interrupt context.
> > 
> > In fact I don't really understand how it's supposed to
> > work at all: you only sync when ring is full.
> > So host may not have seen your map request if ring
> > is not full.
> > Why is it safe to use the address with a device then?
> 
> viommu_map() calls viommu_send_req_sync(), which does the sync
> immediately after adding the MAP request.
> 
> Thanks,
> Jean

I see. So it happens on every request. Maybe you should clear
event index then. This way if exits are disabled you know that
host is processing the ring. Event index is good for when
you don't care when it will be processed, you just want
to reduce number of exits as much as possible.

-- 
MST
