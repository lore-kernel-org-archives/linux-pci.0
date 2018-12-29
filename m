Return-Path: <SRS0=Gasj=PG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D3BC43387
	for <linux-pci@archiver.kernel.org>; Sat, 29 Dec 2018 19:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A853F2145D
	for <linux-pci@archiver.kernel.org>; Sat, 29 Dec 2018 19:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeL2TSO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 29 Dec 2018 14:18:14 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34852 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbeL2TSO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Dec 2018 14:18:14 -0500
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gdK7Z-00050t-R7; Sat, 29 Dec 2018 12:18:06 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>, yu <kkndyu@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Eric Wehage <Eric.Wehage@huawei.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <CADayL-pxr_dpJykyiTeQDO13XmKPoKUs544zVrB2taHTVEx9Pw@mail.gmail.com>
 <20181229022923.GA159477@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2aa4d13a-83c5-7e15-261f-b8f69def5224@deltatee.com>
Date:   Sat, 29 Dec 2018 12:18:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181229022923.GA159477@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: alexander.h.duyck@linux.intel.com, Eric.Wehage@huawei.com, jonathan.cameron@huawei.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kkndyu@gmail.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: How to force RC to forward p2p TLPs
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-12-28 7:29 p.m., Bjorn Helgaas wrote:
>> We use the p2p DMA to transfer data between these two endpoint SOCs,
>> and if the host server is not enable ACS in BIOS, the p2p works well,
>> but when ACS is enabled in BIOS, the p2p is always failed. With the
>> help of a protocol analyzer, we can see that the TLP is redirected to
>> RC, and RC just discard it.
>>
>> I tried to find how to make RC forward redirected TLP to its original
>> target, but nothing found, it seems this is highly related to the RC
>> vendors.

As far as I know, this is not possible with any RCs I've worked with.
For our work, we ensure we disable ACS on paths between peers that want
to communicate. This is why we introduced the 'disable_acs_redir' kernel
parameter[1] to selectively disable ACS for bridges along P2P paths.

>> So is there some spec or document to describe how to set the RC? Any
>> suggestion is appreciated.

If there is, it would be the documentation for your specific RC. Odds
are, the RC simply does not support this.

Logan

[1] https://patchwork.kernel.org/patch/10549279/
