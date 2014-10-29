Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:59866 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934312AbaJ2QIX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Oct 2014 12:08:23 -0400
Received: by mail-ie0-f171.google.com with SMTP id x19so3294377ier.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2014 09:08:22 -0700 (PDT)
Date: Wed, 29 Oct 2014 10:08:19 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org,
	'Murali Karicheri' <m-karicheri2@ti.com>,
	'Santosh Shilimkar' <ssantosh@kernel.org>
Subject: Re: [PATCH] PCI: keystone: make local symbol static
Message-ID: <20141029160819.GA12090@google.com>
References: <000101cfee66$7d1ed040$775c70c0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000101cfee66$7d1ed040$775c70c0$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 23, 2014 at 11:10:16AM +0900, Jingoo Han wrote:
> Make local symbol static, because this is used only in this file.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/host-keystone for v3.19 with acks from Murali and Santosh,
thanks!

> ---
>  drivers/pci/host/pci-keystone-dw.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> index 34086ce..4a97cd1 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -201,7 +201,7 @@ static int ks_dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
>  	return 0;
>  }
>  
> -const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
> +static const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
>  	.map = ks_dw_pcie_msi_map,
>  };
>  
> -- 
> 1.7.9.5
> 
> 
