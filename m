Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C897C10F00
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD3B2146E
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="WEjb82h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfC0L0h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:26:37 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:55596 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfC0L0h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 07:26:37 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1A5BD25B7E4;
        Wed, 27 Mar 2019 22:26:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553685994; bh=QfnVS6lJZSIQpLqWKOXL/BiVt2o3yi3jbP1xLYb34v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEjb82h/F2ZXne1F8OoK94f+6TMyUGOK16Q5qD1PpgILQ31n4Gqc1YvXRrCz3t0dJ
         lwVNJudsCDCsytDVbOUNoJ+cRAdwkjL804iqOX/zNCYQZ/uLxNRnzOj76+079GoMez
         XM4YOz8vlcfOmP3MTAlh06hqjFPjNFyfUccXtRkg=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 526EE940376; Wed, 27 Mar 2019 12:26:32 +0100 (CET)
Date:   Wed, 27 Mar 2019 12:26:32 +0100
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH V4 4/6] PCI: rcar: Replace (8 * n) with (BITS_PER_BYTE *
 n)
Message-ID: <20190327112632.k37jp5brnox3esui@verge.net.au>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
 <20190325114101.10198-4-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325114101.10198-4-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 12:40:59PM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Replace (8 * n) with (BITS_PER_BYTE * n) to make bit shift operations
> consistent. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> V2: Bundle this patch with other cleanups before resending
> V3: Add Wolfram's R-B
> V4: Change the patch from n << 3 to BITS_PER_BYTE * n
> ---
>  drivers/pci/controller/pcie-rcar.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 6699211fdc9a..96210768e774 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -170,7 +170,7 @@ enum {
>  
>  static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
>  {
> -	unsigned int shift = 8 * (where & 3);
> +	unsigned int shift = BITS_PER_BYTE * (where & 3);
>  	u32 val = rcar_pci_read_reg(pcie, where & ~3);
>  
>  	val &= ~(mask << shift);
> @@ -180,7 +180,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
>  
>  static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
>  {
> -	unsigned int shift = 8 * (where & 3);
> +	unsigned int shift = BITS_PER_BYTE * (where & 3);
>  	u32 val = rcar_pci_read_reg(pcie, where & ~3);
>  
>  	return val >> shift;
> @@ -280,9 +280,9 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
>  	}
>  
>  	if (size == 1)
> -		*val = (*val >> (8 * (where & 3))) & 0xff;
> +		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
>  	else if (size == 2)
> -		*val = (*val >> (8 * (where & 2))) & 0xffff;
> +		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
>  
>  	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
>  		bus->number, devfn, where, size, (unsigned long)*val);
> @@ -308,11 +308,11 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
>  		bus->number, devfn, where, size, (unsigned long)val);
>  
>  	if (size == 1) {
> -		shift = 8 * (where & 3);
> +		shift = BITS_PER_BYTE * (where & 3);
>  		data &= ~(0xff << shift);
>  		data |= ((val & 0xff) << shift);
>  	} else if (size == 2) {
> -		shift = 8 * (where & 2);
> +		shift = BITS_PER_BYTE * (where & 2);
>  		data &= ~(0xffff << shift);
>  		data |= ((val & 0xffff) << shift);
>  	} else
> -- 
> 2.20.1
> 
