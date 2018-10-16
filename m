Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D608C5ACCA
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 18:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D650A2098A
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 18:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D650A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeJQCgN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:36:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41214 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJQCgN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 22:36:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BFE880D;
        Tue, 16 Oct 2018 11:44:26 -0700 (PDT)
Received: from ostrya.localdomain (unknown [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28C293F71A;
        Tue, 16 Oct 2018 11:44:23 -0700 (PDT)
Date:   Tue, 16 Oct 2018 19:44:09 +0100
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     Auger Eric <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v3 0/7] Add virtio-iommu driver
Message-ID: <b2f929c3-b0df-acdc-c5e8-0d7ddf7ed964@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <7874471b-3711-ca44-d220-5e756ac7db8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7874471b-3711-ca44-d220-5e756ac7db8c@redhat.com>
FCC:    imap://jeabru01@foss.arm.com/Sent
X-Identity-Key: id2
X-Account-Key: account3
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=4
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/10/2018 10:25, Auger Eric wrote:
> Hi Jean,
> 
> On 10/12/18 4:59 PM, Jean-Philippe Brucker wrote:
>> Implement the virtio-iommu driver, following specification v0.8 [1].
>> Changes since v2 [2]:
>> 
>> * Patches 2-4 allow virtio-iommu to use the PCI transport, since QEMU
>>   would like to phase out the MMIO transport. This produces a complex
>>   topology where the programming interface of the IOMMU could appear
>>   lower than the endpoints that it translates. It's not unheard of (e.g.
>>   AMD IOMMU), and the guest easily copes with this.
>>   
>>   The "Firmware description" section of the specification has been
>>   updated with all combinations of PCI, MMIO and DT, ACPI.
> 
> I have a question wrt the FW specification. The IOMMU consumes 1 slot in
> the PCI domain and one needs to leave a RID hole in the iommu-map.  It
> is not obvious to me that this RID always is predictable given the pcie
> enumeration mechanism. Generally we have a coarse grain mapping of RID
> onto iommu phandles/STREAMIDs. Here, if I understand correctly we need
> to precisely identify the RID granted to the iommu. On QEMU this may
> depend on the instantiation order of the virtio-pci device right?

Yes, although it should all happen before you boot the guest, since
there is no hotplugging an IOMMU. Could you reserve a PCI slot upfront
and use it for virtio-iommu later? Or generate the iommu-map at the same
time as generating the child node of the PCI RC?

> So
> this does not look trivial to build this info. Isn't it possible to do
> this exclusion at kernel level instead?

So in theory VIRTIO_F_IOMMU_PLATFORM already does that:

VIRTIO_F_IOMMU_PLATFORM(33)
    This feature indicates that the device is behind an IOMMU that
    translates bus addresses from the device into physical addresses in
    memory. If this feature bit is set to 0, then the device emits
    physical addresses which are not translated further, even though an
    IOMMU may be present.

For better or for worse, the guest has to implement it. If this feature
bit is unset for virtio-iommu, it does DMA on the physical address
space, regardless of what the static topology description says.

In practice it doesn't quite work. If your iommu-map describes the IOMMU
as translating itself, Linux' OF code will wait for the IOMMU to be
probed before probing the IOMMU. Working around this with hacks is
possible, but I don't want to introduce more questionable code to OF and
device tree bindings if there is any other way.

Thanks,
Jean
