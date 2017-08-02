Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbdHBVjv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:39:51 -0400
Date: Wed, 2 Aug 2017 16:39:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: qcom: Don't unroll init if init fails
Message-ID: <20170802213948.GJ20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170716064153.3346-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170716064153.3346-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 15, 2017 at 11:41:53PM -0700, Bjorn Andersson wrote:
> When the init op fails it will restore the state of the resources, so we
> should not disable them one more time when this happens.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Stanimir, any opinion on this and the following patch?

> ---
>  drivers/pci/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
> -- 
> 2.12.0
> 
