Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 3 Jan 2018 12:22:37 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        kernel-janitors@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] PCI: qcom: account for const type of
 of_device_id.data
Message-ID: <20180103122237.GD26554@red-moon>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-5-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1514899688-27844-5-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 02, 2018 at 02:28:00PM +0100, Julia Lawall wrote:
> This driver creates various const structures that it stores in the
> data field of an of_device_id array.
> 
> Adding const to the declaration of the location that receives the
> const value from the data field ensures that the compiler will
> continue to check that the value is not modified.  Furthermore, the
> const-discarding cast on the extraction from the data field is no
> longer needed.
> 
> Done using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/pci/dwc/pcie-qcom.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Hi Julia,

I am happy to take this patch through the PCI tree unless you see a
problem with that, please let me know.

Thanks,
Lorenzo

> diff -u -p a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -171,7 +171,7 @@ struct qcom_pcie {
>  	union qcom_pcie_resources res;
>  	struct phy *phy;
>  	struct gpio_desc *reset;
> -	struct qcom_pcie_ops *ops;
> +	const struct qcom_pcie_ops *ops;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1234,7 +1234,7 @@ static int qcom_pcie_probe(struct platfo
>  
>  	pcie->pci = pci;
>  
> -	pcie->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
> +	pcie->ops = of_device_get_match_data(dev);
>  
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
>  	if (IS_ERR(pcie->reset))
> 
