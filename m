Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF69C10F06
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C15206B7
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="cU2c0Gzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCJ1L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:27:11 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35824 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDCJ1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 05:27:11 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B144525BDFF;
        Wed,  3 Apr 2019 20:27:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1554283630; bh=bGshz4cknrE21CA1w9W4cZ8MqHwSk4r3pYK0YffloZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cU2c0GzjFJ2I2yvADXD4Gi1uFZXUw2vKzhgQct1j44NqYXKHp5jlbXiOTrZAa7OBa
         VEFY7q1/1lsHkXXjpisCZzCWtp4TZzuKwc88tlGfiySH5soj7/+JbwjJgtHJP+Lw0w
         K1XU8k1ONPmdFBSKzGWLaMLqZSHC7kJCQHAJWKLY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id BD67C940361; Wed,  3 Apr 2019 11:27:07 +0200 (CEST)
Date:   Wed, 3 Apr 2019 11:27:07 +0200
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH V5 1/6] PCI: rcar: Clean up remaining macros defining bits
Message-ID: <20190403092707.x2skq65ll2q5m74p@verge.net.au>
References: <20190402013307.20912-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190402013307.20912-1-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 02, 2019 at 03:33:02AM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Replace macros using constants with BIT()s instead, no functional change.
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

I feel a sense of déjà vu when reading this.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


> ---
> V2: Bundle this patch with other cleanups before resending
> V3: Add Wolfram's R-B
> V4: Add Geert's R-B
> V5: Rebase on next/master 20190401
> ---
>  drivers/pci/controller/pcie-rcar.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 6a4e435bd35f..542b5bbf4bf1 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -47,14 +47,14 @@
>  /* Transfer control */
>  #define PCIETCTLR		0x02000
>  #define  DL_DOWN		BIT(3)
> -#define  CFINIT			1
> +#define  CFINIT			BIT(0)
>  #define PCIETSTR		0x02004
> -#define  DATA_LINK_ACTIVE	1
> +#define  DATA_LINK_ACTIVE	BIT(0)
>  #define PCIEERRFR		0x02020
>  #define  UNSUPPORTED_REQUEST	BIT(4)
>  #define PCIEMSIFR		0x02044
>  #define PCIEMSIALR		0x02048
> -#define  MSIFE			1
> +#define  MSIFE			BIT(0)
>  #define PCIEMSIAUR		0x0204c
>  #define PCIEMSIIER		0x02050
>  
> -- 
> 2.20.1
> 
