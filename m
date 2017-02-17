Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932655AbdBQU0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Feb 2017 15:26:06 -0500
Date: Fri, 17 Feb 2017 14:26:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yadi Hu <yadi.hu@windriver.com>
Cc: lftan@altera.com, linux-pci@vger.kernel.org,
        rfi@lists.rocketboards.org
Subject: Re: [PATCH] PCI: altera: Fix TLP completion status
Message-ID: <20170217202602.GE17762@bhelgaas-glaptop.roam.corp.google.com>
References: <1487291230-21495-1-git-send-email-yadi.hu@windriver.com>
 <1487291230-21495-2-git-send-email-yadi.hu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487291230-21495-2-git-send-email-yadi.hu@windriver.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 17, 2017 at 08:27:10AM +0800, Yadi Hu wrote:
> From: "Hu Yadi" <yadi.hu@windriver.com>
> 
> the driver does not use exactly 'Completion Status' value in TLP,
> these bits should be b15:13 not b14:12.
> 
> Signed-off-by: Hu Yadi<yadi.hu@windriver.com>

Applied with Ley Foon's ack to pci/host-altera for v4.11, thanks.

BTW, the patch was apparently built against an old kernel (pre-v4.9), so it
didn't apply directly.  But I applied it by hand.

> ---
>  drivers/pci/host/pcie-altera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index dbac6fb..650862e 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -56,7 +56,7 @@
>  #define TLP_CFG_DW2(bus, devfn, offset)	\
>  				(((bus) << 24) | ((devfn) << 16) | (offset))
>  #define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
> -#define TLP_COMP_STATUS(s)		(((s) >> 12) & 7)
> +#define TLP_COMP_STATUS(s)		(((s) >> 13) & 7)
>  #define TLP_HDR_SIZE			3
>  #define TLP_LOOP			500
>  #define RP_DEVFN			0
> -- 
> 2.9.3
> 
