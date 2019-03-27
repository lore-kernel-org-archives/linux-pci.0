Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A0FC10F00
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A541A2147C
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="NJBOMSpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbfC0L2C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:28:02 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:55620 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfC0L2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 07:28:01 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id A0ABE25BE09;
        Wed, 27 Mar 2019 22:27:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553686079; bh=/vw+Q5mhlGtKEvrvd5pHDPgxdloII9FHsN5dCi86KCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJBOMSpr4Bty53GdHC3dB0XoThtEZcLWrMzSOYmRT7C9w2P66Vf3TnrpXmCj5dG9l
         6CJEXyYLYUG64RJVnIFFVjeowqPW2a+Jr5736T9ftbGiZu4tRRM1MjnMlIiqQaq+JZ
         MX44yk4JeUvIFWP1FAFVa7LOUjZWH3exmlgOmPaE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id E7E4E940376; Wed, 27 Mar 2019 12:27:57 +0100 (CET)
Date:   Wed, 27 Mar 2019 12:27:57 +0100
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH V4 5/6] PCI: rcar: Clean up debug messages
Message-ID: <20190327112757.uipyrki5kqbgxgyc@verge.net.au>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
 <20190325114101.10198-5-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325114101.10198-5-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 12:41:00PM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Drop useless casts from debug messages, they are no longer needed
> due to the data type cleanup.

Great! The fewer casts the better.

> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> V2: - Bundle this patch with other cleanups before resending
>     - Add R-B from Geert
> V3: Add Wolfram's R-B
> V4: No change
> ---
>  drivers/pci/controller/pcie-rcar.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 96210768e774..c6013f95bdb2 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -284,8 +284,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
>  	else if (size == 2)
>  		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
>  
> -	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
> -		bus->number, devfn, where, size, (unsigned long)*val);
> +	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
> +		bus->number, devfn, where, size, *val);
>  
>  	return ret;
>  }
> @@ -304,8 +304,8 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
>  	if (ret != PCIBIOS_SUCCESSFUL)
>  		return ret;
>  
> -	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
> -		bus->number, devfn, where, size, (unsigned long)val);
> +	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
> +		bus->number, devfn, where, size, val);
>  
>  	if (size == 1) {
>  		shift = BITS_PER_BYTE * (where & 3);
> -- 
> 2.20.1
> 
