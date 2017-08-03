Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbdHCXFZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 19:05:25 -0400
Date: Thu, 3 Aug 2017 18:05:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/7] dt-bindings: phy: qmp: Add support for QMP phy in
 IPQ8074
Message-ID: <20170803230511.GR20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1501482857-14100-1-git-send-email-varada@codeaurora.org>
 <1501482857-14100-3-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501482857-14100-3-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 31, 2017 at 12:04:12PM +0530, Varadarajan Narayanan wrote:
> IPQ8074 uses QMP phy controller that provides support to PCIe and
> USB. Adding dt binding information for the same.

s/ph/PHY/
s/dt/DT/ (as in previous changelog)

> 
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 5d7a51f..802af1b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -6,6 +6,7 @@ controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
>  
>  Required properties:
>   - compatible: compatible list, contains:
> +	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
>  	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
>  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996.
>  
> @@ -38,6 +39,8 @@ Required properties:
>  		 "phy", "common", "cfg".
>  		For "qcom,msm8996-qmp-usb3-phy" must contain
>  		 "phy", "common".
> +		For "qcom,ipq8074-qmp-pcie-phy" must contain:
> +		 "phy", "common".
>  
>   - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
>   - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
> @@ -63,6 +66,11 @@ Required properties for child node:
>   - clock-output-names: Name of the phy clock that will be the parent for
>  		       the above pipe clock.
>  
> +	For "qcom,ipq8074-qmp-pcie-phy":
> +		- "pcie20_phy0_pipe_clk"	Pipe Clock parent
> +			(or)
> +		  "pcie20_phy1_pipe_clk"
> +
>   - resets: a list of phandles and reset controller specifier pairs,
>  	   one for each entry in reset-names.
>   - reset-names: Must contain following for pcie qmp phys:
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
