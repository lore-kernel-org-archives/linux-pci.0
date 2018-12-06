Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F1CC64EB1
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 22:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643E52082B
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 22:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643E52082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbeLFWRD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:17:03 -0500
Received: from ale.deltatee.com ([207.54.116.67]:46458 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeLFWRD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 17:17:03 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gV1x7-0005U1-Hk; Thu, 06 Dec 2018 15:17:03 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181130225911.2900-1-logang@deltatee.com>
 <20181206204643.GC247703@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c226426d-e88c-da18-f643-f3faaf1c0dbd@deltatee.com>
Date:   Thu, 6 Dec 2018 15:17:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181206204643.GC247703@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] PCI/P2PDMA: Match interface changes to
 devm_memremap_pages()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-12-06 1:46 p.m., Bjorn Helgaas wrote:
> On Fri, Nov 30, 2018 at 03:59:11PM -0700, Logan Gunthorpe wrote:
>> "mm-hmm-mark-hmm_devmem_add-add_resource-export_symbol_gpl.patch" in the
>> mm tree breaks p2pdma. The patch was written and reviewed before p2pdma
>> was merged so the necessary changes were not done to the call site in
>> that code.
>>
>> Without this patch, all drivers will fail to register P2P resources
>> because devm_memremap_pages() will return -EINVAL due to the 'kill'
>> member of the pagemap structure not yet being set.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> 
> Applied with Dan's reviewed-by to pci/peer-to-peer for v4.21, thanks!
> 
> If the mm patch you mention gets merged for v4.20, let me know and I can
> promote this to for-linus so v4.20 doesn't end up broken.

Thanks Bjorn, but I think Andrew has also picked it up in the mm tree
with the patch in question. My hope is that he squashes the two but I'm
not sure what his intentions are. I mostly copied you for  information
purposes as this patch shouldn't even compile without Dan's patch.

Though, I guess we'll find out what goes in after the merge window --
you may not need to do anything.

Logan

