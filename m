Return-Path: <SRS0=HNSb=UT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284FBC43613
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 19:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A632084A
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561058258;
	bh=P4EyDrZTHSPEYDPCBwBu0ObNYQuJrtV1KtNThK9IqoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UumWyB2Pm09tfL4GQmtmHZJoU1PDFDcxtN28eNye5Hoo+C+npTGsXb4OaoW7CS3Wp
	 /PaNz1uYUQNmpGn3qXNd9uSTTV4vaE+2AntQps347s6eljLJv8aFu4J0LDr2mETqaP
	 322e/oguFO1/YBBnxb2p3I9ZJWw31G8sZZgBnqpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFTTRh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:17:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:35010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfFTTRh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 15:17:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D58A5AB92;
        Thu, 20 Jun 2019 19:17:35 +0000 (UTC)
Date:   Thu, 20 Jun 2019 21:17:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
Message-ID: <20190620191733.GH12083@dhcp22.suse.cz>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613094326.24093-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 13-06-19 11:43:08, Christoph Hellwig wrote:
> noveau is currently using this through an odd hmm wrapper, and I plan
> to switch it to the real thing later in this series.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/mempolicy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 01600d80ae01..f9023b5fba37 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2098,6 +2098,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  out:
>  	return page;
>  }
> +EXPORT_SYMBOL_GPL(alloc_pages_vma);

All allocator exported symbols are EXPORT_SYMBOL, what is a reason to
have this one special?

-- 
Michal Hocko
SUSE Labs
