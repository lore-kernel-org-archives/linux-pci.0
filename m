Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E504ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0223A214C2
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG5XkhP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0223A214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeJQWHr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:07:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39807 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJQWHr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 18:07:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id e67-v6so3779935plb.6;
        Wed, 17 Oct 2018 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FaPs55bqnuyP+FLEaAyUF6ZVLn1DpC5Q1ZV5DDxmVWE=;
        b=GG5XkhP98u4EMlVzOg/HseeCXBGQEGCq1wcI+2ysjM1JnHVUCjB3Elf5VFyB0cUUFk
         brjT4E9WcBlJYIa01FUQami5ezSqlqQRRDLd+8mOg9/4K/EyGc9SK/U/+F5MtdEMZZAx
         f11x8VChaFs+/83qlX6XGlO7uUch3c5zMgd9xmwY2ETyD16MzRlVYTVmg31JbhNQPMWq
         hljhbmz8oW8L2ROMDgYeyKOOsE0A7vm/UUGsOqGwrLZrrPFYgSX21KiYWdZZ071ifFdZ
         QAI3T9p4z2X3oWiZ3zAykAmvQGOF69yuIDWw+hJ37XMU7n2c9aDjHl+gl0+GRwxvWc3C
         x7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FaPs55bqnuyP+FLEaAyUF6ZVLn1DpC5Q1ZV5DDxmVWE=;
        b=Ia+JNi/0yP7U6oqTXToGI0mHLHw43nvGZTHncpAzEX+GlTcy+PwrV9VoVk5V1e/i0H
         aGtzUxVWN/i/ztRrXcbyjXdLLD0n3/rgO9wHymm9bRPwqUh29sWEvsWZ3t7j02VncY4h
         +2WR+5KCiNDIfqkWGybBfcxAE+xvZv85B+NuWZtE86dSkRfzAhhlC3ZtcMWdt4mTUSKL
         OtVy9GW08ALQ68NArpniScIq9mqIGXaJ1Z4Py9IcZOPHf4nGkBox0ZhItksxFeMvWi/l
         8Ed1sk+xg9cT84evCDmaouwZRcg2dSQQXaT+BhDtGT8Im0tXUrbQu0bHl1egxPxRgS+T
         Ylag==
X-Gm-Message-State: ABuFfoj4pAUdTZRXL99zwABfjyOb8PQVepz5CtL2dykw8123gF7camJH
        ZOWfy3A7u2YM7V1mjPeeEaw=
X-Google-Smtp-Source: ACcGV604vbnaYACb/pZtykEZIR0bkCgs67WnJ5iTjfK9Di33TUdI109HyVeqOfgi50s0OKtDRZ4JXA==
X-Received: by 2002:a17:902:b70d:: with SMTP id d13-v6mr25819322pls.44.1539785514600;
        Wed, 17 Oct 2018 07:11:54 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id y24-v6sm34215688pfi.24.2018.10.17.07.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 07:11:54 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:11:52 +0000
From:   Du Changbin <changbin.du@gmail.com>
To:     bhelgaas@google.com, changbin.du@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: make pci_size() return real size
Message-ID: <20181017135151.mg22ki76ywta6c5i@mail.google.com>
References: <20181013004919.3202-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013004919.3202-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn. Have you checked this little improvment? The idea here is that
this is not a hotspot, so readbility matters than trick. Thanks!

On Sat, Oct 13, 2018 at 08:49:19AM +0800, changbin.du@gmail.com wrote:
> From: Du Changbin <changbin.du@gmail.com>
> 
> Currently, the pci_size() function actually return 'size-1'.
> Make it return real size to avoid confusing.
> 
> Signed-off-by: Du Changbin <changbin.du@gmail.com>
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

-- 
Thanks,
Du Changbin
