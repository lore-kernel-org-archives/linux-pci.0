Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeDHP1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Apr 2018 11:27:50 -0400
Subject: Re: [PATCH V2] PCI: rcar: Clean up the macros
To: Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20180408130942.19148-1-marek.vasut+renesas@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7f63726a-fb96-a329-cce4-d1dd64b33de7@infradead.org>
Date: Sun, 8 Apr 2018 08:27:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180408130942.19148-1-marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/08/2018 06:09 AM, Marek Vasut wrote:
> This patch replaces the (1 << n) with BIT(n) and cleans up whitespace,
> no functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: Reword the commit message
> ---
>  drivers/pci/host/pcie-rcar.c | 52 ++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 25f68305322c..5ab7bf6a8de0 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -30,9 +30,9 @@

missing this:

#include <linux/bitops.h>

>  #define PCIECAR			0x000010
>  #define PCIECCTLR		0x000018
> -#define  CONFIG_SEND_ENABLE	(1 << 31)
> +#define  CONFIG_SEND_ENABLE	BIT(31)
>  #define  TYPE0			(0 << 8)
> -#define  TYPE1			(1 << 8)
> +#define  TYPE1			BIT(8)
>  #define PCIECDR			0x000020
>  #define PCIEMSR			0x000028
>  #define PCIEINTXR		0x000400
> @@ -44,7 +44,7 @@
>  #define PCIETSTR		0x02004
>  #define  DATA_LINK_ACTIVE	1
>  #define PCIEERRFR		0x02020
> -#define  UNSUPPORTED_REQUEST	(1 << 4)
> +#define  UNSUPPORTED_REQUEST	BIT(4)
>  #define PCIEMSIFR		0x02044
>  #define PCIEMSIALR		0x02048
>  #define  MSIFE			1
> @@ -57,17 +57,17 @@
>  /* local address reg & mask */
>  #define PCIELAR(x)		(0x02200 + ((x) * 0x20))
>  #define PCIELAMR(x)		(0x02208 + ((x) * 0x20))
> -#define  LAM_PREFETCH		(1 << 3)
> -#define  LAM_64BIT		(1 << 2)
> -#define  LAR_ENABLE		(1 << 1)
> +#define  LAM_PREFETCH		BIT(3)
> +#define  LAM_64BIT		BIT(2)
> +#define  LAR_ENABLE		BIT(1)
>  
>  /* PCIe address reg & mask */
>  #define PCIEPALR(x)		(0x03400 + ((x) * 0x20))
>  #define PCIEPAUR(x)		(0x03404 + ((x) * 0x20))
>  #define PCIEPAMR(x)		(0x03408 + ((x) * 0x20))
>  #define PCIEPTCTLR(x)		(0x0340c + ((x) * 0x20))
> -#define  PAR_ENABLE		(1 << 31)
> -#define  IO_SPACE		(1 << 8)
> +#define  PAR_ENABLE		BIT(31)
> +#define  IO_SPACE		BIT(8)


-- 
~Randy
