Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF78C6783C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 15:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F4720868
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 15:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F4720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeJLXbY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:31:24 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38238 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbeJLXbY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 19:31:24 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gAzpP-00015F-1h; Fri, 12 Oct 2018 09:58:16 -0600
To:     Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20181012155219.15360-1-keith.busch@intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7fa9a510-9197-a07d-958d-8b23e39cc288@deltatee.com>
Date:   Fri, 12 Oct 2018 09:58:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012155219.15360-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: helgaas@kernel.org, linux-pci@vger.kernel.org, keith.busch@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] PCI/P2PDMA: Fix freeing dev_pagemap on error
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-10-12 9:52 a.m., Keith Busch wrote:
> The devres_free() API is only to be used after the resource has been
> unlinked from the device tracking it. Calling this functino directly will
> hit a kernel BUG_ON. This patch fixes this to use the managed resource
> release function, devm_kfree().
> 
> Fixes: 1380472e7b855 ("PCI/P2PDMA: Support peer-to-peer memory")
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Oops, yes, nice catch! Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


> ---
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index da66c7e31730..9c56a10eff15 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -222,7 +222,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  	return 0;
>  
>  pgmap_free:
> -	devres_free(pgmap);
> +	devm_kfree(&pci->dev, pgmap);
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
> 
