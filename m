Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55002 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeBWOGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Feb 2018 09:06:50 -0500
Date: Fri, 23 Feb 2018 14:06:43 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Colin King <colin.king@canonical.com>
Cc: Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen2: remove duplicated bit-wise or of
 RCAR_PCI_INT_SIGRETABORT
Message-ID: <20180223140643.GA24211@e107981-ln.cambridge.arm.com>
References: <20180223122949.24291-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180223122949.24291-1-colin.king@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 12:29:49PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Bit pattern RCAR_PCI_INT_SIGRETABORT is being bit-wise or'd twice;
> remove the redundant 2nd RCAR_PCI_INT_SIGRETABORT.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/host/pci-rcar-gen2.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c

Applied to pci/rcar for v4.17, thanks !

Lorenzo

> index a28370bb2b2a..dd4f1a6b57c5 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -52,7 +52,6 @@
>  #define RCAR_PCI_INT_B			(1 << 17)
>  #define RCAR_PCI_INT_PME		(1 << 19)
>  #define RCAR_PCI_INT_ALLERRORS (RCAR_PCI_INT_SIGTABORT		| \
> -				RCAR_PCI_INT_SIGRETABORT	| \
>  				RCAR_PCI_INT_SIGRETABORT	| \
>  				RCAR_PCI_INT_REMABORT		| \
>  				RCAR_PCI_INT_PERR		| \
> -- 
> 2.15.1
> 
