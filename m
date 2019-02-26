Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0CCC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 09:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21B82173C
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 09:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="eogeaRNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfBZJFm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:05:42 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:32768 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfBZJFm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 04:05:42 -0500
Received: from [192.168.28.130] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id F0CEB4F881;
        Tue, 26 Feb 2019 11:05:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1551171938; bh=OSMmovyoJWdCGJIZmZ8sYXbXDxhJRTgBfWiFMyMSFRU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eogeaRNoQBe4M85KREKRYLxGmYZFVbbDYe2MreZsJ4Ov2nxx20eej6pLLGinn5U8z
         RMpQkQ+uYIoXcb00jwx67dRXmX6S+4ms3cCMAEq3svA7FX6dhr/zht4A3gOmSjBuL8
         HBKvic+WvRWOL/xxphfEzTn9fztGYMEVlIdSlr5x2mU1N+Gejd3ZIH+E0T9r9Ab54o
         bkAs4IgTDlus6pTfJz4ZdrbGHyxsoMC4VsY+enRyC3RtcZM0VKjIZDNziirhkuDjSH
         TVW3AREeJ/cuVOiARULWrHERDuR6cBKXM3QoE5y+lB0EV4ymfSsQo5b7tVUp8DktnE
         NWAe+WdGTECrA==
Subject: Re: [PATCH v2 4/7] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
 <20190219060407.15263-5-bjorn.andersson@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <fcf8bd84-649f-b5ff-cb5e-b7c9d058f02c@mm-sol.com>
Date:   Tue, 26 Feb 2019 11:05:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219060407.15263-5-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the patch!

On 2/19/19 8:04 AM, Bjorn Andersson wrote:
> Before introducing the QCS404 platform, which uses the same PCIe
> controller as IPQ4019, migrate this to use the bulk clock API, in order
> to make the error paths slighly cleaner.
> 
> Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++-------------------
>  1 file changed, 13 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index d185ea5fe996..b4d8bcf6eb77 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -113,9 +113,8 @@ struct qcom_pcie_resources_2_3_2 {
>  };
>  
>  struct qcom_pcie_resources_2_4_0 {
> -	struct clk *aux_clk;
> -	struct clk *master_clk;
> -	struct clk *slave_clk;
> +	struct clk_bulk_data clks[3];

Could you make 3 as a define?

Otherwise:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
