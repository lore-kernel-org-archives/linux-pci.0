Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41771C10F14
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8E4217FA
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbfDRQ66 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:58:58 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35866 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389745AbfDRQ65 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 12:58:57 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.229])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hHAND-0003PJ-W2; Thu, 18 Apr 2019 10:58:56 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     rdunlap@infradead.org, linux-pci@vger.kernel.org
References: <20190418115859.2394-1-christian.koenig@amd.com>
 <20190418163347.GA213349@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <22b686f0-572b-d083-915f-5c46c89dfbc3@deltatee.com>
Date:   Thu, 18 Apr 2019 10:58:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418163347.GA213349@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, rdunlap@infradead.org, ckoenig.leichtzumerken@gmail.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-18 10:33 a.m., Bjorn Helgaas wrote:
> On Thu, Apr 18, 2019 at 01:58:59PM +0200, Christian König wrote:
>> A lot of root complexes can still do P2P even when PCI devices
>> don't share a common upstream bridge.
>>
>> Start adding a whitelist and allow P2P if both participants are
>> attached to known good root complex.
> 
> Is there a plan for addressing this in a generic way that doesn't
> require an OS modification for every new "known good root complex",
> e.g., some PCIe or ACPI spec update that allows the OS to discover
> this?

I'm aware of work going on in the PCI SIG to address this [1].

But I expect it's going to be a long time before actual hardware 
advertises this capability to indicate support. So in the interim we 
either need to not use p2pdma on root complexes or create a white list. 
I'm in favour of the white list approach.

Logan

[1] https://lore.kernel.org/linux-pci/20181210115653.0000615a@huawei.com/
