Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933693AbcJZT7a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 15:59:30 -0400
Date: Wed, 26 Oct 2016 14:50:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: fix NULL pointer dereference in
 get_resources()
Message-ID: <20161026195059.GD17507@bhelgaas-glaptop.roam.corp.google.com>
References: <1477402971-22146-1-git-send-email-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477402971-22146-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 25, 2016 at 02:42:51PM +0100, Srinivas Kandagatla wrote:
> get_resources() will dereference dev as NULL pointer when called from probe(),
> as pp.dev is only assigned after get_resources() is called.
> 
> Fix this by moving dev pointer assignment before get_resources() call.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Fixes: e6a087eeaf91 ("PCI: qcom: Remove redundant struct qcom_pcie.dev")

Applied to for-linus for v4.9, thanks, Srinivas.  Sorry for the breakage.

> ---
>  drivers/pci/host/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
> index ef0a84c..3593640 100644
> --- a/drivers/pci/host/pcie-qcom.c
> +++ b/drivers/pci/host/pcie-qcom.c
> @@ -533,11 +533,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->phy))
>  		return PTR_ERR(pcie->phy);
>  
> +	pp->dev = dev;
>  	ret = pcie->ops->get_resources(pcie);
>  	if (ret)
>  		return ret;
>  
> -	pp->dev = dev;
>  	pp->root_bus_nr = -1;
>  	pp->ops = &qcom_pcie_dw_ops;
>  
> -- 
> 2.10.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
