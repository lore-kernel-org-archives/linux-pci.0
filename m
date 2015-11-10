Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1447144878.3142.3.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6:don't sleep in atomic context
From: Lucas Stach <l.stach@pengutronix.de>
To: Sanjeev Sharma <sanjeev_sharma@mentor.com>
Cc: Richard.Zhu@freescale.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, David Mueller <dave.mueller@gmx.ch>
Date: Tue, 10 Nov 2015 09:41:18 +0100
In-Reply-To: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com>
References: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 09.11.2015, 16:18 +0530 schrieb Sanjeev Sharma:
> If additional PCIe switch get connected between the
> host and the NIC,the kernel crashes with "BUG:
> scheduling while atomic". To handle this we need to
> call mdelay() instead of usleep_range().
> 
> For more detail please refer bugzilla.kernel.org, Bug
> 100031
> 
> Signed-off-by: Sanjeev Sharma <sanjeev_sharma@mentor.com>

This is wrong. You are not the author of this patch and this should be
reflected both in the From: line as well as in the order of signoffs.

> Signed-off-by: David Mueller <dave.mueller@gmx.ch>
> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 233a196..9769b13 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -499,7 +499,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  		 * Wait a little bit, then re-check if the link finished
>  		 * the training.
>  		 */
> -		usleep_range(1000, 2000);
> +		mdelay(1000);

A mdelay(1000) is a whole different timescale than a usleep(1000). If
this patch works for you with mdelay(1) or maybe mdelay(2) I would be
fine with it.

Regards,
Lucas

>  	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

