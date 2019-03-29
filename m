Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3A1C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E3B218A2
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553880249;
	bh=VC4PyqRuLdoo3kJeLqcTkeedPqD2aigIHEsXG/WvdXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PQr4+H4LccmV2olJmcYuzcaPmRSUMjIhw9oP1prkstjqr1hQ4nDnzsaM45H+dyfgJ
	 qUpQDExwrGTnF4iSoJl8t9ftD6po+IMMotRjcxZ+fJORP8wZlvvvg5mAxaMEBItuk+
	 +CDsaTRN7b8UeLJtyezyvdw/Cz1qKfejYYyD8Wvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfC2RYI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbfC2RYI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 13:24:08 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8605E206B7;
        Fri, 29 Mar 2019 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553880247;
        bh=VC4PyqRuLdoo3kJeLqcTkeedPqD2aigIHEsXG/WvdXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XaeoYxfB4xX1jfhvGuFD1WI4kG+oFo3r1S3pW+ox5/B43OnMZuqtpT8oFsiV+9Cw+
         u9BRIA7PCBsYOE/vk5/YvaWN+1vM0bvRT4dcEZjmNHRArK6U+zE5OxFght0BcU+gif
         xoZeW5pdZYT2VFr0N++31z8hdFteGOty//947LTo=
Date:   Fri, 29 Mar 2019 12:24:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] pci/p2pdma: Fix the gen_pool_add_virt() failure path
Message-ID: <20190329172406.GE24180@google.com>
References: <155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155387325926.2443841.6674640070856872301.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155387325926.2443841.6674640070856872301.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 29, 2019 at 08:27:39AM -0700, Dan Williams wrote:
> The pci_p2pdma_add_resource() implementation immediately frees the pgmap
> if gen_pool_add_virt() fails. However, that means that when @dev
> triggers a devres release devm_memremap_pages_release() will crash
> trying to access the freed @pgmap.
> 
> Use the new devm_memunmap_pages() to manually free the mapping in the
> error path.
> 
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Especially if you run "git log --oneline drivers/pci/p2pdma.c" and make
yours match :),

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index c52298d76e64..595a534bd749 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -208,13 +208,15 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  			pci_bus_address(pdev, bar) + offset,
>  			resource_size(&pgmap->res), dev_to_node(&pdev->dev));
>  	if (error)
> -		goto pgmap_free;
> +		goto pages_free;
>  
>  	pci_info(pdev, "added peer-to-peer DMA memory %pR\n",
>  		 &pgmap->res);
>  
>  	return 0;
>  
> +pages_free:
> +	devm_memunmap_pages(&pdev->dev, pgmap);
>  pgmap_free:
>  	devm_kfree(&pdev->dev, pgmap);
>  	return error;
> 
