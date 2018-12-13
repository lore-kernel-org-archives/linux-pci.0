Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A117C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056252087F
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056252087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeLMMu5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:50:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33196 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbeLMMu4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 07:50:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48B1FEBD;
        Thu, 13 Dec 2018 04:50:56 -0800 (PST)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33D83F575;
        Thu, 13 Dec 2018 04:50:52 -0800 (PST)
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
 <20181212103545.GV16835@8bytes.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
Date:   Thu, 13 Dec 2018 12:50:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181212103545.GV16835@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joerg,

On 12/12/2018 10:35, Joerg Roedel wrote:
> Hi,
> 
> to make progress on this, we should first agree on the protocol used
> between guest and host. I have a few points to discuss on the protocol
> first.
> 
> On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
>> [1] Virtio-iommu specification v0.9, sources and pdf
>>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
>>     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
> 
> Looking at this I wonder why it doesn't make the IOTLB visible to the
> guest. the UNMAP requests seem to require that the TLB is already
> flushed to make the unmap visible.
> 
> I think that will cost significant performance for both, vfio and
> dma-iommu use-cases which both do (vfio at least to some degree),
> deferred flushing.

We already do deferred flush: UNMAP requests are added to the queue by
iommu_unmap(), and then flushed out by iotlb_sync(). So we switch to the
host only on iotlb_sync(), or when the request queue is full.

> I also wonder whether the protocol should implement a
> protocol version handshake and iommu-feature set queries.

With the virtio transport there is a handshake when the device (IOMMU)
is initialized, through feature bits and global config fields. Feature
bits are made of both transport-specific features, including the version
number, and device-specific features defined in section 2.3 of the above
document (the transport is described in the virtio 1.0 specification).
The device presents features that it supports in a register, and the
driver masks out the feature bits that it doesn't support. Then the
driver sets the global status to FEATURES_OK and initialization continues.

In addition virtio-iommu has per-endpoint features through the PROBE
request, since the vIOMMU may manage hardware (VFIO) and software
(virtio) endpoints at the same time, which don't have the same DMA
capabilities (different IOVA ranges, page granularity, reserved ranges,
pgtable sharing, etc). At the moment this is a one-way probe, not a
handshake. The device simply fills the properties of each endpoint, but
the driver doesn't have to ack them. Initially there was a way to
negotiate each PROBE property but it was deemed unnecessary during
review. By leaving a few spare bits in the property headers I made sure
it can be added back with a feature bit if we ever need it.

>> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.1
>>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> 
> Unfortunatly gitweb seems to be broken on linux-arm.org. What is missing
> in this patch-set to make this work on x86?

You should be able to access it here:
http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/virtio-iommu/devel

That branch contains missing bits for x86 support:

* ACPI support. We have the code but it's waiting for an IORT spec
update, to reserve the IORT node ID. I expect it to take a while, given
that I'm alone requesting a change for something that's not upstream or
in hardware.

* DMA ops for x86 (see "HACK" commit). I'd like to use dma-iommu but I'm
not sure how to implement the glue that sets dma_ops properly.

Thanks,
Jean
