Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753330AbdJTXFz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 19:05:55 -0400
Date: Fri, 20 Oct 2017 18:05:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] PCI: faraday: fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20171020230551.GY6332@bhelgaas-glaptop.roam.corp.google.com>
References: <20171017170717.GA30633@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171017170717.GA30633@embeddedor.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 12:07:17PM -0500, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in faraday_pci_probe.
> The proper pointer to be passed as argument is p->bus_clk.
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Huh, I merged the identical fix posted by Wei Yongjun 5 hours earlier :)
Thanks!

> ---
> This code was tested by compilation only.
> 
>  drivers/pci/host/pci-ftpci100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
> index 06d9687..fae6bd1 100644
> --- a/drivers/pci/host/pci-ftpci100.c
> +++ b/drivers/pci/host/pci-ftpci100.c
> @@ -463,7 +463,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
>  	}
>  	p->bus_clk = devm_clk_get(dev, "PCICLK");
>  	if (IS_ERR(p->bus_clk))
> -		return PTR_ERR(clk);
> +		return PTR_ERR(p->bus_clk);
>  	ret = clk_prepare_enable(p->bus_clk);
>  	if (ret) {
>  		dev_err(dev, "could not prepare PCICLK\n");
> -- 
> 2.7.4
> 
