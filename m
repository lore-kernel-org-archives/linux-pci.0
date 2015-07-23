Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37199 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbbGWNO0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 09:14:26 -0400
Received: by igbpg9 with SMTP id pg9so158222731igb.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 06:14:26 -0700 (PDT)
Date: Thu, 23 Jul 2015 08:14:21 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v5 07/19] PCI/MSI: Let pci_msi_get_domain use struct
 device's msi_domain
Message-ID: <20150723131421.GU21967@google.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-8-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437643598-19795-8-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 10:26:26AM +0100, Marc Zyngier wrote:
> Now that we can easily find which MSI domain a PCI device is
> using, use dev_get_msi_domain as a way to retrieve the information.
> 
> The original code is still used as a fallback.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index ef4ec6e..da3c607 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -39,14 +39,16 @@ struct irq_domain * __weak arch_get_pci_msi_domain(struct pci_dev *dev)
>  
>  static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
>  {
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
>  }
>  
>  static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> -- 
> 2.1.4
> 
