Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:43120 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab3LIX3I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 18:29:08 -0500
Received: by mail-qc0-f175.google.com with SMTP id e9so3282840qcy.20
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 15:29:07 -0800 (PST)
Date: Mon, 9 Dec 2013 16:29:04 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: MVEBU: Remove duplicate clock get
Message-ID: <20131209232904.GD4699@google.com>
References: <1386178241-10453-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386178241-10453-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 04, 2013 at 06:30:41PM +0100, Andrew Lunn wrote:
> Probably due to a merge conflict resolution gone bad, the pci clock is
> got twice. Remove the second redundent of_clk_get_by_name().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied to my pci/host-mvebu branch for v3.14, thanks!

Bjorn

> ---
>  drivers/pci/host/pci-mvebu.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index c269e430c760..96352be58cc9 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -949,14 +949,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  
>  		mvebu_pcie_set_local_dev_nr(port, 1);
>  
> -		port->clk = of_clk_get_by_name(child, NULL);
> -		if (IS_ERR(port->clk)) {
> -			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
> -			       port->port, port->lane);
> -			iounmap(port->base);
> -			continue;
> -		}
> -
>  		port->dn = child;
>  		spin_lock_init(&port->conf_lock);
>  		mvebu_sw_pci_bridge_init(port);
> -- 
> 1.8.5
> 
