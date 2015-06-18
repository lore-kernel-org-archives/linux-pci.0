Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46449 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbbFRI1E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 04:27:04 -0400
Message-ID: <1434616021.3061.2.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
From: Lucas Stach <l.stach@pengutronix.de>
To: David =?ISO-8859-1?Q?M=FCller?= <dave.mueller@gmx.ch>
Cc: linux-pci@vger.kernel.org, Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Date: Thu, 18 Jun 2015 10:27:01 +0200
In-Reply-To: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 18.06.2015, 09:56 +0200 schrieb David Müller:
> This problem has already been reported as 
> https://bugzilla.kernel.org/show_bug.cgi?id=100031
> 
> Signed-off-by: David Müller <dave.mueller@gmx.ch>
> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fdb9536..c63691c 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -489,7 +489,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  		 * Wait a little bit, then re-check if the link finished
>  		 * the training.
>  		 */
> -		usleep_range(1000, 2000);
> +		mdelay(20);

While switching to mdelay might be the right thing to do here, you are
also changing the timeout. This is a change in behavior and so not okay.
Especially as you keep the CPU spinning for the duration of that
timeout.
 
>  	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

