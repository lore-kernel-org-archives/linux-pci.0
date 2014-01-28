Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43714 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbaA1PLb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2014 10:11:31 -0500
Received: by mail-lb0-f174.google.com with SMTP id l4so449867lbv.19
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2014 07:11:30 -0800 (PST)
Message-ID: <52E7D6B5.6000003@cogentembedded.com>
Date: Tue, 28 Jan 2014 19:11:33 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-kernel@lists.codethink.co.uk
CC: Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: rcar: check platform_get_irq() return code
References: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk> <1390902468-7753-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390902468-7753-2-git-send-email-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 01/28/2014 12:47 PM, Ben Dooks wrote:

> The current code does not check the return from platform_get_irq()
> so add an error check and return if this call does fail.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> ---
>   drivers/pci/host/pci-rcar-gen2.c | 5 +++++
>   1 file changed, 5 insertions(+)

> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index ea65bac..674f7fe 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -308,6 +308,11 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
>   	priv->reg = reg;
>   	priv->dev = &pdev->dev;
>
> +	if (priv->irq < 0) {

    <= actually, as IRQ0 has been declared invalid by Linus.

> +		dev_err(&pdev->dev, "no valid irq found\n");
> +		return priv->irq;
> +	}
> +

WBR, Sergei


