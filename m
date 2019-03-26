Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7722DC10F05
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 13:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4752B20823
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 13:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfCZNEw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:04:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36070 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfCZNEw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 09:04:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E27041596;
        Tue, 26 Mar 2019 06:04:51 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43C4F3F59C;
        Tue, 26 Mar 2019 06:04:50 -0700 (PDT)
Date:   Tue, 26 Mar 2019 13:04:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH V4 1/6] PCI: rcar: Clean up remaining macros defining bits
Message-ID: <20190326130444.GA5466@e107981-ln.cambridge.arm.com>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325114101.10198-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 12:40:56PM +0100, marek.vasut@gmail.com wrote:
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
> ---
> V2: Bundle this patch with other cleanups before resending
> V3: Add Wolfram's R-B
> V4: Add Geert's R-B
> ---
>  drivers/pci/controller/pcie-rcar.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Hi Marek,

I assume this series makes:

https://patchwork.ozlabs.org/patch/1053779/
https://patchwork.ozlabs.org/patch/1057454/

obsolete, please let me know and I will drop
them from the PCI patches queue, I will get to
this series later for v5.2.

Thanks,
Lorenzo

> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index c8febb009454..5b8736f0cd6b 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -46,14 +46,14 @@
>  
>  /* Transfer control */
>  #define PCIETCTLR		0x02000
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
