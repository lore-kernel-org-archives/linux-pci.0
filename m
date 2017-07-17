Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33539 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdGQUQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 16:16:34 -0400
Date: Mon, 17 Jul 2017 15:16:31 -0500
From: Rob Herring <robh@kernel.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, mark.rutland@arm.com, svarbanov@mm-sol.com,
        kishon@ti.com, sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: phy: qmp: Add support for QMP phy in
 IPQ8074
Message-ID: <20170717201631.abhtg7rcn4bz4lux@rob-hp-laptop>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
 <1500293043-1887-3-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500293043-1887-3-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 17, 2017 at 05:33:58PM +0530, Varadarajan Narayanan wrote:
> IPQ8074 uses QMP phy controller that provides support to PCIe and
> USB. Adding dt binding information for the same.
> 
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 5d7a51f..80d766b 100644
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
> @@ -107,3 +108,30 @@ Example:
>  		...
>  		...
>  	};
> +
> +	phy@86000 {

Only a new compatible doesn't warrant another example.

Rob
