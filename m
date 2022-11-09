Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EC9C4332F
	for <linux-pci@archiver.kernel.org>; Wed,  9 Nov 2022 11:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKILKE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 9 Nov 2022 06:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKILKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 06:10:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF813E3E;
        Wed,  9 Nov 2022 03:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA34C619E3;
        Wed,  9 Nov 2022 11:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA594C433D7;
        Wed,  9 Nov 2022 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667992199;
        bh=EtDHHCsyFEuSmKNcSOeD9YQcwnovH8KHJkAPeBVl/jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1S4cfpjNajeP0fvZXBjQSHuxVh2x0Zm4wwdHI+09OuRDbaEro7ob1sfrYvN5qsaM
         DjWOYmXEwDMA33lmLgm1z4JAastyQK0j0M9PxDaTzz27cP13Wr36kdqUdNxcylzABd
         ntD6OQrxJEW01YmbO4gpzsnKJD8Uu9rBUqZgY0Py71NwLICmyp5/UxQ2ki8LBIrZM4
         fSwQxKYJ/YdQ4SuomK1NM3hkvuXGtd6AONXxq67vq3wt9/CWg2QhzNttYDPiZdYgI8
         1Qo68+8hRkddNeIjsrltflK4lqWkW2HT37EuE3ga30IiLLHsMu1t6+ldUGlNg1px33
         UdAvyP/C/xLPg==
Date:   Wed, 9 Nov 2022 16:39:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, andersson@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Fix error message for reset_control_assert()
Message-ID: <Y2uKg2SAO2tvnisV@matsya>
References: <20221109094039.25753-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109094039.25753-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09-11-22, 15:10, Manivannan Sadhasivam wrote:
> Fix the error message to mention "assert" instead of "deassert".

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index f711acacaeaf..cf27345f6575 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1236,7 +1236,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  
>  	ret = reset_control_assert(res->pci_reset);
>  	if (ret < 0) {
> -		dev_err(dev, "cannot deassert pci reset\n");
> +		dev_err(dev, "cannot assert pci reset\n");
>  		goto err_disable_clocks;
>  	}
>  
> -- 
> 2.25.1

-- 
~Vinod
