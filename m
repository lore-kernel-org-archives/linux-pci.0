Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E6C43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 13:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182D72133F
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 13:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfAKNAt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:00:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55092 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731545AbfAKNAt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 08:00:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 697A380D;
        Fri, 11 Jan 2019 05:00:48 -0800 (PST)
Received: from [10.1.196.128] (ostrya.cambridge.arm.com [10.1.196.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 293023F70D;
        Fri, 11 Jan 2019 05:00:45 -0800 (PST)
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
 <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
 <20190111122846.GE5825@8bytes.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <08283b53-2f87-05e7-e71c-8780b34d9018@arm.com>
Date:   Fri, 11 Jan 2019 13:00:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190111122846.GE5825@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/01/2019 12:28, Joerg Roedel wrote:
> Hi Jean-Philippe,
> 
> On Thu, Dec 13, 2018 at 12:50:29PM +0000, Jean-Philippe Brucker wrote:
>> We already do deferred flush: UNMAP requests are added to the queue by
>> iommu_unmap(), and then flushed out by iotlb_sync(). So we switch to the
>> host only on iotlb_sync(), or when the request queue is full.
> 
> So the mappings can stay in place until iotlb_sync() returns? What
> happens when the guest sends a map-request for a region it sent and
> unmap request before, but did not call iotlb_sync inbetween?

At that point the unmap is still in the request queue, and the host will
handle it before getting to the map request. For correctness requests
are necessarily handled in-order by the host. So if the map and unmap
refer to the same domain and IOVA, the host will remove the old mapping
before creating the new one.

Thanks,
Jean
