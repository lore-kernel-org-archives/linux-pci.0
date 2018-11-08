Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F41ECDE4B
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 16:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDEE20857
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 16:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDEE20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeKICW6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:22:58 -0500
Received: from foss.arm.com ([217.140.101.70]:45078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeKICW6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Nov 2018 21:22:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0DF880D;
        Thu,  8 Nov 2018 08:46:38 -0800 (PST)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 243F43F5CF;
        Thu,  8 Nov 2018 08:46:36 -0800 (PST)
Subject: Re: [PATCH v3 5/7] iommu: Add virtio-iommu driver
To:     Auger Eric <eric.auger@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     mark.rutland@arm.com, peter.maydell@linaro.org,
        lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, will.deacon@arm.com,
        virtualization@lists.linux-foundation.org, marc.zyngier@arm.com,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-6-jean-philippe.brucker@arm.com>
 <20181012120953-mutt-send-email-mst@kernel.org>
 <60605670-0419-3f64-a379-9c4057d90db1@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <eebdbcd4-e7eb-d5cf-3cc9-6223d9bcfbe0@arm.com>
Date:   Thu, 8 Nov 2018 16:46:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <60605670-0419-3f64-a379-9c4057d90db1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/11/2018 14:51, Auger Eric wrote:
>>> +/*
>>> + * viommu_replay_mappings - re-send MAP requests
>>> + *
>>> + * When reattaching a domain that was previously detached from all endpoints,
>>> + * mappings were deleted from the device. Re-create the mappings available in
>>> + * the internal tree.
>>> + */
>>> +static int viommu_replay_mappings(struct viommu_domain *vdomain)
>>> +{
>>> +	int ret;
> ret needs to be initialized here. Otherwise this can lead to a crash in
> viommu_add_device.

I actually hit this one while testing the other day :) Fixed in next version

Thanks,
Jean

