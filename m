Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0733EC6787C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 19:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CD021477
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 19:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCjf5v45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CD021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeJMDEq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeJMDEq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 23:04:46 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F067D2087D;
        Fri, 12 Oct 2018 19:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539372646;
        bh=EzauUfxNT0fa4JMaXD+jaNIPwK8oMMCKoY2AVwziCZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCjf5v45Mv8yXVy/Iy/PrFIyXDoLP1XarO8URaM4tdmc4BrBXW17+MNgcg57eSZTy
         gNvEKS5XxrOjeN+84vw4eNDebGo6RGIDDQxD42N4AOtyzEC3I8rwRjF5EhgcAMmkpu
         03juyGFeu/pncDxK3tBtX04Xay+w6toFbqolAKD0=
Date:   Fri, 12 Oct 2018 14:30:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCHv2] PCI/P2PDMA: Fix freeing dev_pagemap on error
Message-ID: <20181012193044.GW5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181012155920.15418-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012155920.15418-1-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 12, 2018 at 09:59:20AM -0600, Keith Busch wrote:
> The devres_free() API is only to be used after the resource has been
> unlinked from the device tracking it. Calling this functino directly will
> hit a kernel BUG_ON. This patch fixes this to use the managed resource
> release function, devm_kfree().
> 
> Fixes: 1380472e7b855 ("PCI/P2PDMA: Support peer-to-peer memory")
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

I folded this fix into the original 1380472e7b855 commit (now
31fd98513249 ("PCI/P2PDMA: Support peer-to-peer memory"), thanks!

> ---
> v1 -> v2:
> 
>   Fixed compile breaking typo in code
> 
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
> +	devm_kfree(&pdev->dev, pgmap);
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
> -- 
> 2.14.4
> 
