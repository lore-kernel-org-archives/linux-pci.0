Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34950 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbbGUVRi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2015 17:17:38 -0400
Received: by iecri3 with SMTP id ri3so57745384iec.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2015 14:17:37 -0700 (PDT)
Date: Tue, 21 Jul 2015 16:17:31 -0500
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
Subject: Re: [PATCH v4 07/19] PCI/MSI: Let pci_msi_get_domain use struct
 device's msi_domain
Message-ID: <20150721211731.GA3691@google.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
 <1436962613-17359-8-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436962613-17359-8-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

On Wed, Jul 15, 2015 at 01:16:41PM +0100, Marc Zyngier wrote:
> Now that we can easily find which MSI domain a PCI device is
> using, use dev_get_msi_domain as a way to retrieve the information.
> 
> The original code is still used as a fallback.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pci/msi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index ef4ec6e..c77fdaf 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -41,7 +41,8 @@ static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
>  {
>  	struct irq_domain *domain = NULL;
>  
> -	if (dev->bus->msi)
> +	domain = dev_get_msi_domain(&dev->dev);
> +	if (!domain && dev->bus->msi)
>  		domain = dev->bus->msi->domain;
>  	if (!domain)
>  		domain = arch_get_pci_msi_domain(dev);

I think this would be slightly easier to read as:

    struct irq_domain *domain;

    domain = dev_get_msi_domain(&dev->dev);
    if (domain)
	return domain;

    if (dev->bus->msi && (domain = dev->bus->msi->domain))
	return domain;

    return arch_get_pci_msi_domain(dev);

I'm not a huge fan of assignments inside "if" conditions, and checkpatch
might even complain about it, but it exposes the fallback order pretty well
here.  I guess we could also just repeat the dev->bus->msi->domain
expression:

    if (dev->bus->msi && dev->bus->msi->domain)
	return dev->bus->msi->domain;

We can at least get rid of the superfluous initialization of domain to
NULL.

Bjorn
