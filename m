Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D3CECDE4B
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696C1208E3
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 16:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696C1208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeKICWy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:22:54 -0500
Received: from foss.arm.com ([217.140.101.70]:45056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeKICWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Nov 2018 21:22:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13AD380D;
        Thu,  8 Nov 2018 08:46:35 -0800 (PST)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8167D3F5CF;
        Thu,  8 Nov 2018 08:46:32 -0800 (PST)
Subject: Re: [PATCH v3 6/7] iommu/virtio: Add probe request
To:     Auger Eric <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     mark.rutland@arm.com, peter.maydell@linaro.org,
        kevin.tian@intel.com, tnowicki@caviumnetworks.com, mst@redhat.com,
        marc.zyngier@arm.com, linux-pci@vger.kernel.org,
        jasowang@redhat.com, will.deacon@arm.com,
        kvmarm@lists.cs.columbia.edu, robh+dt@kernel.org,
        robin.murphy@arm.com
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-7-jean-philippe.brucker@arm.com>
 <295d30bb-5aef-2727-01c0-ec10c7a8fa8c@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <52102adc-ed06-da8a-9c1b-ce8ea0d31ad9@arm.com>
Date:   Thu, 8 Nov 2018 16:46:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <295d30bb-5aef-2727-01c0-ec10c7a8fa8c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/11/2018 14:48, Auger Eric wrote:
>> +struct virtio_iommu_probe_property {
>> +	__le16					type;
>> +	__le16					length;
> the value[] field has disappeared but still is documented in the v0.8 spec.

Good catch. I removed value[] when reworking the
virtio_iommu_probe_resv_mem definition, because embedding a struct with
a flexible array into another violates the C99 standard, even though GCC
accepts it.

I'll remove it from the spec as well, but I probably won't publish a new
version for this change alone. The virtio spec itself has similar uses
of flexible arrays, that are given for explanation but aren't valid C
(and those wouldn't even compile).

Thanks,
Jean
