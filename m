Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F4FC04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B9521479
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544129206;
	bh=amuUvMxpJWV46hx0oiukiUlpBnZDBmSr6eXs853GzVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ws1py2w2+mkkDKiJbTW1kEOKyi5/SDhzO9A9mWFrXSoSdwG+kWoNQu5njKxzWtnv3
	 xjmnXHZQUcg6oLCGThwnYqcXelHtJ+3lhyxYgsLUps/2dPoA4geIpozHWrL96zzHg+
	 8WwNrKpmmLMBoYhxeV5r16DGLh6KBfUztOsKG8kA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B9521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbeLFUqp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeLFUqp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 15:46:45 -0500
Received: from localhost (unknown [66.115.192.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E7821479;
        Thu,  6 Dec 2018 20:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544129204;
        bh=amuUvMxpJWV46hx0oiukiUlpBnZDBmSr6eXs853GzVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3hEujkW70nJoe5C0++vV53fdvjZdg+ijB1YbB/hrVKCG5sJDr90b2lh5Yx70Bev7
         p0xxBbDooWvuN6bsr3h6hejGy+IzgiAzOM062isJUjddpdIRzSdp1jp+FJ660+9vKg
         6J5vBKuTdWq1+bqB6IjTVh4hnnATlMXSy5FTm6TI=
Date:   Thu, 6 Dec 2018 14:46:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] PCI/P2PDMA: Match interface changes to
 devm_memremap_pages()
Message-ID: <20181206204643.GC247703@google.com>
References: <20181130225911.2900-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130225911.2900-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 30, 2018 at 03:59:11PM -0700, Logan Gunthorpe wrote:
> "mm-hmm-mark-hmm_devmem_add-add_resource-export_symbol_gpl.patch" in the
> mm tree breaks p2pdma. The patch was written and reviewed before p2pdma
> was merged so the necessary changes were not done to the call site in
> that code.
> 
> Without this patch, all drivers will fail to register P2P resources
> because devm_memremap_pages() will return -EINVAL due to the 'kill'
> member of the pagemap structure not yet being set.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Applied with Dan's reviewed-by to pci/peer-to-peer for v4.21, thanks!

If the mm patch you mention gets merged for v4.20, let me know and I can
promote this to for-linus so v4.20 doesn't end up broken.

> ---
> 
> Ideally this patch should be squashed with the one mentioned above to
> avoid a bisect regression point.
> 
> drivers/pci/p2pdma.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index ae3c5b25dcc7..a2eb25271c96 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -82,10 +82,8 @@ static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
>  	complete_all(&p2p->devmap_ref_done);
>  }
> 
> -static void pci_p2pdma_percpu_kill(void *data)
> +static void pci_p2pdma_percpu_kill(struct percpu_ref *ref)
>  {
> -	struct percpu_ref *ref = data;
> -
>  	/*
>  	 * pci_p2pdma_add_resource() may be called multiple times
>  	 * by a driver and may register the percpu_kill devm action multiple
> @@ -198,6 +196,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
>  	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
>  		pci_resource_start(pdev, bar);
> +	pgmap->kill = pci_p2pdma_percpu_kill;
> 
>  	addr = devm_memremap_pages(&pdev->dev, pgmap);
>  	if (IS_ERR(addr)) {
> @@ -211,11 +210,6 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  	if (error)
>  		goto pgmap_free;
> 
> -	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_percpu_kill,
> -					  &pdev->p2pdma->devmap_ref);
> -	if (error)
> -		goto pgmap_free;
> -
>  	pci_info(pdev, "added peer-to-peer DMA memory %pR\n",
>  		 &pgmap->res);
> 
> --
> 2.19.0
