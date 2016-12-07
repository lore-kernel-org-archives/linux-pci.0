Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932295AbcLGSR4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 13:17:56 -0500
Date: Wed, 7 Dec 2016 12:17:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] drivers/pci/host/vmd: Fix suspend handlers unused warning
Message-ID: <20161207181752.GB22129@bhelgaas-glaptop.roam.corp.google.com>
References: <20161126182957.6144-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161126182957.6144-1-bp@alien8.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 26, 2016 at 07:29:57PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Fix:
> 
>   drivers/pci/host/vmd.c:731:12: warning: ‘vmd_suspend’ defined but not used [-Wunused-function]
>    static int vmd_suspend(struct device *dev)
>               ^
>   drivers/pci/host/vmd.c:739:12: warning: ‘vmd_resume’ defined but not used [-Wunused-function]
>    static int vmd_resume(struct device *dev)
>               ^
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Applied with Keith's reviewed-by to pci/host-vmd for v4.10, thanks!

> ---
>  drivers/pci/host/vmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index 37e29b580be3..0e7f8f319fe3 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -727,7 +727,7 @@ static void vmd_remove(struct pci_dev *dev)
>  	irq_domain_remove(vmd->irq_domain);
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int vmd_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -- 
> 2.10.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
