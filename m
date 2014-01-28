Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:53781 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbaA1UTV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2014 15:19:21 -0500
Received: by mail-la0-f41.google.com with SMTP id mc6so797038lab.14
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2014 12:19:19 -0800 (PST)
Message-ID: <52E810C4.102@cogentembedded.com>
Date: Wed, 29 Jan 2014 00:19:16 +0400
From: Valentine <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
To: Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-kernel@lists.codethink.co.uk
CC: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: rcar: check platform_get_irq() return code
References: <1390903616-8073-1-git-send-email-ben.dooks@codethink.co.uk> <1390903616-8073-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390903616-8073-2-git-send-email-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/28/2014 02:06 PM, Ben Dooks wrote:
> The current code does not check the return from platform_get_irq()
> so add an error check and return if this call does fail.
>

If you have really experienced this error your platform data is incorrect.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

> ---
> Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> ---
>   drivers/pci/host/pci-rcar-gen2.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index ea65bac..674f7fe 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -308,6 +308,11 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
>   	priv->reg = reg;
>   	priv->dev = &pdev->dev;
>
> +	if (priv->irq < 0) {
> +		dev_err(&pdev->dev, "no valid irq found\n");
> +		return priv->irq;
> +	}
> +
>   	return rcar_pci_add_controller(priv);
>   }
>
>

