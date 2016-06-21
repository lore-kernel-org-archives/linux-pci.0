Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V7 3/8] PCI/MSI: Setup MSI domain on a per-device basis
 using IORT ACPI table
To: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com,
	tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net,
	bhelgaas@google.com, lorenzo.pieralisi@arm.com,
	robert.richter@caviumnetworks.com, shijie.huang@arm.com,
	Suravee.Suthikulpanit@amd.com
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
 <1466420541-20101-4-git-send-email-tn@semihalf.com>
Cc: al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <9d449ab6-e4b3-1638-558c-59cef4baa108@linaro.org>
Date: Tue, 21 Jun 2016 15:33:32 +0800
MIME-Version: 1.0
In-Reply-To: <1466420541-20101-4-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/6/20 19:02, Tomasz Nowicki wrote:
> It is possible to provide information about which MSI controller to
> use on a per-device basis for DT. This patch supply this with ACPI support.
>
> Currently, IORT is the only one ACPI table which can provide such mapping.
> In order to plug IORT into MSI infrastructure we are adding ACPI
> equivalents for finding PCI device domain and its RID translation
> (pci_msi_domain_get_msi_rid and pci_msi_domain_get_msi_rid calls).
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pci/msi.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index a080f44..1d45e81 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -18,6 +18,7 @@
>  #include <linux/smp.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> +#include <linux/iort.h>
>  #include <linux/slab.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of_irq.h>
> @@ -1364,8 +1365,8 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>
>  	of_node = irq_domain_get_of_node(domain);
> -	if (of_node)
> -		rid = of_msi_map_rid(&pdev->dev, of_node, rid);
> +	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
> +			iort_msi_map_rid(&pdev->dev, rid);
>
>  	return rid;
>  }
> @@ -1381,9 +1382,13 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>   */
>  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
>  {
> +	struct irq_domain *dom;
>  	u32 rid = 0;
>
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> -	return of_msi_map_get_device_domain(&pdev->dev, rid);
> +	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
> +	if (!dom)
> +		dom = iort_get_device_domain(&pdev->dev, rid);
> +	return dom;
>  }
>  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
