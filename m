Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbdHCXEq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 19:04:46 -0400
Date: Thu, 3 Aug 2017 18:04:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: phy: qmp: Add output-clock-names
Message-ID: <20170803230444.GQ20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1501482857-14100-1-git-send-email-varada@codeaurora.org>
 <1501482857-14100-2-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501482857-14100-2-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 31, 2017 at 12:04:11PM +0530, Varadarajan Narayanan wrote:
> The phy outputs a clock that will act as the parent for
> the phy's pipe clock. Add the name of this clock to the

s/phy/PHY/

> lane's DT node.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index e11c563..5d7a51f 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -60,6 +60,8 @@ Required properties for child node:
>  	   one for each entry in clock-names.
>   - clock-names: Must contain following for pcie and usb qmp phys:
>  		 "pipe<lane-number>" for pipe clock specific to each lane.
> + - clock-output-names: Name of the phy clock that will be the parent for
> +		       the above pipe clock.

s/phy/PHY/ (this file is a hodge-podge so I guess this isn't making it much
worse)

>  
>   - resets: a list of phandles and reset controller specifier pairs,
>  	   one for each entry in reset-names.
> @@ -96,6 +98,7 @@ Example:
>  
>  			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
>  			clock-names = "pipe0";
> +			clock-output-names = "pcie_0_pipe_clk_src";
>  			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
>  			reset-names = "lane0";
>  		};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
