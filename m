Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E87C5ACCC
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4585621470
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 20:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4585621470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeJQEXe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQEXe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 00:23:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C443155DB;
        Tue, 16 Oct 2018 20:31:26 +0000 (UTC)
Received: from [10.36.118.67] (unknown [10.36.118.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 197C677F83;
        Tue, 16 Oct 2018 20:31:19 +0000 (UTC)
Subject: Re: [PATCH v3 0/7] Add virtio-iommu driver
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <7874471b-3711-ca44-d220-5e756ac7db8c@redhat.com>
 <b2f929c3-b0df-acdc-c5e8-0d7ddf7ed964@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c7167c51-d864-08f5-c128-f4b3257840ce@redhat.com>
Date:   Tue, 16 Oct 2018 22:31:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b2f929c3-b0df-acdc-c5e8-0d7ddf7ed964@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 16 Oct 2018 20:31:26 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 10/16/18 8:44 PM, Jean-Philippe Brucker wrote:
> On 16/10/2018 10:25, Auger Eric wrote:
>> Hi Jean,
>>
>> On 10/12/18 4:59 PM, Jean-Philippe Brucker wrote:
>>> Implement the virtio-iommu driver, following specification v0.8 [1].
>>> Changes since v2 [2]:
>>>
>>> * Patches 2-4 allow virtio-iommu to use the PCI transport, since QEMU
>>>    would like to phase out the MMIO transport. This produces a complex
>>>    topology where the programming interface of the IOMMU could appear
>>>    lower than the endpoints that it translates. It's not unheard of (e.g.
>>>    AMD IOMMU), and the guest easily copes with this.
>>>    
>>>    The "Firmware description" section of the specification has been
>>>    updated with all combinations of PCI, MMIO and DT, ACPI.
>>
>> I have a question wrt the FW specification. The IOMMU consumes 1 slot in
>> the PCI domain and one needs to leave a RID hole in the iommu-map.  It
>> is not obvious to me that this RID always is predictable given the pcie
>> enumeration mechanism. Generally we have a coarse grain mapping of RID
>> onto iommu phandles/STREAMIDs. Here, if I understand correctly we need
>> to precisely identify the RID granted to the iommu. On QEMU this may
>> depend on the instantiation order of the virtio-pci device right?
> 
> Yes, although it should all happen before you boot the guest, since
> there is no hotplugging an IOMMU. Could you reserve a PCI slot upfront
> and use it for virtio-iommu later? Or generate the iommu-map at the same
> time as generating the child node of the PCI RC?

Even when cold-plugging the PCIe devices through qemu CLI, this depends
on the order of the pcie devices in the list I guess. I need to further
experiment.
> 
>> So
>> this does not look trivial to build this info. Isn't it possible to do
>> this exclusion at kernel level instead?
> 
> So in theory VIRTIO_F_IOMMU_PLATFORM already does that:
> 
> VIRTIO_F_IOMMU_PLATFORM(33)
>     This feature indicates that the device is behind an IOMMU that
>     translates bus addresses from the device into physical addresses in
>     memory. If this feature bit is set to 0, then the device emits
>     physical addresses which are not translated further, even though an
>     IOMMU may be present.

This tells the driver to use the dma api, right? Effectively this
explicitly says whether the device is supposed to be upfront an IOMMU.
> 
> For better or for worse, the guest has to implement it. If this feature
> bit is unset for virtio-iommu, it does DMA on the physical address
> space, regardless of what the static topology description says.
> 
> In practice it doesn't quite work. If your iommu-map describes the IOMMU
> as translating itself, Linux' OF code will wait for the IOMMU to be
> probed before probing the IOMMU. Working around this with hacks is
> possible, but I don't want to introduce more questionable code to OF and
> device tree bindings if there is any other way.
Hum ok. I cannot really comment on this.

I just wanted to raise this concern about RID identfication.

Thanks

Eric
> 
> Thanks,
> Jean
> 
