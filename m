Return-Path: <SRS0=4r0Q=UN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D919BC31E45
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 01:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE2021537
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 01:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hZ/DTJ5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfFNBqj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Jun 2019 21:46:39 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2917 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfFNBqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 21:46:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d02fc790000>; Thu, 13 Jun 2019 18:46:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 18:46:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 18:46:33 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 01:46:30 +0000
Subject: Re: [PATCH 04/22] mm: don't clear ->mapping in hmm_devmem_free
To:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-5-hch@lst.de>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b0584ac6-72e3-08d3-6b76-1ac5e5b3bb4f@nvidia.com>
Date:   Thu, 13 Jun 2019 18:46:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613094326.24093-5-hch@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560476793; bh=aWY+o31YpTUXYNCWR/tUiybGk+oQfQT9Eqi8enXkBOQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hZ/DTJ5kKqWdpCL12ZwwtnQNfLWFCFSPcl2k46LOsH4pNokmtsOInOl9+GJ8FKmKO
         hXZGdDzxG+P+INltKZYs7MH3/UvgeCnHg5hunwwq2bHUiutlLY5os0Z0ZWt+qrOuk9
         K1Cep9JhG5g0OourqoO6QLKWzZukRM6NdlGEbmjrnoEWvH3YVwufa/VDbhQJ2OHW1T
         paLBoqcpz6yETgLWr50DBrY8lfihmvAJXfVj+3zCeNHjlAyMFyqJD9rLf7d5TUXr4L
         SqhY59v6TJmTfzJl0WQ5JTwHaXZZRXMzmrFJGWFYPUDt0cJm6MdR4wx/+QlT3y9K7k
         1VdCdX4iXd9+w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/13/19 2:43 AM, Christoph Hellwig wrote:
> ->mapping isn't even used by HMM users, and the field at the same offset
> in the zone_device part of the union is declared as pad.  (Which btw is
> rather confusing, as DAX uses ->pgmap and ->mapping from two different
> sides of the union, but DAX doesn't use hmm_devmem_free).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 0c62426d1257..e1dc98407e7b 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -1347,8 +1347,6 @@ static void hmm_devmem_free(struct page *page, void *data)
>  {
>  	struct hmm_devmem *devmem = data;
>  
> -	page->mapping = NULL;
> -
>  	devmem->ops->free(devmem, page);
>  }
>  
> 

Yes, I think that line was unnecessary. I see from git history that it was
originally being set to NULL from within __put_devmap_managed_page(), and then
in commit 2fa147bdbf672c53386a8f5f2c7fe358004c3ef8, Dan moved it out of there,
and stashed in specifically here. But it appears to have been unnecessary from
the beginning.

Reviewed-by: John Hubbard <jhubbard@nvidia.com> 

thanks,
-- 
John Hubbard
NVIDIA
