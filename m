Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED79EC282CA
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 15:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DAA222CD
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 15:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfBMPX6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:23:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56056 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfBMPX5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 10:23:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1756580D;
        Wed, 13 Feb 2019 07:23:57 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D60F3F575;
        Wed, 13 Feb 2019 07:23:55 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:23:52 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Don't deassert reset GPIO during probe
Message-ID: <20190213152352.GB417@e107981-ln.cambridge.arm.com>
References: <20190125232616.25714-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125232616.25714-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 25, 2019 at 03:26:16PM -0800, Bjorn Andersson wrote:
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

Missing Fixes: tag, please provide me one so that I can proceed.

Lorenzo

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
> -- 
> 2.18.0
> 
