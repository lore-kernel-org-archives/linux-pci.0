Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1820C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 15:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C2D20863
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="W46trkMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfBHPCl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:02:41 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:50130 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfBHPCl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 10:02:41 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 10:02:39 EST
Received: from [192.168.27.209] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 8216ECE08;
        Fri,  8 Feb 2019 16:54:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1549637686; bh=dcPQbvq/7hiwMZM4pUapZaSIoVhm0pG5ACXN9uM1WFc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W46trkMD4q7fSURU38goShYmZnB7vFFbku3GDWzpNvgZE2kiOCeRofKA+GpuKHLSM
         CG4ItJflYegZgDB0skCvmGBwBEJEnKUj+Ud6A32qVM9v/gHIegoyZy8k8SmxSnT3cv
         +nlV5RA0a8okqmTmjqoE7Uo+PlYhcKmbM9fM3hO75S9i3VLcldfmT83mSSgIjIFiSI
         igA9EzDw37OovCgcCwHbgqx8iVda4+3Om7FttIeRSbgxvKnQjuFC5xSfOeZuyPCaCn
         fS0cPLFt5bYojErEcLTmSiNl9CZeHW4G6gwDdnATVCXVf/yUbIr4xOpEKou1iVItZs
         IOoki3ZKcAwOA==
Subject: Re: [PATCH] PCI: qcom: Don't deassert reset GPIO during probe
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        stable@vger.kernel.org
References: <20190125232616.25714-1-bjorn.andersson@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <d972ef33-5069-e012-abd5-31f2f985af6d@mm-sol.com>
Date:   Fri, 8 Feb 2019 16:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125232616.25714-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the patch!

On 1/26/19 1:26 AM, Bjorn Andersson wrote:
> Acquiring the reset GPIO low means that reset is being deasserted, this
> is followed almost immediately with qcom_pcie_host_init() asserting it,
> initializing it and then finally deasserting it again, for the link to
> come up.
> 
> Some PCIe devices requires a minimum time between the initial deassert
> and subsequent reset cycles. In a platform that boots with the reset
> GPIO asserted this requirement is being violated by this deassert/assert
> pulse.
> 
> Acquiring the reset GPIO high will prevent this by matching the state to
> the subsequent asserted state.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index d185ea5fe996..a7f703556790 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1228,7 +1228,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->ops = of_device_get_match_data(dev);
>  
> -	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
> +	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
>  		ret = PTR_ERR(pcie->reset);
>  		goto err_pm_runtime_put;
> 

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
