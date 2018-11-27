Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94809C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA012086B
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 17:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA012086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbeK1E5W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:57:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44156 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbeK1E5W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 23:57:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 415F31DC8;
        Tue, 27 Nov 2018 09:58:41 -0800 (PST)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58F8F3F575;
        Tue, 27 Nov 2018 09:58:38 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v5 5/7] iommu: Add virtio-iommu driver
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
 <20181122193801.50510-6-jean-philippe.brucker@arm.com>
 <20181123164716-mutt-send-email-mst@kernel.org>
Message-ID: <0fed79f3-ca2e-b539-74f5-cd2a8091f65d@arm.com>
Date:   Tue, 27 Nov 2018 17:58:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181123164716-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/11/2018 21:48, Michael S. Tsirkin wrote:
>> +struct virtio_iommu_config {
>> +	/* Supported page sizes */
>> +	__u64					page_size_mask;
>> +	/* Supported IOVA range */
>> +	struct virtio_iommu_range		input_range;
>> +	/* Max domain ID size */
>> +	__u8					domain_bits;
>> +	__u8					padding[3];
> 
> Not enough padding here it seems. Structure is 8 byte
> aligned on 64 bit systems.

The next field (probe_size) is 4 bytes, so the alignment ends up fine.
That field is introduced in patch 6, maybe I should move it here?

Thanks,
Jean
