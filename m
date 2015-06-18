Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46464 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbbFRI3a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 04:29:30 -0400
Message-ID: <1434616169.3061.5.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: imx6: Fix non-working MSI interrupts if PCIe
 switch is attached
From: Lucas Stach <l.stach@pengutronix.de>
To: David =?ISO-8859-1?Q?M=FCller?= <dave.mueller@gmx.ch>
Cc: linux-pci@vger.kernel.org, Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Date: Thu, 18 Jun 2015 10:29:29 +0200
In-Reply-To: <1434614347-2154-1-git-send-email-dave.mueller@gmx.ch>
References: <1434614347-2154-1-git-send-email-dave.mueller@gmx.ch>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 18.06.2015, 09:59 +0200 schrieb David Müller:
> This problem has already been reported as 
> https://bugzilla.kernel.org/show_bug.cgi?id=100051
> 

I need more explanation for this one. MSI interrupts were certainly
working fine even with a PCIe switchin between some time back. I think I
personally tested things with 3.19.

In the bug report you mention that the MSI_ADDR registers are
overwritten. Where does the write come from and why is it done?

Regards,
Lucas

> Signed-off-by: David Müller <dave.mueller@gmx.ch>
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

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

