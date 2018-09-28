Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E3CC43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 17:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C83206B7
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 17:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNLgp1uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C83206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeI1Xx5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbeI1Xx4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 19:53:56 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA51920676;
        Fri, 28 Sep 2018 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538155750;
        bh=r/HdSEm7R/7XHlstSZRNEVe/0ggNLHGbkUGPRLVzgKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNLgp1uvx2l2G2s/akq505ufQd+szmzobUAA6nCy26GSrZ7RivTo4Yx7xY9lGFutu
         ZwEt3ndtzYmP3NC4nYq5wOBtpJAsBKe/6B2LBLpkAnMx09MoSlHxeqTkXdNFLN/gtr
         kEihS2p+ul4liKOS0Hy7MO7cDj1fAHdcRa+7PlfU=
Date:   Fri, 28 Sep 2018 12:29:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: hotplug: Use kmemdup rather than duplicating
 its implementation in pnv_php_add_devtree()
Message-ID: <20180928172908.GC18434@bhelgaas-glaptop.roam.corp.google.com>
References: <1538031141-138417-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538031141-138417-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 27, 2018 at 06:52:21AM +0000, YueHaibing wrote:
> Use kmemdup rather than duplicating its implementation
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied with Michael's ack to pci/hotplug for v4.20, thanks!

> ---
>  drivers/pci/hotplug/pnv_php.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 5070620..ee54f5b 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -275,14 +275,13 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
>  		goto free_fdt1;
>  	}
>  
> -	fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
> +	fdt = kmemdup(fdt1, fdt_totalsize(fdt1), GFP_KERNEL);
>  	if (!fdt) {
>  		ret = -ENOMEM;
>  		goto free_fdt1;
>  	}
>  
>  	/* Unflatten device tree blob */
> -	memcpy(fdt, fdt1, fdt_totalsize(fdt1));
>  	dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
>  	if (!dt) {
>  		ret = -EINVAL;
> 
> 
> 
