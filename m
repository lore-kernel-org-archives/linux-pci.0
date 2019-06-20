Return-Path: <SRS0=HNSb=UT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B94C43613
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D002F2054F
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 19:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561059164;
	bh=8C5ear/8zTtMZ0LBDK1mK0ZvR/qZxdvGeoifdbEEM2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U8h3xY0vnlprtWknQwhde42zOaqz7wD632lkkBVkqTSBwHEDtmrAXc26qRxNfqM3A
	 P/+g4dcsLeRWcy7/k3dqKrEgOmYyXl2eEoJl2Ah3JDQL9je37OzmoSEvx4so0Fonnw
	 pxVU3OHwA9UhHZF6ItlnVjWMKtwzgRHGqYACzu60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFTTco (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:32:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:36802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfFTTco (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 15:32:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21B8DAC9A;
        Thu, 20 Jun 2019 19:32:42 +0000 (UTC)
Date:   Thu, 20 Jun 2019 21:32:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/22] mm: remove hmm_devmem_add_resource
Message-ID: <20190620193241.GJ12083@dhcp22.suse.cz>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613094326.24093-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 13-06-19 11:43:06, Christoph Hellwig wrote:
> This function has never been used since it was first added to the kernel
> more than a year and a half ago, and if we ever grow a consumer of the
> MEMORY_DEVICE_PUBLIC infrastructure it can easily use devm_memremap_pages
> directly now that we've simplified the API for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/hmm.h |  3 ---
>  mm/hmm.c            | 54 ---------------------------------------------
>  2 files changed, 57 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 4867b9da1b6c..5761a39221a6 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -688,9 +688,6 @@ struct hmm_devmem {
>  struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
>  				  struct device *device,
>  				  unsigned long size);
> -struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
> -					   struct device *device,
> -					   struct resource *res);
>  
>  /*
>   * hmm_devmem_page_set_drvdata - set per-page driver data field
> diff --git a/mm/hmm.c b/mm/hmm.c
> index ff2598eb7377..0c62426d1257 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -1445,58 +1445,4 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
>  	return devmem;
>  }
>  EXPORT_SYMBOL_GPL(hmm_devmem_add);
> -
> -struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
> -					   struct device *device,
> -					   struct resource *res)
> -{
> -	struct hmm_devmem *devmem;
> -	void *result;
> -	int ret;
> -
> -	if (res->desc != IORES_DESC_DEVICE_PUBLIC_MEMORY)
> -		return ERR_PTR(-EINVAL);
> -
> -	dev_pagemap_get_ops();
> -
> -	devmem = devm_kzalloc(device, sizeof(*devmem), GFP_KERNEL);
> -	if (!devmem)
> -		return ERR_PTR(-ENOMEM);
> -
> -	init_completion(&devmem->completion);
> -	devmem->pfn_first = -1UL;
> -	devmem->pfn_last = -1UL;
> -	devmem->resource = res;
> -	devmem->device = device;
> -	devmem->ops = ops;
> -
> -	ret = percpu_ref_init(&devmem->ref, &hmm_devmem_ref_release,
> -			      0, GFP_KERNEL);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	ret = devm_add_action_or_reset(device, hmm_devmem_ref_exit,
> -			&devmem->ref);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	devmem->pfn_first = devmem->resource->start >> PAGE_SHIFT;
> -	devmem->pfn_last = devmem->pfn_first +
> -			   (resource_size(devmem->resource) >> PAGE_SHIFT);
> -	devmem->page_fault = hmm_devmem_fault;
> -
> -	devmem->pagemap.type = MEMORY_DEVICE_PUBLIC;
> -	devmem->pagemap.res = *devmem->resource;
> -	devmem->pagemap.page_free = hmm_devmem_free;
> -	devmem->pagemap.altmap_valid = false;
> -	devmem->pagemap.ref = &devmem->ref;
> -	devmem->pagemap.data = devmem;
> -	devmem->pagemap.kill = hmm_devmem_ref_kill;
> -
> -	result = devm_memremap_pages(devmem->device, &devmem->pagemap);
> -	if (IS_ERR(result))
> -		return result;
> -	return devmem;
> -}
> -EXPORT_SYMBOL_GPL(hmm_devmem_add_resource);
>  #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
