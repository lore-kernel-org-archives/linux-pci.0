Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619950;
	b=t3Le0eRJAsm3sn5N9mV4F5LR/cyA7b8W1IYp9YuFYMhSL+jdD+5h9CXdN/Dow0TDHI6u
	 lsaJBc7XO3R0AhecDsVdnuOBZYSyEZmV7RI5eN2fOAqjicL+Tad9OnMCyDO/CXoka+dFZ
	 jWoVtUjpbZZi/sfuoLavQlee8+Y+C/MENbhkI2W8n4IlVXYTUJNRWAvQwDJlqhfS1ljSb
	 QcK8O1+lMFLZQ1ilVCnX3MvXB1WwMzfrWkpFgtrKnqJfkFJZGV2/AlwpnVoDZ5LdZ0iYx
	 jtk3OzcyEjiCzej94W+vLsO9c4OVNOTh4XqX6/zwKoYkQIaQ3Zwaz7dMEZ4oZf4J4IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619950;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gWz1rPPKkQfCodscL4IKUEZl5uZsAUwtGaxC+435BLU=;
	b=4jWrnFFBgMKxmddHCXosnClSsMroqZOKnrjzvpuJ9mhbGBh76c/f+iBQkQg3GbNYSVBH
	 xA2BiXt9GzjWw10B4XBZzm8GfYbStq7pwpKg7ni/RoIMRC8dsYUlI/MZg0GCTDzHQ6xeJ
	 sVeRD5DXRf9i4cGZzO9MKW0xGrj/RPzBaSKbjJA1il3qzY5fz3c37hC2WtN88ZM6J8oRh
	 3vq6Vd7hjLLO29bn7i+NwfxodRQ/zNgBuo/ZxA3NDxtRqA3ASZhTHtr18HEcLovWUsBoh
	 kqh3XfPjc+kbpNnpzn6ODEgUqH+0Nijq/NDuIEW9vAKBqbzh5qRoRhr944nUuU0zKPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPQ5YN5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB1606A323;
	Sat, 14 Nov 2026 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPQ5YN5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108351F000C4;
	Sat, 14 Nov 2026 01:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794619949;
	bh=gWz1rPPKkQfCodscL4IKUEZl5uZsAUwtGaxC+435BLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EPQ5YN5iUYKbted/l5NUiRljqYSXk8ZT+ymrT2+D9nbBQYky9Ub45w86ErcojrWa2
	 JfDKo/emXajnP67oJQ8qgMYE2V5GwQUmN6NBt9aXCrzy1cf+UmqSZmqiTHpvY1QrZN
	 wenZLaisytOpLoRYiyKqO5t4MRhqdMwXhAYprTSFUBtaUTbpTPbXqXxKWufLI4IMNa
	 YZh+WUuhjTleIrsioDvw1Sl90wLMZcy8hW3HosXLGbx0lhpZV1s6raYRnb+2TPTqgx
	 +Owh9K6KkBQw8SpP/QYcMr1Nf2xJ7RV4yaVdazfyWODlMPS/7u4zyoMrY/oO7IAy5P
	 td8/oN6Y0nVuA==
Message-ID: <sashiko-outbox-214007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] arm64: qcom: monaco: Add PCIe Endpoint nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261114-monaco_ep-v3-6-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
 <20261114-monaco_ep-v3-6-7fe227cdfac0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:32:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] arm64: dts: qcom: monaco: disallowed input-enable in pcie ep
  tlmm states
- [Low] arm64: dts: qcom: monaco: board-specific PCIe EP GPIOs and
  pinctrl in SoC dtsi
--

commit e2e513d816ae9e8683a2141418e5f09297f8dbd2
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: qcom: monaco: Add PCIe Endpoint nodes

This commit adds DeviceTree nodes and TLMM pin configurations for the two
PCIe Endpoint controllers on Qualcomm Monaco (QCS8300).

> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/q=
com/monaco.dtsi
> index f27f0953ab9e0..4a1325aaf0726 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi

[ ... ]

> @@ -2406,6 +2407,57 @@ pcieport0: pcie@0 {
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

[Severity: Low]
Should reset-gpios, wake-gpios, and the GPIO pin configurations in
pcie0_ep_default_state and pcie1_ep_default_state live in board DTS files
rather than monaco.dtsi?

Only gpio1 (pcie0_clkreq) and gpio22 (pcie1_clkreq) have dedicated PCIe
pinmux functions in the QCS8300 TLMM.  The PERST# and optional WAKE# pins
(gpio0, gpio2, gpio21, and gpio23) use generic GPIO muxing that varies acro=
ss
Monaco boards, and the Root Complex pcie0 and pcie1 nodes in monaco.dtsi le=
ave
those properties to the board files.

In addition, perst-pins in pcie0_ep_default_state and pcie1_ep_default_state
sets bias-pull-up on the GPIO_ACTIVE_LOW reset inputs, which pulls an
undriven PERST# line into the deasserted state and triggers link training in
qcom_pcie_ep_perst_irq_thread() instead of keeping reset asserted with
bias-pull-down.  If any pinctrl nodes remain under tlmm in monaco.dtsi, they
should also be placed in alphabetical order after cam0-default-state.

[ ... ]

> @@ -6239,6 +6342,50 @@ tlmm: pinctrl@f100000 {
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

[Severity: Medium]
Does input-enable in perst-pins under pcie0_ep_default_state and
pcie1_ep_default_state break dtbs_check validation for Monaco boards?

Documentation/devicetree/bindings/pinctrl/qcom,qcs8300-tlmm.yaml validates
subnodes against qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state, which sets
input-enable: false because Qualcomm TLMM pins do not have an input-buffer
enable bit.  Dropping input-enable avoids the schema validation failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-monaco_ep-=
v3-0-7fe227cdfac0@oss.qualcomm.com?part=3D6
