Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F292D0606;
	Mon, 27 Jul 2026 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168206; cv=none; b=IWYjNkZzqHxKJxIOqMRMpQxLQ4cwY4DDe911ymOV8wF8olIEp/Kqec5Nsmalpa4U029Liy5+coruD2TYcJUGVm0Q7xr/zrgYaQy30xOW0+zkgAbFifsnGb8jSFVGpJyTt2KNYxru2P6GMWhmFd0F0EX4Oh8AMVzjnvc61NzhK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168206; c=relaxed/simple;
	bh=TZpihiA4JLrEw5hUuLJW4mksOXhWvlP+QegGdBCruNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPo0MpQbADt6FQsJWQM/MbsRwVPljPVNe+gC3Xy1pReHf54yecFA/uaS84UU/no/MTx0QAeQl8e4zEl+lVxivEitCux47WGOZszPnl49fGRkKxPRodunWrY2aac8z6qmaW0eOVEY6eBSuheebCMTD7Gbvfm9aToimuBYEtW7Aac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZujoV6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZujoV6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FE41F000E9;
	Mon, 27 Jul 2026 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785168205;
	bh=bhvDR/SeA5mcDuiWBmYRBCMO25npiqWDiwQJFum98/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZujoV6AtWER5eWVkvoXv3T5XeoCi9Yfms8mdN2OANTZjJMV1PvyEZNvKq8uwg+Kf
	 8ZBQdDLXBB8yzVVgPBx4nw+Y7CBJCqa49yC8j9Pt+2m0EawHHZDpyfm/tRF5tNL/ip
	 U2bOkySsDCEfeKPDp286C+sSOt2q7EVHW2UciVh1t2x52V3x+c8YSY++fuTT2jtM/A
	 u53LSEzo2UTYRcDvik8RLPXJZLJEUdt3NRhWRPKu7Smrk9TUQPJIZAI6ngFxPI6FLt
	 wZ3KwVIwNrRGejcew6PQx8s4DPSwVcFHs7RKvN+OPmJKCfe5uv9VWt0BFbzbofhmTU
	 KGOz4EGz0PXAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT
 UART overlay
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rahul Samana" <rahul.samana@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:03:24 +0000
Message-Id: <20260727160325.16FE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The overlay fails to delete the existing default PCIe child node (=
`usb-controller@0,0`) under the M.2 E-key slot (`&pcie0_m2_e`), causing a d=
evfn collision and erroneous OF node binding.
- [High] The `m2-e-connector` node uses a dummy, uncontrolled regulator for=
 the 3.3V supply rather than the actual GPIO-controlled rail powering the s=
lot.
- [Medium] Missing `/delete-property/ interrupts;` when adding `interrupts-=
extended` to `&uart4`.
--

--- Patch [6]: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT =
UART overlay ---
commit 978523089bf29d9bf8d8d86680d9cc1d3d558116
Author: Rahul Samana <rahul.samana@oss.qualcomm.com>

arm64: dts: qcom: rb3gen2: add Industrial BT UART overlay

The reworked RB3 Gen 2 Industrial mezzanine routes QCC2072 Bluetooth over
UART4 instead of the default Bluetooth-over-USB path. This patch adds a new
overlay that models the M.2 E-key connector graph endpoints for PCIe and UA=
RT,
and disables the on-board WCN6750 PMU and UART7 path.

> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanin=
e-bt-uart.dtso b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzan=
ine-bt-uart.dtso
> new file mode 100644
> index 0000000000000..67577d6f279f4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine-bt-ua=
rt.dtso
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserv=
ed.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +&{/} {
> +	vreg_wcn_3p3: regulator-wcn-3p3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VREG_WCN_3P3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		regulator-boot-on;
> +	};
> +
> +	m2-e-connector {
> +		compatible =3D "pcie-m2-e-connector";
> +		vpcie3v3-supply =3D <&vreg_wcn_3p3>;

[Severity: High]
Does this dummy regulator break hardware power sequencing for the M.2 slot?

The base board's M.2 E-key slot is powered by the vreg_pcie0_3p3 regulator
(controlled by PMIC GPIO 1), but this assigns a dummy vreg_wcn_3p3 fixed
regulator with no GPIO hardware control. This could cause the power sequenc=
ing
driver to blindly toggle a software dummy state instead of the actual hardw=
are
power rail.

Should this use vpcie3v3-supply =3D <&vreg_pcie0_3p3>; and drop the dummy
vreg_wcn_3p3 definition so the power sequencing logic works properly?

[ ... ]

> +&pcie0_m2_e {
> +	port {
> +		pcie0_m2_e_ep: endpoint {
> +			remote-endpoint =3D <&m2_e_pcie_ep>;
> +		};
> +	};
> +};

[Severity: High]
Does this overlay need to delete the existing default usb-controller@0,0 ch=
ild
node from the base board's pcie0_m2_e slot?

Since the QCC2072 PCI device enumerates dynamically on this slot, it will s=
hare
the same bus address. The PCI subsystem might incorrectly assign the
usb-controller@0,0 DT node to the Wi-Fi device, which would apply the USB
controller's default pinctrl and regulator dependencies to the Wi-Fi card,
leading to hardware state corruption.

Can this be resolved by adding a /delete-node/ usb-controller@0,0; under
&pcie0_m2_e?

> +
> +&uart4 {
> +	interrupts-extended =3D <&intc GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&tlmm 19 IRQ_TYPE_EDGE_FALLING>;

[Severity: Medium]
Does this node also need to explicitly delete the inherited interrupts prop=
erty?

The &uart4 node inherits the interrupts property from the base SoC devicetr=
ee.
Adding interrupts-extended without a /delete-property/ interrupts; results =
in
both properties being present, which violates DT schema and causes dtbs_che=
ck
validation warnings.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-rb3-indust=
rial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com?part=3D6
