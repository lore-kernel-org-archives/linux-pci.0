Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1500636977-11934-3-git-send-email-varada@codeaurora.org>
References: <1500636977-11934-1-git-send-email-varada@codeaurora.org> <1500636977-11934-3-git-send-email-varada@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Wed, 26 Jul 2017 20:33:46 +0530
Message-ID: <CAFp+6iG+PL_dY7JiiSAuLaFBzaykqO9XCP9f_Y4Odqdh4sf9gw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, svarbanov@mm-sol.com,
        kishon <kishon@ti.com>, Stephen Boyd <sboyd@codeaurora.org>,
        fengguang.wu@intel.com, Wei Yongjun <weiyongjun1@huawei.com>,
        linux-pci@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 21, 2017 at 5:06 PM, Varadarajan Narayanan
<varada@codeaurora.org> wrote:
> IPQ8074 uses QMP phy controller that provides support to PCIe and
> USB. Adding dt binding information for the same.
>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index 5d7a51f..82fe0c4 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -6,6 +6,7 @@ controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
>
>  Required properties:
>   - compatible: compatible list, contains:
> +              "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
>                "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
>                "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996.
>
> @@ -38,6 +39,8 @@ Required properties:
>                  "phy", "common", "cfg".
>                 For "qcom,msm8996-qmp-usb3-phy" must contain
>                  "phy", "common".
> +               For "qcom,ipq8074-qmp-pcie-phy" must contain:
> +                "phy", "phy_phy".

Actually the "common" reset for msm8996-qmp-usb3-phy is
usb3phy_phy_reset in the datasheets, which functions in a
similar fashion as this "phy_phy" reset. So may be we don't
need another name?

regards
Vivek

>
>   - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
>   - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
> @@ -63,6 +66,11 @@ Required properties for child node:
>   - clock-output-names: Name of the phy clock that will be the parent for
>                        the above pipe clock.
>
> +       For "qcom,ipq8074-qmp-pcie-phy":
> +               - "pcie20_phy0_pipe_clk"        Pipe Clock parent
> +                       (or)
> +                 "pcie20_phy1_pipe_clk"
> +
>   - resets: a list of phandles and reset controller specifier pairs,
>            one for each entry in reset-names.
>   - reset-names: Must contain following for pcie qmp phys:
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
