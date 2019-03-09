Return-Path: <SRS0=rJvA=RM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AF7C10F00
	for <linux-pci@archiver.kernel.org>; Sat,  9 Mar 2019 11:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8696020449
	for <linux-pci@archiver.kernel.org>; Sat,  9 Mar 2019 11:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="kCFj+AU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbfCILOO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 9 Mar 2019 06:14:14 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33257 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfCILON (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Mar 2019 06:14:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id h71so192260lfe.0
        for <linux-pci@vger.kernel.org>; Sat, 09 Mar 2019 03:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MAOrQ+Gi7pTa1U823xnZmJ85XRtCvB9YgrGTgn+aFPk=;
        b=kCFj+AU3iSRyF4XgkZYKnuAkKfJIkFOe1vkYFadQjmIQHUJpdC9oXp+nBN6gnod4cK
         2S5WnJljHskwWmV2lSXdaTqg7pBxGK/TAHW6ljyZO6iPZxPWmk+t5gLi4lJOcGsNTy8l
         KdZBmCrgXrRPc7QxztXUu/gzgZ3yrs5gUxriXq3OBLfSFiP1rQV4RwhqY7L0l6U1qKcT
         /pjZdJxsQNlmPbqn0lRPTo8ETCLBYFiCY6mjcgX+fMqapKnH77er9K6S4dJlNVkp3AtX
         q5cAJUP9YEajg66wrxHyeO6Rhn91kmAtxmtQyouqKI/McycVDR9oaxjPhxWCv5xxNXtd
         rIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MAOrQ+Gi7pTa1U823xnZmJ85XRtCvB9YgrGTgn+aFPk=;
        b=IavXfdR9jtgWMw4aTG+gzU1AC4y35QqAKd0vOJg2tcmk6RDJEelgPlghjIBkEW7RjH
         ausMm9+9vyNflcJVR5+HJenh+3+ASwErXXhGp9I1NTLf4C7WBlPNJmYJ3eYVuR+FAHBO
         0S7XmPYBe6tO6Pt5CPFLP0caaZZyHgWJrSu8bfZjn3awCk9kC3lfC4USglfC6T42iQkZ
         wfT7cT549lDdQA4MkJqjFk3lod6MbkT67qLTce3fcOIrPUVKH04BjwMW7k8ky+0prX6L
         eRGRrvnb+qN1m+H2F0yWIrECZaPcmQYtJW5Wsu9RRNoiDCFTxg0HZDS+4RgTLOYvHCGE
         QezQ==
X-Gm-Message-State: APjAAAWY+zpBMmUGAiOMjQwnXjUMBd0d5PZlGSg7EZXaCZBAs5B1Y/5z
        u76ur4lVp/xBarCwG0FPn4BZ1Q==
X-Google-Smtp-Source: APXvYqxVxow8XaLVJvojxd6nRPaClHc6BzOyHXPmdPqKMbRWC9Qq8rn67LbhMxegF4WSThJh6h2X7g==
X-Received: by 2002:ac2:55ad:: with SMTP id y13mr13391844lfg.97.1552130051659;
        Sat, 09 Mar 2019 03:14:11 -0800 (PST)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id c86sm39701ljf.28.2019.03.09.03.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 03:14:11 -0800 (PST)
Date:   Sat, 9 Mar 2019 12:14:10 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: rcar: Replace unsigned long with u32 in
 register accessors
Message-ID: <20190309111410.GC5281@bigcity.dyn.berto.se>
References: <20190309005613.1493-1-marek.vasut@gmail.com>
 <20190309005613.1493-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190309005613.1493-2-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

Thanks for your work.

On 2019-03-09 01:56:13 +0100, Marek Vasut wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Replace unsigned long with u32 in register accessor functions,
> since they access 32bit registers.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/pci/controller/pcie-rcar.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 5b8736f0cd6b..1408c8aa758b 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -152,14 +152,12 @@ struct rcar_pcie {
>  	struct			rcar_msi msi;
>  };
>  
> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> -			       unsigned long reg)
> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)
>  {
>  	writel(val, pcie->base + reg);
>  }
>  
> -static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
> -				       unsigned long reg)
> +static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, u32 reg)
>  {
>  	return readl(pcie->base + reg);
>  }
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
