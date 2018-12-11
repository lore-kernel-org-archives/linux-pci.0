Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8956DC07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 16:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9172084E
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 16:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9172084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeLKQaE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:30:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52440 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbeLKQaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 11:30:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F121596;
        Tue, 11 Dec 2018 08:30:03 -0800 (PST)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A860C3F575;
        Tue, 11 Dec 2018 08:30:00 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v5 5/7] iommu: Add virtio-iommu driver
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
 <20181122193801.50510-6-jean-philippe.brucker@arm.com>
 <20181123165742-mutt-send-email-mst@kernel.org>
 <fd221210-7e12-1d15-0c80-52a761f6893d@arm.com>
 <20181127125424-mutt-send-email-mst@kernel.org>
 <ef97313f-4795-9537-e0b8-8bf6751db6a6@arm.com>
 <20181127131455-mutt-send-email-mst@kernel.org>
 <29bdf062-06cb-4b7d-1753-33fac609ddc3@arm.com>
 <20181210175132-mutt-send-email-mst@kernel.org>
Message-ID: <2a34ceb8-da24-fd24-f181-7d1ab15be8f8@arm.com>
Date:   Tue, 11 Dec 2018 16:29:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181210175132-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2018 22:53, Michael S. Tsirkin wrote:
> On Mon, Dec 10, 2018 at 03:06:47PM +0000, Jean-Philippe Brucker wrote:
>> On 27/11/2018 18:53, Michael S. Tsirkin wrote:
>>> On Tue, Nov 27, 2018 at 06:10:46PM +0000, Jean-Philippe Brucker wrote:
>>>> On 27/11/2018 18:04, Michael S. Tsirkin wrote:
>>>>> On Tue, Nov 27, 2018 at 05:50:50PM +0000, Jean-Philippe Brucker wrote:
>>>>>> On 23/11/2018 22:02, Michael S. Tsirkin wrote:
>>>>>>>> +/*
>>>>>>>> + * __viommu_sync_req - Complete all in-flight requests
>>>>>>>> + *
>>>>>>>> + * Wait for all added requests to complete. When this function returns, all
>>>>>>>> + * requests that were in-flight at the time of the call have completed.
>>>>>>>> + */
>>>>>>>> +static int __viommu_sync_req(struct viommu_dev *viommu)
>>>>>>>> +{
>>>>>>>> +	int ret = 0;
>>>>>>>> +	unsigned int len;
>>>>>>>> +	size_t write_len;
>>>>>>>> +	struct viommu_request *req;
>>>>>>>> +	struct virtqueue *vq = viommu->vqs[VIOMMU_REQUEST_VQ];
>>>>>>>> +
>>>>>>>> +	assert_spin_locked(&viommu->request_lock);
>>>>>>>> +
>>>>>>>> +	virtqueue_kick(vq);
>>>>>>>> +
>>>>>>>> +	while (!list_empty(&viommu->requests)) {
>>>>>>>> +		len = 0;
>>>>>>>> +		req = virtqueue_get_buf(vq, &len);
>>>>>>>> +		if (!req)
>>>>>>>> +			continue;
>>>>>>>> +
>>>>>>>> +		if (!len)
>>>>>>>> +			viommu_set_req_status(req->buf, req->len,
>>>>>>>> +					      VIRTIO_IOMMU_S_IOERR);
>>>>>>>> +
>>>>>>>> +		write_len = req->len - req->write_offset;
>>>>>>>> +		if (req->writeback && len == write_len)
>>>>>>>> +			memcpy(req->writeback, req->buf + req->write_offset,
>>>>>>>> +			       write_len);
>>>>>>>> +
>>>>>>>> +		list_del(&req->list);
>>>>>>>> +		kfree(req);
>>>>>>>> +	}
>>>>>>>
>>>>>>> I didn't notice this in the past but it seems this will spin
>>>>>>> with interrupts disabled until host handles the request.
>>>>>>> Please do not do this - host execution can be another
>>>>>>> task that needs the same host CPU. This will then disable
>>>>>>> interrupts for a very very long time.
>>>>>>
>>>>>> In the guest yes, but that doesn't prevent the host from running another
>>>>>> task right?
>>>>>
>>>>> Doesn't prevent it but it will delay it significantly
>>>>> until scheduler decides to kick the VCPU task out.
>>>>>
>>>>>> My tests run fine when QEMU is bound to a single CPU, even
>>>>>> though vcpu and viommu run in different threads
>>>>>>
>>>>>>> What to do then? Queue in software and wake up task.
>>>>>>
>>>>>> Unfortunately I can't do anything here, because IOMMU drivers can't
>>>>>> sleep in the iommu_map() or iommu_unmap() path.
>>>>>>
>>>>>> The problem is the same
>>>>>> for all IOMMU drivers. That's because the DMA API allows drivers to call
>>>>>> some functions with interrupts disabled. For example
>>>>>> Documentation/DMA-API-HOWTO.txt allows dma_alloc_coherent() and
>>>>>> dma_unmap_single() to be called in interrupt context.
>>>>>
>>>>> In fact I don't really understand how it's supposed to
>>>>> work at all: you only sync when ring is full.
>>>>> So host may not have seen your map request if ring
>>>>> is not full.
>>>>> Why is it safe to use the address with a device then?
>>>>
>>>> viommu_map() calls viommu_send_req_sync(), which does the sync
>>>> immediately after adding the MAP request.
>>>>
>>>> Thanks,
>>>> Jean
>>>
>>> I see. So it happens on every request. Maybe you should clear
>>> event index then. This way if exits are disabled you know that
>>> host is processing the ring. Event index is good for when
>>> you don't care when it will be processed, you just want
>>> to reduce number of exits as much as possible.
>>>
>>
>> I think that's already the case: since we don't attach a callback to the
>> request queue, VRING_AVAIL_F_NO_INTERRUPT is set in avail_flags_shadow,
>> which causes the used event index to stay clear.
>>
>> Thanks,
>> Jean
> 
> VRING_AVAIL_F_NO_INTERRUPT has no effect when the event index
> feature has been negotiated. In any case, it also does not
> affect kick notifications from guest - it affects
> device interrupts.

Ok, I thought we were talking about the used event. Then this is a
device-side optimization right?

In QEMU, disabling notifications while processing the queue didn't show
any difference in netperf. Kvmtool already masks events when processing
the ring - if the host is still handling requests while the guest adds
more, then the avail event is at least one behind the new avail index,
and the guest doesn't kick the host.

Anyway I think we can look at optimizations later, since I don't think
there is any trivial one that we can squash into the initial driver.
I'll resend this series with the Kconfig and header change.

Thanks,
Jean
