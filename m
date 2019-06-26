Return-Path: <SRS0=+zKV=UZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B312C48BD3
	for <linux-pci@archiver.kernel.org>; Wed, 26 Jun 2019 12:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42E22086D
	for <linux-pci@archiver.kernel.org>; Wed, 26 Jun 2019 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561552586;
	bh=iHn6rSeQRufY3qGVGTLcrwCnSUsmGdMMl+F7D3zZUJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XoQCEyffCXHbbwKy9kBL3GcfhS6+4pLd16uysg6kZUSuU8PWgiQNEXrqd9ie+6UGX
	 Cxa+xs1pFkME8RhNj9lvXOUFA+diCvolhsiw1b3A6nzFz8mlL4XwR2N1aFaZVTqynr
	 xq4TG0/BmYh0Z34ThCUU9KbEhv0Bmr6+lfo70Mg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFZMg0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:36:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfFZMg0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 08:36:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A640BAD78;
        Wed, 26 Jun 2019 12:36:24 +0000 (UTC)
Date:   Wed, 26 Jun 2019 14:36:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 06/25] mm: export alloc_pages_vma
Message-ID: <20190626123623.GU17798@dhcp22.suse.cz>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626122724.13313-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 26-06-19 14:27:05, Christoph Hellwig wrote:
> nouveau is currently using this through an odd hmm wrapper, and I plan
> to switch it to the real thing later in this series.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/mempolicy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 01600d80ae01..f48569aa1863 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2098,6 +2098,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  out:
>  	return page;
>  }
> +EXPORT_SYMBOL(alloc_pages_vma);
>  
>  /**
>   * 	alloc_pages_current - Allocate pages.
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
