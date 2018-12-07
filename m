Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E4C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC79E2083D
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 17:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC79E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLGRfI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:35:08 -0500
Received: from foss.arm.com ([217.140.101.70]:50236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbeLGRfI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Dec 2018 12:35:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC1EEBD;
        Fri,  7 Dec 2018 09:35:08 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A67F3F5AF;
        Fri,  7 Dec 2018 09:35:05 -0800 (PST)
Subject: Re: [PATCH 0/2] Refactor dummy DMA ops
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, m.szyprowski@samsung.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1544199754.git.robin.murphy@arm.com>
 <20181207170519.GA26857@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <84be56f9-d195-78c3-df4d-7e0c1f71e4d9@arm.com>
Date:   Fri, 7 Dec 2018 17:35:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207170519.GA26857@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/12/2018 17:05, Christoph Hellwig wrote:
> So I'd really prefer if we had a separate dummy.c file, like in
> my take on your previous patch here:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/e01adddc1733fa414dc16cd22e8f58be9b64a025
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/596bde76e5944a3f4beb8c2769067ca88dda127a
> 
> Otherwise this looks fine.  If you don't minde I'll take your patches,
> apply the move to a separate file and merge it into the above tree.

Sure - TBH I did consider creating a separate file, but then didn't for 
mysterious reasons that don't stand up to scrutiny. If you're happy to 
do the fixup on top that's fine by me (if culling .map_resource was 
intentional, please scrub the last bit of the commit message to match).

I'll make the equivalent change locally anyway just in case there's any 
other cause to resend.

Robin.
