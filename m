Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521EDC5CFFE
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 17:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ABE20880
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 17:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11ABE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeLJRUN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:20:13 -0500
Received: from ale.deltatee.com ([207.54.116.67]:59916 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbeLJRUM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 12:20:12 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gWPDv-0001JP-Ve; Mon, 10 Dec 2018 10:20:05 -0700
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Eric Wehage <Eric.Wehage@huawei.com>, linuxarm@huawei.com,
        Stephen Bates <sbates@raithlin.com>
References: <20181210115653.0000615a@huawei.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <45b01572-7d53-c3d0-9a9b-77917ffe6171@deltatee.com>
Date:   Mon, 10 Dec 2018 10:20:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181210115653.0000615a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, linuxarm@huawei.com, Eric.Wehage@huawei.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com, linux-pci@vger.kernel.org, jonathan.cameron@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jonathan,

Thanks for taking this on.

On 2018-12-10 4:56 a.m., Jonathan Cameron wrote:
> I would recommend reading the ECR and presentation for more details.
> Anyone who can't get to Google Drive, email me and I'll send a copy directly.
> 
> ECR: https://drive.google.com/open?id=1X08pfyjkNwSfpTVBuiut90ajxBZd7BXg
> Slides: https://drive.google.com/open?id=11d3egA8x91d99-QqfYGZ-MxLGrHpJHCK

I've looked through the ECR now a couple times and haven't really
spotted any major issues with it.

The minimum supported bandwidth requirement is pretty vague and my
biggest concern is that hardware vendors must report consistently
otherwise this is useless. So I'd maybe suggest expanding on what's
required before hardware is allowed to indicate support.

Also, one thought is, it might be better to add another bit indicating
performance. So the hardware can say: these TLPs will be supported but
they will not be supported at high bandwidth.

In terms of defining high bandwidth: what I care about is whether the
bandwidth through the P2P link will be significantly slower than the
bandwidth of going to/from system RAM. If that's the case it probably
means a subset of P2P applications would rather just transfer to RAM
instead of going P2P.

Logan

