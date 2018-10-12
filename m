Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD71C6787C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 18:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B8D20865
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 18:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B8D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJMC3s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:29:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56388 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeJMC3s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 22:29:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD88F;
        Fri, 12 Oct 2018 11:55:55 -0700 (PDT)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0513F5D3;
        Fri, 12 Oct 2018 11:55:52 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] Add virtio-iommu driver
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     mark.rutland@arm.com, peter.maydell@linaro.org,
        kevin.tian@intel.com, tnowicki@caviumnetworks.com,
        devicetree@vger.kernel.org, jasowang@redhat.com,
        linux-pci@vger.kernel.org, will.deacon@arm.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        marc.zyngier@arm.com, robin.murphy@arm.com,
        kvmarm@lists.cs.columbia.edu
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012125443-mutt-send-email-mst@kernel.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <17f1406e-a7a0-591f-749d-21cbda37dbe4@arm.com>
Date:   Fri, 12 Oct 2018 19:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012125443-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/10/2018 18:00, Michael S. Tsirkin wrote:
> This all looks good to me. Minor nits:
> - I think DEBUG mode is best just removed for now
> - Slightly wrong patch splitup causing a misaligned structure
>   in uapi until all patches are applied.

Thanks a lot for the review, I'll fix these up and send a new version

> You should Cc Bjorn on the pci change - I'd like to see his ack on it
> being merged through my tree.

Argh, I don't know how I missed him. However patches 1-4 are device tree
changes, and need acks from Rob or Mark (on Cc)

> And pls Cc the virtio-dev list on any virtio uapi changes.
> 
> At a feature level I have some ideas for more features we
> could add, but for now I think I'll put this version in -next
> while you iron out the above wrinkles. Hope you can make the
> merge window.
Thanks, I also have some work lined up for hardware acceleration and
shared address spaces.

Jean
