Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36610 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbaJ0SG6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Oct 2014 14:06:58 -0400
Message-ID: <544E89BA.9020200@ti.com>
Date: Mon, 27 Oct 2014 14:06:50 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
CC: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	"'Santosh Shilimkar'" <ssantosh@kernel.org>
Subject: Re: [PATCH] PCI: keystone: make local symbol static
References: <000101cfee66$7d1ed040$775c70c0$%han@samsung.com>
In-Reply-To: <000101cfee66$7d1ed040$775c70c0$%han@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/22/2014 10:10 PM, Jingoo Han wrote:
> Make local symbol static, because this is used only in this file.
>
> Signed-off-by: Jingoo Han<jg1.han@samsung.com>
> ---
>   drivers/pci/host/pci-keystone-dw.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> index 34086ce..4a97cd1 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -201,7 +201,7 @@ static int ks_dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
>   	return 0;
>   }
>
> -const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
> +static const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
>   	.map = ks_dw_pcie_msi_map,
>   };
>
Jingoo Han,

Thanks for the patch.

Acked-by: Murali Karicheri <m-karicheri2@ti.com>

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
