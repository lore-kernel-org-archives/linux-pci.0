Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Jisheng Zhang'" <jszhang@marvell.com>, <bhelgaas@google.com>
Cc: <Joao.Pinto@synopsys.com>, <svarbanov@mm-sol.com>,
        <keith.busch@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20170420102718.3778-1-jszhang@marvell.com>
In-Reply-To: <20170420102718.3778-1-jszhang@marvell.com>
Subject: Re: [PATCH] PCI: dwc/host: Mark PCIe/PCI (MSI) cascade ISR as IRQF_NO_THREAD
Date: Thu, 20 Apr 2017 11:07:11 -0400
Message-ID: <000201d2b9e7$ca09a7a0$5e1cf6e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, April 20, 2017 6:27 AM, Jisheng Zhang wrote:
> 
> Similar as commit 8ff0ef996ca0 ("PCI: host: Mark PCIe/PCI (MSI) IRQ
> cascade handlers as IRQF_NO_THREAD"), we should mark PCIe/PCI (MSI)
> IRQ cascade handlers IRQF_NO_THREAD explicitly. I just found this
> issue in pcie-designware-plat driver, then searched the code, I think
> we should fix pcie-qcom and vmd as well.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

For pcie-designware-plat.c,

Acked-by: Jingoo Han <jingoohan1@gmail.com>
Thank you.

Best regards,
Jingoo Han

> ---
>  drivers/pci/dwc/pcie-designware-plat.c | 3 ++-
>  drivers/pci/dwc/pcie-qcom.c            | 3 ++-
>  drivers/pci/host/vmd.c                 | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-plat.c
> b/drivers/pci/dwc/pcie-designware-plat.c
> index f20d494922ab..0db1dafc82bb 100644
> --- a/drivers/pci/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/dwc/pcie-designware-plat.c
> @@ -67,7 +67,8 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
> 
>  		ret = devm_request_irq(dev, pp->msi_irq,
>  					dw_plat_pcie_msi_irq_handler,
> -					IRQF_SHARED, "dw-plat-pcie-msi",
pp);
> +					IRQF_SHARED | IRQF_NO_THREAD,
> +					"dw-plat-pcie-msi", pp);
>  		if (ret) {
>  			dev_err(dev, "failed to request MSI IRQ\n");
>  			return ret;
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 67eb7f5926dd..a5570c58081e 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -727,7 +727,8 @@ static int qcom_pcie_probe(struct platform_device
> *pdev)
> 
>  		ret = devm_request_irq(dev, pp->msi_irq,
>  				       qcom_pcie_msi_irq_handler,
> -				       IRQF_SHARED, "qcom-pcie-msi", pp);
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       "qcom-pcie-msi", pp);
>  		if (ret) {
>  			dev_err(dev, "cannot request msi irq\n");
>  			return ret;
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index e27ad2a3bd33..784f63beb487 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -704,7 +704,8 @@ static int vmd_probe(struct pci_dev *dev, const struct
> pci_device_id *id)
> 
>  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
>  		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
> -				       vmd_irq, 0, "vmd", &vmd->irqs[i]);
> +				       vmd_irq, IRQF_NO_THREAD,
> +				       "vmd", &vmd->irqs[i]);
>  		if (err)
>  			return err;
>  	}
> --
> 2.11.0
