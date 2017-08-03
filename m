Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:53200 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbdHCJYV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 05:24:21 -0400
Subject: Re: [PATCH 2/3] PCI: qcom: Don't unroll init if init fails
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: "open list:PCIE DRIVER FOR QUALCOMM MSM" <linux-pci@vger.kernel.org>,
        "open list:PCIE DRIVER FOR QUALCOMM MSM"
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20170716063947.3272-1-bjorn.andersson@linaro.org>
 <20170716063947.3272-2-bjorn.andersson@linaro.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <f882d2eb-b531-966f-04ce-06b722faee92@mm-sol.com>
Date: Thu, 3 Aug 2017 12:24:19 +0300
MIME-Version: 1.0
In-Reply-To: <20170716063947.3272-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

The patch looks correct.

On 07/16/2017 09:39 AM, Bjorn Andersson wrote:
> When the init op fails it will restore the state of the resources, so we
> should not disable them one more time when this happens.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index d15657dc3990..7b703741a3fd 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -901,7 +901,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  
>  	ret = pcie->ops->init(pcie);
>  	if (ret)
> -		goto err_deinit;
> +		return ret;
>  
>  	ret = phy_power_on(pcie->phy);
>  	if (ret)
> 
