Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DFE19E96D;
	Mon, 19 Oct 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402914; cv=none; b=Vmin8iCBFHilTebt3wfWtINC48xOdGdb7V2xPm1NOkGoFhWmzzyb9zTuWKzV77WO34D84uet4lq21dr1jnIrcchbenhX2n6H8NQ5/83HzHiEKlz/0mNF8mTRXqT/SOtoInHB+uNlW+zgCoFoeyW+ST7TUmIGX/olZnCIAlWESCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402914; c=relaxed/simple;
	bh=DwnGDzRo12d7ahCIZcvCfNX5Y4zjkUtfVl2c38Yaumk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NPU/NWczcVyjtqcSrF2SV1dz22WnAdGYhdIYidLboslElslhxzjh0MVn5a8amViak6X9jIAFZjEPkYk0Yv7qsA6tZPh1dJVL0rWjXg6ymEyT0abUIXaqFlpmyLOrEwaH2ONTb2ISmr0khDIFtTVe0IV/lRKrbFV6mk/jKwWlGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxFzyDuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxFzyDuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C340E1F000C4;
	Mon, 19 Oct 2026 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402913;
	bh=qrm5v2rIEEZmWIJHZTb3CXYaO9EEZuUZm+RN8OQl/YY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FxFzyDuVWFPLmI4HOh5T0EZVyCDbfjiiZCWyj7DPxHdnzAnyssxruXA20vzRqzt7d
	 df9gqN+IzTnsD2dSZBmNKWut2VztNEbNcu60RvSXExXDqzy11tE08RL5euoWeK1OHl
	 ZQbSreIfF5P0jUGSsHbP1feovYvIAAwXbO3lGWwkWlCaXpaENYAU1OmqINJJr6iZj/
	 iSp7z71kqlSEQ3bWMliamfIsX/ExVqDI1zHGenMotS7S+U0JEVtS8igtumK1jmdqun
	 Hnzt4KGWZrxWmlr/BTQrP4audQgOIP7Cer2jOERsQPTYmC/KfTqDkPgtrQBFVmybIt
	 nE6w0VjqnmkGQ==
Message-ID: <sashiko-outbox-176915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] arm64: qcom: monaco: Add PCIe Endpoint nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261019-monaco_ep-v2-6-852cb9f5d012@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
 <20261019-monaco_ep-v2-6-852cb9f5d012@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:41:52 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: monaco: disallowed input-enable in pcie ep tlm=
m states
- [Low] arm64: dts: qcom: monaco: board-specific PCIe EP GPIOs and pinctrl =
in SoC dtsi
--

commit 59621afda0bee2426503fd1658910b3d133f8ac2
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: qcom: monaco: Add PCIe Endpoint nodes

This commit adds the PCIe Endpoint device tree nodes and default pin
configuration states for both PCIe controllers on the Qualcomm Monaco
SoC.

> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/q=
com/monaco.dtsi
> index d7d135e87a8c7..12cd7d5f37a32 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi

[ ... ]

> @@ -2405,6 +2406,57 @@ pcieport0: pcie@0 {
>  			};
>  		};
> =20
> +		pcie0_ep: pcie-ep@1c00000 {

[ ... ]

> +			phys =3D <&pcie0_phy>;
> +			phy-names =3D "pciephy";
> +			reset-gpios =3D <&tlmm 2 GPIO_ACTIVE_LOW>;
> +			wake-gpios =3D <&tlmm 0 GPIO_ACTIVE_LOW>;
> +			pinctrl-0 =3D <&pcie0_ep_default_state>;
> +			pinctrl-names =3D "default";
> +			num-lanes =3D <2>;
> +			linux,pci-domain =3D <0>;
> +
> +			status =3D "disabled";
> +		};
> +
>  		pcie0_phy: phy@1c04000 {
>  			compatible =3D "qcom,qcs8300-qmp-gen4x2-pcie-phy";
>  			reg =3D <0x0 0x01c04000 0x0 0x2000>;
> @@ -2596,6 +2648,57 @@ pcieport1: pcie@0 {
>  			};
>  		};
> =20
> +		pcie1_ep: pcie-ep@1c10000 {

[ ... ]

> +			phys =3D <&pcie1_phy>;
> +			phy-names =3D "pciephy";
> +			reset-gpios =3D <&tlmm 23 GPIO_ACTIVE_LOW>;
> +			wake-gpios =3D <&tlmm 21 GPIO_ACTIVE_LOW>;
> +			pinctrl-0 =3D <&pcie1_ep_default_state>;
> +			pinctrl-names =3D "default";
> +			num-lanes =3D <4>;
> +			linux,pci-domain =3D <1>;
> +
> +			status =3D "disabled";
> +		};

[Severity: Low]
Should reset-gpios, wake-gpios, and the pinctrl states be placed in the
board DTS files rather than hardcoded in the SoC-level pcie0_ep and
pcie1_ep nodes in arch/arm64/boot/dts/qcom/monaco.dtsi?

In drivers/pinctrl/qcom/pinctrl-qcs8300.c, only gpio1 (pcie0_clkreq) and
gpio22 (pcie1_clkreq) have dedicated PCIe pinmux functions, whereas
gpio0, gpio2, gpio21, and gpio23 use the generic gpio function (and
gpio21 through gpio23 are shared with qup0_se5). In addition, wake-gpios
is optional in drivers/pci/controller/dwc/pcie-qcom-ep.c via
devm_gpiod_get_optional(dev, "wake", GPIOD_OUT_LOW), and existing Monaco
boards such as monaco-arduino-monza.dts omit wake-gpios.

The Root Complex pcie0 and pcie1 nodes in monaco.dtsi, as well as the
pcie-ep nodes in other Qualcomm SoC DTSI files (such as lemans.dtsi,
sar2130p.dtsi, sm8450.dtsi, qcom-sdx55.dtsi, and qcom-sdx65.dtsi), leave
reset-gpios and wake-gpios to the board DTS files.

> =20
>  		pcie1_phy: phy@1c14000 {
>  			compatible =3D "qcom,qcs8300-qmp-gen4x4-pcie-phy",
>  				     "qcom,sa8775p-qmp-gen4x4-pcie-phy";
> @@ -6225,6 +6328,50 @@ tlmm: pinctrl@f100000 {
>  			#interrupt-cells =3D <2>;
>  			wakeup-parent =3D <&pdc>;
> =20
> +			pcie0_ep_default_state: pcie0-ep-default-state {
> +				wake-pins {
> +					pins =3D "gpio0";
> +					function =3D "gpio";
> +					drive-strength =3D <2>;
> +				};
> +
> +				clkreq-pins {
> +					pins =3D "gpio1";
> +					function =3D "pcie0_clkreq";
> +					drive-strength =3D <2>;
> +					bias-pull-up;
> +				};
> +
> +				perst-pins {
> +					pins =3D "gpio2";
> +					function =3D "gpio";
> +					input-enable;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			pcie1_ep_default_state: pcie1-ep-default-state {
> +				wake-pins {
> +					pins =3D "gpio21";
> +					function =3D "gpio";
> +					drive-strength =3D <2>;
> +				};
> +
> +				clkreq-pins {
> +					pins =3D "gpio22";
> +					function =3D "pcie1_clkreq";
> +					drive-strength =3D <2>;
> +					bias-pull-up;
> +				};
> +
> +				perst-pins {
> +					pins =3D "gpio23";
> +					function =3D "gpio";
> +					input-enable;
> +					bias-pull-up;
> +				};
> +			};
> +
>  			cam0_default: cam0-default-state {
>  				pins =3D "gpio67";
>  				function =3D "cam_mclk";

[Severity: Medium]
Will using input-enable in the perst-pins subnodes of
pcie0_ep_default_state and pcie1_ep_default_state cause a dtbs_check
validation regression?

The tlmm node uses compatible "qcom,qcs8300-tlmm". In
Documentation/devicetree/bindings/pinctrl/qcom,qcs8300-tlmm.yaml,
qcom-qcs8300-tlmm-state validates all -state and -pins subnodes against
qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state with
unevaluatedProperties: false:

  qcom-qcs8300-tlmm-state:
    type: object
    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
    unevaluatedProperties: false

In Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml,
qcom-tlmm-state explicitly disallows input-enable:

      bias-pull-down: true
      bias-pull-up: true
      bias-disable: true
      input-enable: false
      output-disable: true
      output-enable: true

Qualcomm TLMM hardware does not have an input-buffer enable bit and uses
output-disable instead (or omits the property). Also, if any pin states
remain under tlmm in monaco.dtsi, should pcie0-ep-default-state and
pcie1-ep-default-state be placed in alphabetical order rather than before
cam0-default-state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-monaco_ep-=
v2-0-852cb9f5d012@oss.qualcomm.com?part=3D6
