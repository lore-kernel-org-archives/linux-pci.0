Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34777 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbbGNSdP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 14:33:15 -0400
Received: by obre1 with SMTP id e1so11636585obr.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 11:33:14 -0700 (PDT)
Date: Tue, 14 Jul 2015 13:33:09 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: David =?iso-8859-1?Q?M=FCller?= <dave.mueller@gmx.ch>
Cc: linux-pci@vger.kernel.org, Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
Message-ID: <20150714183309.GB24416@google.com>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 09:56:54AM +0200, David Müller wrote:
> This problem has already been reported as 
> https://bugzilla.kernel.org/show_bug.cgi?id=100031
> 
> Signed-off-by: David Müller <dave.mueller@gmx.ch>

Dropping for now, hoping for an update addressing the review comments.

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
>  	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
> -- 
> 1.8.4
> 
