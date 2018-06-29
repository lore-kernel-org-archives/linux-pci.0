Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: qcom: Fix error handling in pm_runtime support
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180525190934.1042-1-bjorn.andersson@linaro.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <5b8b3929-c0dc-527c-b7d4-744e28808dbb@mm-sol.com>
Date: Fri, 29 Jun 2018 14:22:06 +0300
MIME-Version: 1.0
In-Reply-To: <20180525190934.1042-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 05/25/2018 10:09 PM, Bjorn Andersson wrote:
> The driver does not cope with the fact that probe can fail in a number
> of cases after enabling pm_runtime on the device, this results in
> warnings about "Unbalanced pm_runtime_enable". Further more if probe
> fails after invoking host_init the power-domain will be left referenced.
> 
> As it's not possible for the error handling in qcom_pcie_host_init() to
> handle errors happening after returning from that function the
> pm_runtime_get_sync() is moved to probe() as well.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Please add:

Fixes: 854b69efbdd2903991506ac5d5624d2cfb5b4e2f PCI: qcom: add runtime
pm support to pcie_port

> ---
> 
> I'm sorry for not spotting this last week when we discussed the previous patch.
> 
>  drivers/pci/dwc/pcie-qcom.c | 65 ++++++++++++++++++++++++++-----------

the path has been changed to drivers/pci/controller/dwc/pcie-qcom.c

>  1 file changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 3f35098b71b1..f2453196278f 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -1088,8 +1088,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  	int ret;
>  
> -	pm_runtime_get_sync(pci->dev);
> -
>  	qcom_ep_reset_assert(pcie);
>  
>  	ret = pcie->ops->init(pcie);
> @@ -1126,7 +1124,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	phy_power_off(pcie->phy);
>  err_deinit:
>  	pcie->ops->deinit(pcie);
> -	pm_runtime_put_sync(pci->dev);
>  
>  	return ret;
>  }
> @@ -1207,7 +1204,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	struct qcom_pcie *pcie;
>  	int ret;
>  
> -
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
>  		return -ENOMEM;
> @@ -1217,6 +1213,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);

pm_runtime_get_sync could fail, please check for errors.

With those changes addressed:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
