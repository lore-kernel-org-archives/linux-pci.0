Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239443230D;
	Mon, 21 Sep 2026 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990835; cv=none; b=O95lTfTScUhE/UVhlVEZ9wbmepw5kO7/8aZtHy7AOwbjzVmM9bTK30trsibTBoXzdkdo+OVZbUuKlvU3Cr6r4CLiqO12Y1dDeC0PRUXMgSa/vxT9/mu0FaMqjKwSrIKZnEX1Elc1aMrQECRaH3D820PpMo6fajU7FYuirQnWGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990835; c=relaxed/simple;
	bh=npATMY12C+GY7ohGLRtqK0XErpc5fS+ZSiUMul/BW9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QH9xnt7m1SlUgzR8tv+xAzh9dIitp9SBvO7QBFgJPKHH2s/5aDqyTtwjVsrbuw5zzTN4dzzhGSL5+dFx3CG27upHZMEgyo4shA20chqOhtlDl7S7ciMOWgE3i2t6MR7kDbj4loaMxwu8We03k1WZvQOFlM5oeQvrFr/lrMFp5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIVzC4oA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIVzC4oA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644391F000FF;
	Mon, 21 Sep 2026 11:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990833;
	bh=Pma1GOXfPcPEVtvFI91F+Aj2Iy3Q46cl+VPrJ6bEO30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZIVzC4oAwdtToJflZXtRHdIXZ/xN7MUn27nO7LUyDdbyhKViWlhQurkezDBNFFhqV
	 4JLz/N+WkoGUwrxL8O7Yc9dvGBv7N2EquDnFVIn4E4F3xQtanh1H552NCy0vbdLfkZ
	 Yug6+oi6hxC00SR4PyL89tYTnDN4+LvrRGNwI1PVAnonGM6B7q5qagld527oDchIzw
	 j/FX1xpKf1+hG98fuVs5wyaoNV1ZSvUzD0ufHD0RdzGwWNUaHlFZMQVPg+aBEWKmca
	 x5gpZTkEV9cbFZ97KMlRtjR/7KZEQIZAaZePgdBWsEwzf+XL4wwMYRgMLcpMmm0EGQ
	 I7pH2c/tI949A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] arm64: qcom: monaco: Add PCIe Endpoint nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: olteanv@gmail.com, conor+dt@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org, vkoul@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260921-monaco_ep-v1-6-63c5282fb0db@oss.qualcomm.com>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-6-63c5282fb0db@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:40:32 +0000
Message-Id: <20260921114033.644391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dts: qcom: spurious PCIe WAKE# assertion due to output-low
--

commit e087a4ad529c59501ceaa5d2b1a9d03392103204
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: qcom: monaco: Add PCIe Endpoint nodes

This commit adds two PCIe controllers that can operate in Endpoint mode for
Monaco. It describes the Endpoint nodes for both controllers, including the=
ir
register regions, clocks, interrupts, interconnects, and PHY connections.

> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/q=
com/monaco.dtsi
> index d7d135e87a8c7..8f2f0941383aa 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi

[ ... ]

> @@ -6225,6 +6323,52 @@ tlmm: pinctrl@f100000 {
>  			#interrupt-cells =3D <2>;
>  			wakeup-parent =3D <&pdc>;
> =20
> +			pcie0_ep_default_state: pcie0-ep-default-state {
> +				wake-pins {
> +					pins =3D "gpio0";
> +					function =3D "gpio";
> +					drive-strength =3D <2>;
> +					output-low;

[Severity: Medium]
Will configuring this pin as output-low cause a spurious PCIe WAKE# asserti=
on?

Since the endpoint nodes omit wake-gpios, the endpoint driver in
drivers/pci/controller/dwc/pcie-qcom-ep.c will not request the GPIO to
logically de-assert it. Because this configures the pin to output 0V, won't
the active-low WAKE# signal remain permanently driven low by default?

This could cause the endpoint to continuously assert the WAKE# signal to the
host, potentially preventing the host from sleeping or causing a wake
interrupt storm.

> +				};
> +
> +				clkreq-pins {

[ ... ]

> +			pcie1_ep_default_state: pcie1-ep-default-state {
> +				wake-pins {
> +					pins =3D "gpio21";
> +					function =3D "gpio";
> +					drive-strength =3D <2>;
> +					output-low;

[Severity: Medium]
Does this have the same continuous WAKE# assertion issue as
pcie0_ep_default_state above?

> +				};
> +
> +				clkreq-pins {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-monaco_ep-=
v1-0-63c5282fb0db@oss.qualcomm.com?part=3D6
