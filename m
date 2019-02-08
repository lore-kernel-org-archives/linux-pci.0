Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40301C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E81020844
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9/i6R7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfBHORo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:17:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35509 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfBHORo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 09:17:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id j13-v6so3147914ljc.2
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 06:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xRNqt93lQb9YsKog3bRyznBNI+ra6tWFw2FWHpo/nDE=;
        b=g9/i6R7plbj+j/MDd5NKsur4NAB8BMzjBvESnaew/gXZdUCt7FNvdeNXP/YtVZibrW
         2++BafDn3pGOFMkxpHZFZkQ1yMIQDBSAI7ba07IJmEt9gYMcS7BvzKEx5L51Qanzx8Cr
         uHcr61mFO3CFqLfZuYtUcf+S6vkHsde965HANHYI2fBz/OmbXvJjiDMtXwl7JUH3OWb0
         fuHqCQIrTs1c0jObwr20o+jn5kCHd6UA9nKPhKMfj0Br0eOpgE27C4wc4sfWKLh5+DRm
         LDhCN4z2L+Tl1XUhWKc7eh/tJAHEC6Qwiw8gGdZxBDE0cCSBByABrbv7cG/kzEGjuQEt
         QWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xRNqt93lQb9YsKog3bRyznBNI+ra6tWFw2FWHpo/nDE=;
        b=USCCwQXQr6aY0mgeTaWU49+2FZTL6Qpo1BtY7Vwk0U/2K1q2oJH1YoWSzVMbiKSuDd
         3X7Zkwc4OI3TOPMMLQ52OfO5i8j4QXAtr0NzG0U3DntiVqNgQ+XKKL21PoBvbn3VaxfT
         m/1cqoczPkO59/jWAzfe+3aucOaTM63dblzJpmMHGxkk1qLb34yyq2nvWTDxGwpMk9FC
         VsvM2mdPIjQEkTTEJqYlWQt4fYqn7Gu5VGyzg7rtkdaZDSOzxiB0333IUST6B4OQ0v/y
         CJDRuRC8qCS855viLo7TedCCugl5j6ttYU7ReHnIiUgCuzyXcgZreT8ed20W8QgyHQ8U
         krOw==
X-Gm-Message-State: AHQUAub6MXwuwfpSAjjXqZZAfZ87xXUsK+3HfmRpQm2mAXFmoHPx0O6j
        lljDp3eZ3CCuj82SSWCMkwXHjA==
X-Google-Smtp-Source: AHgI3Iam+oehJuzhM8sMvAt49GkcBhAqvbcmSybCeg4EgI271DoifWPWysp37Q9T9LL6YUqykIqOPQ==
X-Received: by 2002:a2e:9c87:: with SMTP id x7-v6mr13253185lji.196.1549635461358;
        Fri, 08 Feb 2019 06:17:41 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id d24-v6sm389587ljg.2.2019.02.08.06.17.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 06:17:40 -0800 (PST)
Date:   Fri, 8 Feb 2019 15:17:38 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/7] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
Message-ID: <20190208141738.GC773@centauri.lan>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
 <20190125234509.26419-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125234509.26419-5-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 25, 2019 at 03:45:06PM -0800, Bjorn Andersson wrote:
> Before introducing the QCS404 platform, which uses the same PCIe
> controller as IPQ4019, migrate this to use the bulk clock API, in order
> to make the error paths slighly cleaner.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++-------------------
>  1 file changed, 13 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a7f703556790..9d366fad2b7f 100644
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
> +	int num_clks;
>  	struct reset_control *axi_m_reset;
>  	struct reset_control *axi_s_reset;
>  	struct reset_control *pipe_reset;
> @@ -638,18 +637,17 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	int ret;
>  
> -	res->aux_clk = devm_clk_get(dev, "aux");
> -	if (IS_ERR(res->aux_clk))
> -		return PTR_ERR(res->aux_clk);
> +	res->clks[0].id = "aux";
> +	res->clks[1].id = "master_bus";
> +	res->clks[2].id = "slave_bus";
>  
> -	res->master_clk = devm_clk_get(dev, "master_bus");
> -	if (IS_ERR(res->master_clk))
> -		return PTR_ERR(res->master_clk);
> +	res->num_clks = 3;
>  
> -	res->slave_clk = devm_clk_get(dev, "slave_bus");
> -	if (IS_ERR(res->slave_clk))
> -		return PTR_ERR(res->slave_clk);
> +	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
> +	if (ret < 0)
> +		return ret;
>  
>  	res->axi_m_reset = devm_reset_control_get_exclusive(dev, "axi_m");
>  	if (IS_ERR(res->axi_m_reset))
> @@ -719,9 +717,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
>  	reset_control_assert(res->axi_m_sticky_reset);
>  	reset_control_assert(res->pwr_reset);
>  	reset_control_assert(res->ahb_reset);
> -	clk_disable_unprepare(res->aux_clk);
> -	clk_disable_unprepare(res->master_clk);
> -	clk_disable_unprepare(res->slave_clk);
> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>  }
>  
>  static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> @@ -850,23 +846,9 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  
>  	usleep_range(10000, 12000);
>  
> -	ret = clk_prepare_enable(res->aux_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable iface clock\n");
> +	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> +	if (ret)
>  		goto err_clk_aux;
> -	}
> -
> -	ret = clk_prepare_enable(res->master_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable core clock\n");
> -		goto err_clk_axi_m;
> -	}
> -
> -	ret = clk_prepare_enable(res->slave_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable phy clock\n");
> -		goto err_clk_axi_s;
> -	}
>  
>  	/* enable PCIe clocks and resets */
>  	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> @@ -891,10 +873,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  
>  	return 0;
>  
> -err_clk_axi_s:
> -	clk_disable_unprepare(res->master_clk);
> -err_clk_axi_m:
> -	clk_disable_unprepare(res->aux_clk);
>  err_clk_aux:
>  	reset_control_assert(res->ahb_reset);
>  err_rst_ahb:
> -- 
> 2.18.0
> 

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
