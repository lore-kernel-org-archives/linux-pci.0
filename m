Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4AEC10F00
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C082087C
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="XafF8aHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbfC0LYx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:24:53 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:55540 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfC0LYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 07:24:53 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E280D25B7E4;
        Wed, 27 Mar 2019 22:24:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553685891; bh=pc+lpVcP9grwOXLYVjmFPsR2MiOYhLLFhrJ1F8GnlLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XafF8aHeGAlatrDeFCWV/WfQncTxVhLIgEasLtKcO78NIdfZ1/h3aZ/WvHLJUyCu+
         qmiUhVmhwQE3fqqYhYKPL/HCmGSQ/bpg4ugtqSS5noy9PbMSXXMA6/92RhWSTjof2x
         sJ1PbvleZmiDBxAWth/rxN5hCExBuc3k99//43tI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 33A1D940376; Wed, 27 Mar 2019 12:24:49 +0100 (CET)
Date:   Wed, 27 Mar 2019 12:24:49 +0100
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH V4 2/6] PCI: rcar: Replace unsigned long with
 u32/unsigned int in register accessors
Message-ID: <20190327112448.fo7nmvbc3xrl3tjd@verge.net.au>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
 <20190325114101.10198-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325114101.10198-2-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 12:40:57PM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Replace unsigned long with u32 and unsigned int in register accessor
> functions, since they access 32bit registers.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> V2: Bundle this patch with other cleanups before resending
> V3: Add Wolfram's R-B
> V4: Change reg to unsigned int
> ---
>  drivers/pci/controller/pcie-rcar.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 5b8736f0cd6b..3db693b4410e 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -152,14 +152,13 @@ struct rcar_pcie {
>  	struct			rcar_msi msi;
>  };
>  
> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> -			       unsigned long reg)
> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val,
> +			       unsigned int reg)
>  {
>  	writel(val, pcie->base + reg);
>  }
>  
> -static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
> -				       unsigned long reg)
> +static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int reg)
>  {
>  	return readl(pcie->base + reg);
>  }
> -- 
> 2.20.1
> 
