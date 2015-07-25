Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35408 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbbGYIZK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jul 2015 04:25:10 -0400
Received: by pabkd10 with SMTP id kd10so25564481pab.2
        for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2015 01:25:09 -0700 (PDT)
Message-ID: <55B347DC.2090104@linaro.org>
Date: Sat, 25 Jul 2015 16:25:00 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v5 07/19] PCI/MSI: Let pci_msi_get_domain use struct device's
 msi_domain
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com> <1437643598-19795-8-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1437643598-19795-8-git-send-email-marc.zyngier@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/23/2015 05:26 PM, Marc Zyngier wrote:
> Now that we can easily find which MSI domain a PCI device is
> using, use dev_get_msi_domain as a way to retrieve the information.
>
> The original code is still used as a fallback.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/pci/msi.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index ef4ec6e..da3c607 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -39,14 +39,16 @@ struct irq_domain * __weak arch_get_pci_msi_domain(struct pci_dev *dev)
>
>   static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
>   {
> -	struct irq_domain *domain = NULL;
> +	struct irq_domain *domain;
> +
> +	domain = dev_get_msi_domain(&dev->dev);
> +	if (domain)
> +		return domain;
>
> -	if (dev->bus->msi)
> -		domain = dev->bus->msi->domain;
> -	if (!domain)
> -		domain = arch_get_pci_msi_domain(dev);
> +	if (dev->bus->msi && (domain = dev->bus->msi->domain))
> +		return domain;
>
> -	return domain;
> +	return arch_get_pci_msi_domain(dev);
>   }
>
>   static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
