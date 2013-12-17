Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:34928 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753983Ab3LQUpx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 Dec 2013 15:45:53 -0500
Date: Tue, 17 Dec 2013 21:45:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	bhelgaas@google.com, Jason Cooper <jason@lakedaemon.net>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: MVEBU: Remove duplicate clock get
Message-ID: <20131217204510.GA2281@lunn.ch>
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
> ---
>  drivers/pci/host/pci-mvebu.c | 8 --------
>  1 file changed, 8 deletions(-)

Hi Folks

This patch has been Acked by Jingoo Han.

So my question is, which maintainer is going to accept it for
mainline? Is there anything i need to do?

Thanks
	Andrew


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
