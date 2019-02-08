Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE1C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242DC2177B
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDauax/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfBHOLz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:11:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33397 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfBHOLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 09:11:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id f24-v6so3149712ljk.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 06:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n53tPLzEI0RmifJ+cFWa8NK1/+5mVBbBZjdDbpnzm5w=;
        b=IDauax/dQeE6GOhP7olo8NL8/kg6h6C4h2vsn0Gesa/nLTH2YqFblBw+3jbv82elCN
         7mpe3gGRDtS/UV54gjYPlQqsNJEHHrE7/FdQnErB5smTob3XFBt2KwlNojdzhkmMk7p9
         uqzEhfV1wgsViltuQUfRFMUlgewKlYDpZ7KlGUrj7tJZZ6zuv53Ycl85HtZkk0CoeGKB
         O3HEX0CyYJGg6jrsMnUaN1YnDubo8rx7x5y5hajzzpPjKTjlNzpYpQHfa30hrvS5k2G2
         YyvNpPP8IS/7ZynewgOFyy+LlUcbqLb6kBBTWRhbp7Mz9zxpIG2HFCxMmWvHHy/Yl2aS
         vsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n53tPLzEI0RmifJ+cFWa8NK1/+5mVBbBZjdDbpnzm5w=;
        b=umrQtCoTlt1N4V/Ysq+RJzcne82LfuMGuhaDn9XqIirudV1ozfM1ndqyzkmFtaWU//
         g2Vd42kBnAIWqAV3HbhWoaUX+jhwGFL9sO3CYCPBlyxnyGs6qNb4aamjZ9mzAzRManLV
         rg4633XIRNB43TypuL0BMW7ncfHnfEqp1yMnGxeAnTzQDanfvFexCNb953i617A97Rxm
         mV848gOm3ctP6li0GdZDnKp/eUfElcGoUYtda76rr3jYdPbuQdjfoNPrgngv9PwdGDw2
         n6O80kBpKKF6FRb114+vg7xXTa6opYy4IlPiF07iUfWS/PMF7uzdj0F0Oc+0ImGbF+6F
         TVwQ==
X-Gm-Message-State: AHQUAuZzY3TnUCW/iRHDrn/3xYiYv5jyFsE/90Wk5WXMLFqc8pZQMiQ/
        prj5zVmYVD+tlkTSKiEzed7dKQ==
X-Google-Smtp-Source: AHgI3IatIcyDuLTmgcEJM59o/AYr7tQtPhC/FSSi9EiwcJdrxNgkcOE+1bvmeKyeamgflPah0XxS8w==
X-Received: by 2002:a2e:449b:: with SMTP id b27-v6mr13559531ljf.47.1549635113146;
        Fri, 08 Feb 2019 06:11:53 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id m27-v6sm394001ljc.7.2019.02.08.06.11.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 06:11:52 -0800 (PST)
Date:   Fri, 8 Feb 2019 15:11:50 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/7] clk: gcc-qcs404: Add PCIe resets
Message-ID: <20190208141150.GA773@centauri.lan>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
 <20190125234509.26419-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125234509.26419-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 25, 2019 at 03:45:03PM -0800, Bjorn Andersson wrote:
> Enabling PCIe requires several of the PCIe related resets from GCC, so
> add them all.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Stephen, I suggest that we merge this patch through Andy's devicetree branch,
> together with the DT patch in the end of this series.
> 
>  drivers/clk/qcom/gcc-qcs404.c               | 7 +++++++
>  include/dt-bindings/clock/qcom,gcc-qcs404.h | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index 64da032bb9ed..cfb8789ff706 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -2675,6 +2675,13 @@ static const struct qcom_reset_map gcc_qcs404_resets[] = {
>  	[GCC_PCIE_0_PHY_BCR] = { 0x3e004 },
>  	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x3e038 },
>  	[GCC_PCIEPHY_0_PHY_BCR] = { 0x3e03c },
> +	[GCC_PCIE_0_AXI_MASTER_STICKY_ARES] = {0x3e040, 6},
> +	[GCC_PCIE_0_AHB_ARES] = {0x3e040, 5},
> +	[GCC_PCIE_0_AXI_SLAVE_ARES] = {0x3e040, 4},
> +	[GCC_PCIE_0_AXI_MASTER_ARES] = {0x3e040, 3},
> +	[GCC_PCIE_0_CORE_STICKY_ARES] = {0x3e040, 2},
> +	[GCC_PCIE_0_SLEEP_ARES] = {0x3e040, 1},
> +	[GCC_PCIE_0_PIPE_ARES] = {0x3e040, 0},

Hello Bjorn,

please add spaces before and after the braces, to match the
syntax of the existing lines.

With that,
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>


Kind regards,
Niklas

>  	[GCC_EMAC_BCR] = { 0x4e000 },
>  };
>  
> diff --git a/include/dt-bindings/clock/qcom,gcc-qcs404.h b/include/dt-bindings/clock/qcom,gcc-qcs404.h
> index 6ceb55ed72c6..00ab0d77b38a 100644
> --- a/include/dt-bindings/clock/qcom,gcc-qcs404.h
> +++ b/include/dt-bindings/clock/qcom,gcc-qcs404.h
> @@ -161,5 +161,12 @@
>  #define GCC_PCIE_0_LINK_DOWN_BCR			11
>  #define GCC_PCIEPHY_0_PHY_BCR				12
>  #define GCC_EMAC_BCR					13
> +#define GCC_PCIE_0_AXI_MASTER_STICKY_ARES		14
> +#define GCC_PCIE_0_AHB_ARES				15
> +#define GCC_PCIE_0_AXI_SLAVE_ARES			16
> +#define GCC_PCIE_0_AXI_MASTER_ARES			17
> +#define GCC_PCIE_0_CORE_STICKY_ARES			18
> +#define GCC_PCIE_0_SLEEP_ARES				19
> +#define GCC_PCIE_0_PIPE_ARES				20
>  
>  #endif
> -- 
> 2.18.0
> 
