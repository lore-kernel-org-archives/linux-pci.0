Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF234C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 12:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B72C216B7
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 12:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B72C216B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeI0SrC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:47:02 -0400
Received: from ozlabs.org ([203.11.71.1]:48835 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbeI0SrC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 14:47:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42LYyG19HFz9s3l;
        Thu, 27 Sep 2018 22:28:53 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     YueHaibing <yuehaibing@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: hotplug: Use kmemdup rather than duplicating its implementation in pnv_php_add_devtree()
In-Reply-To: <1538031141-138417-1-git-send-email-yuehaibing@huawei.com>
References: <1538031141-138417-1-git-send-email-yuehaibing@huawei.com>
Date:   Thu, 27 Sep 2018 22:28:48 +1000
Message-ID: <874lebunsv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:

> Use kmemdup rather than duplicating its implementation
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
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

Looks correct to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
