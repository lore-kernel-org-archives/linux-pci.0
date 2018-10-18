Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EFEECDE43
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67912145D
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 10:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67912145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeJRSrt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:47:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35810 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeJRSrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Oct 2018 14:47:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED72CA78;
        Thu, 18 Oct 2018 03:47:23 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C37F3F5D3;
        Thu, 18 Oct 2018 03:47:21 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jean-philippe Brucker <jphilippe.brucker@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, kevin.tian@intel.com,
        tnowicki@caviumnetworks.com, peter.maydell@linaro.org,
        linux-pci@vger.kernel.org, will.deacon@arm.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        marc.zyngier@arm.com, jasowang@redhat.com,
        kvmarm@lists.cs.columbia.edu, jean-philippe.brucker@arm.com
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-4-jean-philippe.brucker@arm.com>
 <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
 <20181015065024-mutt-send-email-mst@kernel.org>
 <482d0eb9-8c4c-9d64-7b32-25d5d11a8b8f@gmail.com>
 <20181017111100-mutt-send-email-mst@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e609de5e-1be2-594e-a4a9-ec1a40d997ab@arm.com>
Date:   Thu, 18 Oct 2018 11:47:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017111100-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/10/18 16:14, Michael S. Tsirkin wrote:
> On Mon, Oct 15, 2018 at 08:46:41PM +0100, Jean-philippe Brucker wrote:
>> [Replying with my personal address because we're having SMTP issues]
>>
>> On 15/10/2018 11:52, Michael S. Tsirkin wrote:
>>> On Fri, Oct 12, 2018 at 02:41:59PM -0500, Bjorn Helgaas wrote:
>>>> s/iommu/IOMMU/ in subject
>>>>
>>>> On Fri, Oct 12, 2018 at 03:59:13PM +0100, Jean-Philippe Brucker wrote:
>>>>> Using the iommu-map binding, endpoints in a given PCI domain can be
>>>>> managed by different IOMMUs. Some virtual machines may allow a subset of
>>>>> endpoints to bypass the IOMMU. In some case the IOMMU itself is presented
>>>>
>>>> s/case/cases/
>>>>
>>>>> as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). Currently, when a
>>>>> PCI root complex has an iommu-map property, the driver requires all
>>>>> endpoints to be described by the property. Allow the iommu-map property to
>>>>> have gaps.
>>>>
>>>> I'm not an IOMMU or virtio expert, so it's not obvious to me why it is
>>>> safe to allow devices to bypass the IOMMU.  Does this mean a typo in
>>>> iommu-map could inadvertently allow devices to bypass it?
>>>
>>>
>>> Thinking about this comment, I would like to ask: can't the
>>> virtio device indicate the ranges in a portable way?
>>> This would minimize the dependency on dt bindings and ACPI,
>>> enabling support for systems that have neither but do
>>> have virtio e.g. through pci.
>>
>> I thought about adding a PROBE request for this in virtio-iommu, but it
>> wouldn't be usable by a Linux guest because of a bootstrapping problem.
> 
> Hmm. At some level it seems wrong to design hardware interfaces
> around how Linux happens to probe things. That can change at any time
> ...

This isn't Linux-specific though. In general it's somewhere between 
difficult and impossible to pull in an IOMMU underneath a device after 
at device is active, so if any OS wants to use an IOMMU, it's going to 
want to know up-front that it's there and which devices it translates so 
that it can program said IOMMU appropriately *before* potentially 
starting DMA and/or interrupts from the relevant devices. Linux happens 
to do things in that order (either by firmware-driven probe-deferral or 
just perilous initcall ordering) because it is the only reasonable order 
in which to do them. AFAIK the platforms which don't rely on any 
firmware description of their IOMMU tend to have a fairly static system 
architecture (such that the OS simply makes hard-coded assumptions), so 
it's not necessarily entirely clear how they would cope with 
virtio-iommu either way.

Robin.

>> Early on, Linux needs a description of device dependencies, to determine
>> in which order to probe them. If the device dependency was described by
>> virtio-iommu itself, the guest could for example initialize a NIC,
>> allocate buffers and start DMA on the physical address space (which aborts
>> if the IOMMU implementation disallows DMA by default), only to find out
>> once the virtio-iommu module is loaded that it needs to cancel all DMA and
>> reconfigure the NIC. With a static description such as iommu-map in DT or
>> ACPI remapping tables, the guest can defer probing of the NIC until the
>> IOMMU is initialized.
>>
>> Thanks,
>> Jean
> 
> Could you point me at the code you refer to here?
> 
