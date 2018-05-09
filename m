Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:46530 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935362AbeEIPqO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 May 2018 11:46:14 -0400
Subject: Re: [PATCH 8/9] PCI: qcom: Drop unnecessary root_bus_nr setting
To: Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
 <1525844386-5433-8-git-send-email-shawn.guo@linaro.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <5f93be0d-7ad2-70ca-a2b5-4fa5b9b482a3@mm-sol.com>
Date: Wed, 9 May 2018 18:46:06 +0300
MIME-Version: 1.0
In-Reply-To: <1525844386-5433-8-git-send-email-shawn.guo@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

Thanks for the patch!

On 05/09/2018 08:39 AM, Shawn Guo wrote:
> The root_bus_nr initialization has already been done in function
> dw_pcie_host_init().  The -1 assignment in platform driver before
> calling into dw_pcie_host_init() is not really needed.  Drop it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> ---
>  drivers/pci/dwc/pcie-qcom.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 5897af7d3355..a32aa024e907 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -1247,7 +1247,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	pp->root_bus_nr = -1;
>  	pp->ops = &qcom_pcie_dw_ops;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> 

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
