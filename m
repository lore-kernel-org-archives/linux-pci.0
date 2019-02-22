Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F3C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 12:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A852075A
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 12:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfBVMSj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:18:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfBVMSj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Feb 2019 07:18:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68223A78;
        Fri, 22 Feb 2019 04:18:38 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 549BE3F690;
        Fri, 22 Feb 2019 04:18:35 -0800 (PST)
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "mst@redhat.com" <mst@redhat.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190123083435.x3svwqp472mdgglw@8bytes.org>
 <a6315ab3-bffb-7470-365d-b26df6524bda@arm.com>
 <878sy8bx9o.fsf@morokweng.localdomain>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <76121ff1-0777-085a-5b38-d38b2c6cb25f@arm.com>
Date:   Fri, 22 Feb 2019 12:18:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <878sy8bx9o.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thiago,

On 21/02/2019 22:18, Thiago Jung Bauermann wrote:
> 
> Hello Jean-Philippe,
> 
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> writes:
>> Makes sense, though I think other virtio devices have been developed a
>> little more organically: device and driver code got upstreamed first,
>> and then the specification describing their interface got merged into
>> the standard. For example I believe that code for crypto, input and GPU
>> devices were upstreamed long before the specification was merged. Once
>> an implementation is upstream, the interface is expected to be
>> backward-compatible (all subsequent changes are introduced using feature
>> bits).
>>
>> So I've been working with this process in mind, also described by Jens
>> at KVM forum 2017 [3]:
>> (1) Reserve a device ID, and get that merged into virtio (ID 23 for
>> virtio-iommu was reserved last year)
>> (2) Open-source an implementation (this driver and Eric's device)
>> (3) Formalize and upstream the device specification
>>
>> But I get that some overlap between (2) and (3) would have been better.
>> So far the spec document has been reviewed mainly from the IOMMU point
>> of view, and might require more changes to be in line with the other
>> virtio devices -- hopefully just wording changes. I'll kick off step
>> (3), but I think the virtio folks are a bit busy with finalizing the 1.1
>> spec so I expect it to take a while.
> 
> I read v0.9 of the spec and have some minor comments, hope this is a
> good place to send them:

Thanks a lot, I'll fix them in my next posting. Note that I recently
sent v0.10 to virtio-comment, to request inclusion into the standard [1]
but your comments still apply to v0.10.

[1]
https://lists.oasis-open.org/archives/virtio-comment/201901/msg00016.html

> 1. In section 2.6.2, one reads
> 
>     If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered and the range
>     described by fields virt_start and virt_end doesn’t fit in the range
>     described by input_range, the device MAY set status to VIRTIO_-
>     IOMMU_S_RANGE and ignore the request.
> 
> Shouldn't int say "If the VIRTIO_IOMMU_F_INPUT_RANGE feature is
> negotiated" instead?

Yes, that seems clearer and more consistent with other devices, I'll
change it. In this case "offered" is equivalent to "negotiated", because
the driver SHOULD accept the feature or else the device may refuse to
set FEATURES_OK. A valid input_range field generally indicates that the
device is incapable of creating mappings outside this range, and it's
important that the driver acknowledges it.

> 2. There's a typo at the end of section 2.6.5:
> 
>     The VIRTIO_IOMMU_MAP_F_MMIO flag is a memory type rather than a
>     protection lag.
> 
> s/lag/flag/

Fixed in v0.10

> 3. In section 3.1.2.1.1, the viommu compatible field says "virtio,mmio".
> Shouldn't it say "virtio,mmio-iommu" instead, to be consistent with
> "virtio,pci-iommu"?

"virtio,mmio" already exists, and allows the virtio-mmio driver to pick
up any virtio device. The device type is then discovered while probing,
and doesn't need to be in the compatible string.

"virtio,pci-iommu" is something I introduced specifically for the
virtio-iommu, since it's the only virtio-pci device that requires a
device tree node - to describe the IOMMU topology earlier than the PCI
probe. If we want symmetry I'd rather replace "virtio,pci-iommu" with
"virtio,pci", but it wouldn't be used by other virtio device types. And
I have to admit I'm reluctant to change this binding now, given that it
has been reviewed (patch 2/7) and is ready to go.

> 4. There's a typo in section 3.3:
> 
>     A host bridge may limit the input address space – transaction
>     accessing some addresses won’t reach the physical IOMMU.
> 
> s/transaction/transactions/

I'll fix it, thanks

> I also have one last comment which you may freely ignore, considering
> it's clearly just personal opinion and also considering that the
> specification is mature at this point: it specifies memory ranges by
> specifying start and end addresses. My experience has been that this is
> error prone, leading to confusion and bugs regarding whether the end
> address is inclusive or exclusive. I tend to prefer expressing memory
> ranges by specifying a start address and a length, which eliminates
> ambiguity.

While the initial versions had start and length, I changed it because it
cannot express the whole 64-bit range. If the guest wants to do
unmap-all (and the input range is 64-bit), then it can send a single
UNMAP request with start=0, end=~0ULL, which wouldn't be possible with
start and length. Arguably a very rare use-case, but one I've tried to
implement at least twice with VFIO :) I'll see if I can make it more
obvious that end is inclusive, since the word doesn't appear at all in
the current draft.

Thanks,
Jean
