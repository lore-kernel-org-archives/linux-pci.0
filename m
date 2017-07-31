Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41530 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdGaFuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2017 01:50:12 -0400
Subject: Re: [PATCH v5 2/7] dt-bindings: phy: qmp: Add support for QMP phy in
 IPQ8074
To: Varadarajan Narayanan <varada@codeaurora.org>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, svarbanov@mm-sol.com,
        kishon@ti.com, sboyd@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1501479594-18285-1-git-send-email-varada@codeaurora.org>
 <1501479594-18285-3-git-send-email-varada@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <55f7f87f-0302-c4a5-af9b-280c6c473943@codeaurora.org>
Date: Mon, 31 Jul 2017 11:20:05 +0530
MIME-Version: 1.0
In-Reply-To: <1501479594-18285-3-git-send-email-varada@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 07/31/2017 11:09 AM, Varadarajan Narayanan wrote:
> IPQ8074 uses QMP phy controller that provides support to PCIe and
> USB. Adding dt binding information for the same.
>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---

Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

>   Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 5d7a51f..802af1b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -6,6 +6,7 @@ controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
>   
>   Required properties:
>    - compatible: compatible list, contains:
> +	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
>   	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
>   	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996.
>   
> @@ -38,6 +39,8 @@ Required properties:
>   		 "phy", "common", "cfg".
>   		For "qcom,msm8996-qmp-usb3-phy" must contain
>   		 "phy", "common".
> +		For "qcom,ipq8074-qmp-pcie-phy" must contain:
> +		 "phy", "common".
>   
>    - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
>    - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
> @@ -63,6 +66,11 @@ Required properties for child node:
>    - clock-output-names: Name of the phy clock that will be the parent for
>   		       the above pipe clock.
>   
> +	For "qcom,ipq8074-qmp-pcie-phy":
> +		- "pcie20_phy0_pipe_clk"	Pipe Clock parent
> +			(or)
> +		  "pcie20_phy1_pipe_clk"
> +
>    - resets: a list of phandles and reset controller specifier pairs,
>   	   one for each entry in reset-names.
>    - reset-names: Must contain following for pcie qmp phys:

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
