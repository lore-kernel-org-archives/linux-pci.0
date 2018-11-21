Return-Path: <SRS0=MCOJ=OA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41684C43441
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 12:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9A8214DB
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 12:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9A8214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeKUW4S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:56:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbeKUW4S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 17:56:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E6593154872;
        Wed, 21 Nov 2018 12:22:08 +0000 (UTC)
Received: from [10.36.116.76] (ovpn-116-76.ams2.redhat.com [10.36.116.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBDC117D78;
        Wed, 21 Nov 2018 12:21:58 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v4 5/7] iommu: Add virtio-iommu driver
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mst@redhat.com" <mst@redhat.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
References: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
 <20181115165234.43990-6-jean-philippe.brucker@arm.com>
 <64abfb83-c555-c518-1030-cb73846517fc@redhat.com>
 <41460260-417b-762f-f007-ccfd5ac1e8a5@arm.com>
 <6d003fde-9574-0ff9-0bf8-7901d1a4aa5c@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <09b4aef3-16e8-e846-9f73-be9c5a4bd805@redhat.com>
Date:   Wed, 21 Nov 2018 13:21:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <6d003fde-9574-0ff9-0bf8-7901d1a4aa5c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 21 Nov 2018 12:22:08 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi jean,

On 11/20/18 6:30 PM, Jean-Philippe Brucker wrote:
> On 16/11/2018 18:46, Jean-Philippe Brucker wrote:
>>>> +/*
>>>> + * __viommu_sync_req - Complete all in-flight requests
>>>> + *
>>>> + * Wait for all added requests to complete. When this function returns, all
>>>> + * requests that were in-flight at the time of the call have completed.
>>>> + */
>>>> +static int __viommu_sync_req(struct viommu_dev *viommu)
>>>> +{
>>>> +	int ret = 0;
>>>> +	unsigned int len;
>>>> +	size_t write_len;
>>>> +	struct viommu_request *req;
>>>> +	struct virtqueue *vq = viommu->vqs[VIOMMU_REQUEST_VQ];
>>>> +
>>>> +	assert_spin_locked(&viommu->request_lock);
>>>> +
>>>> +	virtqueue_kick(vq);
>>>> +
>>>> +	while (!list_empty(&viommu->requests)) {
>>>> +		len = 0;
>>>> +		req = virtqueue_get_buf(vq, &len);
>>>> +		if (!req)
>>>> +			continue;
>>>> +
>>>> +		if (!len)
>>>> +			viommu_set_req_status(req->buf, req->len,
>>>> +					      VIRTIO_IOMMU_S_IOERR);
>>>> +
>>>> +		write_len = req->len - req->write_offset;
>>>> +		if (req->writeback && len >= write_len)
>>> I don't get "len >= write_len". Is it valid for the device to write more
>>> than write_len? If it writes less than write_len, the status is not set,
>>> is it?
> 
> Actually, len could well be three bytes smaller than write_len. The spec
> doesn't require the device to write the three padding bytes in
> virtio_iommu_req_tail, after the status byte.
> 
> Here the driver just assumes that the device wrote the reserved field.
> The QEMU device seems to write uninitialized data in there...

Indeed that's incorrect and I should fix it. tail struct should be
properly initialized to 0. Only probe request implementation is correct.
> 
> Any objection to changing the spec to require the device to initialize
> those bytes to zero? I think it makes things nicer overall and shouldn't
> have any performance impact.
No objection from me.
> 
> [...]
>>>> +static struct iommu_domain *viommu_domain_alloc(unsigned type)
>>>> +{
>>>> +	struct viommu_domain *vdomain;
>>>> +
>>>> +	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>>> smmu drivers also support the IDENTITY type. Don't we want to support it
>>> as well?
>>
>> Eventually yes. The IDENTITY domain is useful when an IOMMU has been
>> forced upon you and gets in the way of performance, in which case you
>> get rid of it with CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y or
>> iommu.passthrough=y. For virtio-iommu though, you could simply not
>> instantiate the device.
>>
>> I don't think it's difficult to add: if the device supports
>> VIRTIO_IOMMU_F_BYPASS, then we simply don't send an ATTACH request.
>> Otherwise after ATTACH we send a MAP for the whole input range. If the
>> change isn't bigger than this, I'll add it to v5.
> 
> Not as straightforward as I hoped, when the device doesn't support
> VIRTIO_IOMMU_F_BYPASS:
> 
> * We can't simply create an ID map for the whole input range, we need to
> carve out the resv_mem regions.
> 
> * For a VFIO device, the host has no way of forwarding the identity
> mapping. For example the guest will attempt to map [0; 0xffffffffffff]
> -> [0; 0xffffffffffff], but VFIO only allows to map RAM and cannot take
> such request. One solution is to only create ID mapping for RAM, and
> register a notifier for memory hotplug, like intel-iommu does for IOMMUs
> that don't support HW pass-through.
> 
> Since it's not completely trivial and - I think - not urgent, I'll leave
> this for later.
OK makes sense to me too. It was just a head up.

Thanks

Eric
> 
> Thanks,
> Jean
> 
