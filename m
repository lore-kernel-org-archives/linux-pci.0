Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33010 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbGNSeH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 14:34:07 -0400
Received: by obbgp5 with SMTP id gp5so11670783obb.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 11:34:06 -0700 (PDT)
Date: Tue, 14 Jul 2015 13:34:02 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: David =?iso-8859-1?Q?M=FCller?= <dave.mueller@gmx.ch>
Cc: linux-pci@vger.kernel.org, Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: imx6: Fix non-working MSI interrupts if PCIe switch
 is attached
Message-ID: <20150714183402.GC24416@google.com>
References: <1434614347-2154-1-git-send-email-dave.mueller@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1434614347-2154-1-git-send-email-dave.mueller@gmx.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 09:59:07AM +0200, David Müller wrote:
> This problem has already been reported as 
> https://bugzilla.kernel.org/show_bug.cgi?id=100051
> 
> Signed-off-by: David Müller <dave.mueller@gmx.ch>

Dropping for now, hoping for a repost with more info.

> ---
>  drivers/pci/host/pci-imx6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index c63691c..53f8dea 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -433,9 +433,6 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>  	dw_pcie_setup_rc(pp);
>  
>  	imx6_pcie_start_link(pp);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		dw_pcie_msi_init(pp);
>  }
>  
>  static void imx6_pcie_reset_phy(struct pcie_port *pp)
> @@ -550,6 +547,9 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  		return ret;
>  	}
>  
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +
>  	return 0;
>  }
>  
> -- 
> 1.8.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
