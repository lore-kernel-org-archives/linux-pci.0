Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35541 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbdGQWav (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 18:30:51 -0400
Received: by mail-pg0-f46.google.com with SMTP id v190so1705165pgv.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2017 15:30:51 -0700 (PDT)
Date: Mon, 17 Jul 2017 15:30:47 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/7] phy: qcom-qmp: Fix phy pipe clock name
Message-ID: <20170717223047.GA20973@minitux>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
 <1500293043-1887-4-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500293043-1887-4-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon 17 Jul 05:03 PDT 2017, Varadarajan Narayanan wrote:

> Presently, the phy pipe clock's name is assumed to be either
> usb3_phy_pipe_clk_src or pcie_XX_pipe_clk_src (where XX is the
> phy lane's number). However, this will not work if an SoC has
> more than one instance of the phy. Hence, instead of assuming
> the name of the clock, fetch it from the DT.
> 

Adding the support to fetch this from DT looks reasonable, but you
should make sure to fall back to the old logic in case you don't find a
"clock-output-names" property.

[..]
> @@ -1110,6 +1103,8 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  
>  	id = 0;
>  	for_each_available_child_of_node(dev->of_node, child) {
> +		const char *clk_name;
> +
>  		/* Create per-lane phy */
>  		ret = qcom_qmp_phy_create(dev, child, id);
>  		if (ret) {
> @@ -1118,11 +1113,20 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  			return ret;
>  		}
>  
> +		ret = of_property_read_string(child, "clock-output-names",
> +							&clk_name);
> +		if (ret) {

This would be the case for any existing dts files, so you're not allowed
to treat this as an error.

> +			dev_err(dev,
> +				"failed to get clock-output-names for lane%d phy, %d\n",
> +				id, ret);
> +			return ret;
> +		}
> +

Regards,
Bjorn
