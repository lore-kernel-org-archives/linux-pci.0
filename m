Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754123AbeEOPSa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 11:18:30 -0400
Date: Tue, 15 May 2018 16:18:26 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use pci_irq_vector function
Message-ID: <20180515151826.GB31726@e107981-ln.cambridge.arm.com>
References: <a9f06365aedf72e34781716ffff89b375c9f5642.1526318738.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a9f06365aedf72e34781716ffff89b375c9f5642.1526318738.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 14, 2018 at 06:27:48PM +0100, Gustavo Pimentel wrote:
> Replace "pdev->irq + index" operation by the pci_irq_vector() call,
> that converts from device vector to Linux IRQ.
> (suggestion made by Alan Douglas).

I have converted it to a Suggested-by tag.

> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to pci/endpoint for v4.18, thanks.

Lorenzo

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index fe8897e..28d0cd9 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -203,7 +203,7 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
>  	if (!val)
>  		return false;
>  
> -	if (test->last_irq - pdev->irq == msi_num - 1)
> +	if (pci_irq_vector(pdev, msi_num - 1) == test->last_irq)
>  		return true;
>  
>  	return false;
> @@ -525,12 +525,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	}
>  
>  	for (i = 1; i < irq; i++) {
> -		err = devm_request_irq(dev, pdev->irq + i,
> +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>  				       pci_endpoint_test_irqhandler,
>  				       IRQF_SHARED, DRV_MODULE_NAME, test);
>  		if (err)
>  			dev_err(dev, "failed to request IRQ %d for MSI %d\n",
> -				pdev->irq + i, i + 1);
> +				pci_irq_vector(pdev, i), i + 1);
>  	}
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> @@ -592,7 +592,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	}
>  
>  	for (i = 0; i < irq; i++)
> -		devm_free_irq(dev, pdev->irq + i, test);
> +		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
>  
>  err_disable_msi:
>  	pci_disable_msi(pdev);
> @@ -625,7 +625,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  			pci_iounmap(pdev, test->bar[bar]);
>  	}
>  	for (i = 0; i < test->num_irqs; i++)
> -		devm_free_irq(&pdev->dev, pdev->irq + i, test);
> +		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
>  	pci_disable_msi(pdev);
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);
> -- 
> 2.7.4
> 
> 
