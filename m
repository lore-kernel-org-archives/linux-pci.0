Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E640C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 16:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C916F21473
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548867215;
	bh=EQQWAuT6c9Qs6U/7ZkxPFtmaz+H/NurHWFHLdtCSkgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QIOJQXZl0Ni2UkiBle+mqyb398EqWVQ84ZAWdF5mfd7liq8psahhOX3TfLyeQ+eRT
	 NwyYzsMisZjJt+QKvPj6M+sdye6zmDubb7i76m9V1Uu3yyGR11/dU7BdfnQzerikzM
	 OT5AfgxADjXtu4b7yVLbq0kZXHb/+Nlw/GciclOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbfA3Qxf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:53:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732101AbfA3Qxe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 11:53:34 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E762086C;
        Wed, 30 Jan 2019 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548867214;
        bh=EQQWAuT6c9Qs6U/7ZkxPFtmaz+H/NurHWFHLdtCSkgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGForqrkGWdQ/X5dI8NY8a0ZRA2ALAlY79TD66XPUoZKAmQN6PyQ3wLpUU+eSj2n+
         mN11LvP2aR8FVO4Q7SCaLWz0s9vMHlA5Ju7PjLviNenZ7DUDcMwjui2MpiTo2Gcsfr
         rj+VDde9Cr+sWfAZ24Q+oKj3fHRVGkTWk0cMOg0I=
Date:   Wed, 30 Jan 2019 10:53:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     changbin.du@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: make pci_size() return real size
Message-ID: <20190130165332.GG229773@google.com>
References: <20181013004919.3202-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013004919.3202-1-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 13, 2018 at 08:49:19AM +0800, changbin.du@gmail.com wrote:
> From: Du Changbin <changbin.du@gmail.com>
> 
> Currently, the pci_size() function actually return 'size-1'.
> Make it return real size to avoid confusing.
> 
> Signed-off-by: Du Changbin <changbin.du@gmail.com>

Applied to pci/enumeration for v5.1, thanks!

I think it's good to have the "end = start + size - 1" idiom made more
obvious to help avoid off-by-one errors.

> ---
>  drivers/pci/probe.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 201f9e5ff55c..8ff2b1413865 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -121,13 +121,13 @@ static u64 pci_size(u64 base, u64 maxbase, u64 mask)
>  	 * Get the lowest of them to find the decode size, and from that
>  	 * the extent.
>  	 */
> -	size = (size & ~(size-1)) - 1;
> +	size = size & ~(size-1);
>  
>  	/*
>  	 * base == maxbase can be valid only if the BAR has already been
>  	 * programmed with all 1s.
>  	 */
> -	if (base == maxbase && ((base | size) & mask) != mask)
> +	if (base == maxbase && ((base | (size - 1)) & mask) != mask)
>  		return 0;
>  
>  	return size;
> @@ -278,7 +278,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  			/* Above 32-bit boundary; try to reallocate */
>  			res->flags |= IORESOURCE_UNSET;
>  			res->start = 0;
> -			res->end = sz64;
> +			res->end = sz64 - 1;
>  			pci_info(dev, "reg 0x%x: can't handle BAR above 4GB (bus address %#010llx)\n",
>  				 pos, (unsigned long long)l64);
>  			goto out;
> @@ -286,7 +286,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  	}
>  
>  	region.start = l64;
> -	region.end = l64 + sz64;
> +	region.end = l64 + sz64 - 1;
>  
>  	pcibios_bus_to_resource(dev->bus, res, &region);
>  	pcibios_resource_to_bus(dev->bus, &inverted_region, res);
> -- 
> 2.17.1
> 
