Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdFAVLf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jun 2017 17:11:35 -0400
Date: Thu, 1 Jun 2017 16:11:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] PCI: qcom: fix spelling mistake: "asser" -> "assert"
Message-ID: <20170601211133.GA31086@bhelgaas-glaptop.roam.corp.google.com>
References: <20170531053414.17673-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531053414.17673-1-colin.king@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 31, 2017 at 06:34:14AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to pci/host-qcom for v4.13, thanks!

> ---
>  drivers/pci/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 289cda1b4897..fbc79a5274c6 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -695,7 +695,7 @@ static int qcom_pcie_init_v3(struct qcom_pcie *pcie)
>  
>  	ret = reset_control_assert(res->axi_s_reset);
>  	if (ret) {
> -		dev_err(dev, "cannot asser axi slave reset\n");
> +		dev_err(dev, "cannot assert axi slave reset\n");
>  		return ret;
>  	}
>  
> -- 
> 2.11.0
> 
