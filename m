Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57000C67839
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 19:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7F820870
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 19:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7F820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeLKTIH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:08:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbeLKTIH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 14:08:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCFBAEBD;
        Tue, 11 Dec 2018 11:08:06 -0800 (PST)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13FBC3F6A8;
        Tue, 11 Dec 2018 11:08:03 -0800 (PST)
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mark.rutland@arm.com, virtio-dev@lists.oasis-open.org,
        kevin.tian@intel.com, tnowicki@caviumnetworks.com,
        devicetree@vger.kernel.org, marc.zyngier@arm.com,
        linux-pci@vger.kernel.org, mst@redhat.com, will.deacon@arm.com,
        frowand.list@gmail.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        kvmarm@lists.cs.columbia.edu, bhelgaas@google.com,
        robin.murphy@arm.com, jasowang@redhat.com
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
 <20181211183101.GA31936@infradead.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <f9cb0ebe-4d9f-50f1-9f61-89d0e55ceddc@arm.com>
Date:   Tue, 11 Dec 2018 19:07:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181211183101.GA31936@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/12/2018 18:31, Christoph Hellwig wrote:
> On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
>> Implement the virtio-iommu driver, following specification v0.9 [1].
>>
>> Only minor changes since v5 [2]. I fixed issues reported by Michael and
>> added tags from Eric and Bharat. Thanks!
>>
>> You can find Linux driver and kvmtool device on v0.9 branches [3],
>> module and x86 support on virtio-iommu/devel. Also tested with Eric's
>> QEMU device [4].
> 
> Just curious, what is the use case for it?

The main use case is assigning a device to guest userspace, using VFIO
both in the host and in the guest (the most cited example being DPDK).
There are others, and I wrote a little more about them last week:
https://www.spinics.net/lists/linux-pci/msg78529.html

Thanks,
Jean
