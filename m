Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDFDC6783C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 15:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E1320868
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 15:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E1320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeJLXcl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:32:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:11780 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbeJLXcl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 19:32:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 08:59:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="240837146"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2018 08:59:32 -0700
Date:   Fri, 12 Oct 2018 09:56:34 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] PCI/P2PDMA: Fix freeing dev_pagemap on error
Message-ID: <20181012155634.GA15408@localhost.localdomain>
References: <20181012155219.15360-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012155219.15360-1-keith.busch@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 12, 2018 at 09:52:19AM -0600, Keith Busch wrote:
> The devres_free() API is only to be used after the resource has been
> unlinked from the device tracking it. Calling this functino directly will
> hit a kernel BUG_ON. This patch fixes this to use the managed resource
> release function, devm_kfree().
> 
> Fixes: 1380472e7b855 ("PCI/P2PDMA: Support peer-to-peer memory")
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
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
                    ^^^

That should be 'pdev', not 'pci'. I need to slow down the workflow, I'm
pointing send-email to the wrong patches again...
