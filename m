Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DB4ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 17:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5CA21486
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 17:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zo82dkkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5CA21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeJRBPn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJRBPn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 21:15:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0940121477;
        Wed, 17 Oct 2018 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539796744;
        bh=5wuvp4GW/XB8Mln5fn1vNVJR8WnMlp1joJivA7xQwK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zo82dkkJ70yGxsiTYDH0Z19jGL2gSnnqmuO/eQxdlXW9CsCv5bfkUmJhVJ1TnR29p
         HIcY0G4cHNqVUXG4mOV7o0+6J5/h3et9cEqpg17Ifuc5j48IhKFrF4DklWXdrDb0FG
         7LjZTQomigRVmoAoY52OZGmzIWVDvbHvsIVKb28A=
Date:   Wed, 17 Oct 2018 12:19:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PCI/P2PDMA: Fix NULL check in pci_p2pmem_publish()
Message-ID: <20181017171902.GH5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181017160510.17926-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017160510.17926-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 17, 2018 at 10:05:10AM -0600, Logan Gunthorpe wrote:
> We should only assign 'p2pmem_published' if 'pdev->p2pdma' is not NULL.
> The extra check on 'publish' makes no sense.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christoph Hellwig <hch@infradead.org>

I folded this into the original commit on pci/peer-to-peer, thanks!

> ---
>  drivers/pci/p2pdma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index da66c7e31730..d710b5ef65a1 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -678,10 +678,8 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_free_sgl);
>   */
>  void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>  {
> -	if (publish && !pdev->p2pdma)
> -		return;
> -
> -	pdev->p2pdma->p2pmem_published = publish;
> +	if (pdev->p2pdma)
> +		pdev->p2pdma->p2pmem_published = publish;
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>  
> -- 
> 2.19.0
> 
