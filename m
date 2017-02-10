Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Feb 2017 14:16:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Return error code if memory allocation fails
Message-ID: <20170210201639.GH29169@bhelgaas-glaptop.roam.corp.google.com>
References: <20170127151453.27571-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170127151453.27571-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 27, 2017 at 04:14:53PM +0100, Christophe JAILLET wrote:
> If 'alloc_msi_entry()' fails, a few lines above, we free resources and set
> 'ret = -ENOMEM'.
> 
> However, the function returns 0, inconditionaly.
> Returns the error code instead.
> 
> Fixes: e75eafb9b039 ("genirq/msi: Switch to new irq spreading infrastructure")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to pci/msi for v4.11, thanks!

> ---
>  drivers/pci/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index b6785c8be44d..0f77b38f03dd 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -731,7 +731,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  	ret = 0;
>  out:
>  	kfree(masks);
> -	return 0;
> +	return ret;
>  }
>  
>  static void msix_program_entries(struct pci_dev *dev,
> -- 
> 2.9.3
> 
