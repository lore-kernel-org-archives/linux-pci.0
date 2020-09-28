Return-Path: <SRS0=RmUR=DF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E7BC2D0A8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Sep 2020 23:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E5320774
	for <linux-pci@archiver.kernel.org>; Mon, 28 Sep 2020 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601336435;
	bh=R8n7VfMaVBdjtMmbaj7tuKdOS9ilUGLpUjzTwMwX6xE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=zkPswz3c2bgoPvBW/pixuYHjaIUgwox5cjJISNyFfhLOvjB0M9NHARlO8hLqzujLX
	 8i/ysUrMIqe6ccayu80HZZkNuoa15P+u47e1VZVzPHEGNSi+ujSkpIpxn/Njoip/z5
	 GkGJQ5/4CLaurjIWrMin1U2u00i+G7LaFqcNLyKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgI1Xkb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgI1Xkb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 19:40:31 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BDB623976;
        Mon, 28 Sep 2020 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601331872;
        bh=R8n7VfMaVBdjtMmbaj7tuKdOS9ilUGLpUjzTwMwX6xE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KLkZlirErAXrcSTXBVQYtWk4y6L1U/32iwQINoIJ6TTP5XmKAabP8rX+gQLdmyZqw
         qh6pHw0/PL6zXxVfH99GVqWrZOnWewmNvE1krsz65wTZJnMhEndo2XgC5JPi+Wu6JG
         Lp2JvoP2ZqJ2EqesmIFoSBTvW/uTiyTu6QAGvDqk=
Date:   Mon, 28 Sep 2020 17:24:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] PCI/P2PDMA: drop double zeroing
Message-ID: <20200928222431.GA2501991@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600601186-7420-15-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 20, 2020 at 01:26:26PM +0200, Julia Lawall wrote:
> sg_init_table zeroes its first argument, so the allocation of that argument
> doesn't have to.
> 
> the semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x;
> @@
> 
> x =
> - kzalloc
> + kmalloc
>  (...)
> ...
> sg_init_table(x,...)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to pci/misc for v5.10, thanks!

> ---
>  drivers/pci/p2pdma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -762,7 +762,7 @@ struct scatterlist *pci_p2pmem_alloc_sgl
>  	struct scatterlist *sg;
>  	void *addr;
>  
> -	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
> +	sg = kmalloc(sizeof(*sg), GFP_KERNEL);
>  	if (!sg)
>  		return NULL;
>  
> 
