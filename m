Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312E5C10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCE3214AE
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 17:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDVRb0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:31:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40962 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfDVRb0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 13:31:26 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hIcmp-0001UW-Rg; Mon, 22 Apr 2019 11:31:25 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Eric Pilmore <epilmore@gigaio.com>,
        linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc:     S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
Message-ID: <bce9a1d6-1c37-b9f8-a613-2ba68211fee1@deltatee.com>
Date:   Mon, 22 Apr 2019 11:31:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dmeyer@gigaio.com, staylor@gigaio.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, epilmore@gigaio.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: AMD IO_PAGE_FAULT w/NTB on Write ops?
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-22 11:14 a.m., Logan Gunthorpe wrote:
> My guess is that the reason writes work and not reads is because the
> write TLPs are posted and thus the switch doesn't apply the Proxy ID
> seeing it doesn't expect a completion. Thus the IOMMU sees the TLPs as
> coming from a permitted peripheral and doesn't complain.

Oh, oops, sounds like I got that backwards as you seem to indicate reads
work but not writes. That doesn't make as much sense to me, but I still
think it's a proxy_id problem.

Take a look at [1]. It reads to me like the AMD IOMMU only supports the
last DMA alias. So most of the proxy IDs for the switchtec device we
register are probably ignored...

One way or another I expect the working cases are because they come from
a specific proxy ID and the broken cases come from a proxy ID that the
AMD IOMMU doesn't consider.

Logan


[1]
https://elixir.bootlin.com/linux/latest/source/drivers/iommu/amd_iommu.c#L245
