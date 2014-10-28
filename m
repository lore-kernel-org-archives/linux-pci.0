Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:41967 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbaJ1Qfy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Oct 2014 12:35:54 -0400
Received: by mail-oi0-f51.google.com with SMTP id g201so808194oib.38
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2014 09:35:54 -0700 (PDT)
Message-ID: <544FC60A.4010603@gmail.com>
Date: Tue, 28 Oct 2014 09:36:26 -0700
From: Santosh Shilimkar <santosh.shilimkar@gmail.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org,
	'Murali Karicheri' <m-karicheri2@ti.com>,
	'Santosh Shilimkar' <ssantosh@kernel.org>
Subject: Re: [PATCH] PCI: keystone: make local symbol static
References: <000101cfee66$7d1ed040$775c70c0$%han@samsung.com>
In-Reply-To: <000101cfee66$7d1ed040$775c70c0$%han@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/22/2014 07:10 PM, Jingoo Han wrote:
> Make local symbol static, because this is used only in this file.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
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
>
Looks correct.
FWIW, Acked-by: Santosh Shilimkar<ssantosh@kernel.org>
