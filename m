Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07DC3F4135;
	Thu, 14 May 2026 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762022; cv=none; b=gFI7oRvuW8QdKBCZ+oITkwmR52mfoonAq3HeCaehWGcx5oD+aovt12II4cHsaJQ7rP7WJr7b99OGsz7ER02HtmZ1oBCVL+LTv1aKCfsb9Vl5E5hfwWMfMaE3GVBtqbxE+K5oaARXmmIE0mPFMQhtt1juxid2kKw3a/B1i3IbNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762022; c=relaxed/simple;
	bh=KAxFHjWUEvSr8tRZeOR2sBDCzcWtFm4IrUtBB1y0hBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QcjnyrZlLTYaGvK4kN+FP8epJwbts2hbHojYqLJaklZeCDEC03qXQe7kC1Q89prcLxiSftNDt0XsyPbNM8NfRNIIc3asl3fC/8ERaoeT3Wmean5apoeXd3cjUnqfc0NKqZvDFnhZgwbro35D5yORD53+IhT+dAjBfeDb/Z78Yc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tps5KY+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tps5KY+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36928C2BCB3;
	Thu, 14 May 2026 12:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778762021;
	bh=KAxFHjWUEvSr8tRZeOR2sBDCzcWtFm4IrUtBB1y0hBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Tps5KY+/Qoo4+nu29h2jopX1UmWNS4bDANOosrR77ZidA2im9UF/5d+m63rtP1/BV
	 JSfQdNDJw22bj8gLWE1yjJ8W39lHehBnEPkliZnystGfcwzua2feLvQhJ3Z6lkrFcT
	 13w8InrtICFehsxgVqbCKZSyq+HAAEPvLHGvW5gLqnt6ItrVGk1FyJ3CoaEoi1w2qF
	 R8eEreWkg3anNxQUKzw4hmb0vbhpkZD9kJpkFvy+2JJysOUTCfacxw8oNvs42V8mrE
	 IXoGmXsWjKEG/a4+so1eJ7zDsfMmCc34RMgS6xvmbT60cqSqIhv+9r9qeoe9OGzcXr
	 ljtzobOIklyVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5210: Enable PCIe support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Varadarajan Narayanan" <varadarajan.narayanan@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260514-pci-ipq5210-v1-2-a09436200b35@oss.qualcomm.com>
References: <20260514-pci-ipq5210-v1-2-a09436200b35@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 12:33:40 +0000
Message-Id: <20260514123341.36928C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The 'phys' property is incorrectly placed in the PCIe Root Port ch=
ild node rather than the main PCIe controller node.
- [Medium] Dummy fixed clocks are used for the PCIe pipe clocks instead of =
the actual PHY nodes.
- [Medium] The `ranges` property in `pcie0` and `pcie1` incorrectly sets th=
e child PCI address for I/O space to match the CPU address.
- [Low] The `pcie0` and `pcie1` nodes define `pinctrl-0` but omit the `pinc=
trl-names` property.
--

commit 6a61b5c948b9e28a9b86554a5e888347a3c559ab
Author: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

arm64: dts: qcom: ipq5210: Enable PCIe support

Add DT entries to enable the PCIe controllers found in ipq5210.

> diff --git a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts b/arch/arm64/boo=
t/dts/qcom/ipq5210-rdp504.dts
> index 941f866ecfe95..5e599a1cea3f4 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
[ ... ]
> @@ -20,6 +21,32 @@ chosen {
>  	};
>  };
> =20
> +&pcie0_phy {
> +	status =3D "okay";
> +};
> +
> +&pcie0_rp {
> +	reset-gpios =3D <&tlmm 32 GPIO_ACTIVE_LOW>;
> +};
> +
> +&pcie0 {
> +	pinctrl-0 =3D <&pcie0_default_state>;

Should this node also include a pinctrl-names property?

Omitting pinctrl-names =3D "default" might trigger validation warnings, even
if the pinctrl core falls back to index 0.

> +	status =3D "okay";
> +};
> +
> +&pcie1_phy {
> +	status =3D "okay";
> +};
> +
> +&pcie1_rp {
> +	reset-gpios =3D <&tlmm 29 GPIO_ACTIVE_LOW>;
> +};
> +
> +&pcie1 {
> +	pinctrl-0 =3D <&pcie1_default_state>;

Similarly, should pinctrl-names =3D "default" be added here?

> +	status =3D "okay";
> +};
> +
>  &sdhc {
>  	max-frequency =3D <192000000>;
>  	bus-width =3D <4>;
> diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/=
qcom/ipq5210.dtsi
> index 3761eb03ab246..ec1c9a8c08e0a 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
[ ... ]
> @@ -13,6 +14,18 @@ / {
>  	interrupt-parent =3D <&intc>;
> =20
>  	clocks {
> +		pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <250000000>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <250000000>;
> +			#clock-cells =3D <0>;
> +		};
> +

Is it intentional to use dummy fixed clocks for the PCIe pipe clocks here?

The PCIe PHY nodes below (pcie0_phy, pcie1_phy) are correctly configured as
clock providers (#clock-cells =3D <0> and clock-output-names).

Hardcoding these as fixed clocks severs the dependency graph, so the GCC mi=
ght
not establish a parent-child relationship with the PHY. Could this allow the
clock to be enabled without the PHY being powered on?

[ ... ]
> +		pcie1: pcie@50000000 {
[ ... ]
> +			#size-cells =3D <2>;
> +
> +			ranges =3D <0x81000000 0x0 0x50200000 0x0 0x50200000 0x0 0x00100000>,

Does this I/O space mapping correctly set the PCI child address?

This maps the CPU address 0x50200000 to PCI I/O address 0x50200000, but sta=
ndard
PCI architectures typically expect the I/O port address space to start at
address 0 on the PCI bus side.

Should it translate the CPU I/O base address to the PCI I/O address 0?

> +				 <0x82000000 0x0 0x50300000 0x0 0x50300000 0x0 0x0fd00000>;
[ ... ]
> +			pcie1_rp: pcie@0 {
> +				device_type =3D "pci";
> +				reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range =3D <0x01 0xff>;
> +				phys =3D <&pcie1_phy>;

Should the phys property be placed in the main PCIe controller node instead
of the Root Port child node?

The Qualcomm PCIe controller driver expects to find the phys property in the
main controller node using devm_phy_optional_get(dev, "pciephy").

If it is placed in the child node, devm_phy_optional_get() might return NULL
and silently bypass PHY initialization.

> +
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				ranges;
> +			};
> +		};
> +
> +		pcie0: pcie@70000000 {
[ ... ]
> +			#size-cells =3D <2>;
> +
> +			ranges =3D <0x81000000 0x0 0x70200000 0x0 0x70200000 0x0 0x00100000>,

Similar to pcie1, should this I/O space mapping translate the CPU I/O base
address to the PCI I/O address 0 instead of matching the CPU address?

> +				 <0x82000000 0x0 0x70300000 0x0 0x70300000 0x0 0x0fd00000>;
[ ... ]
> +			pcie0_rp: pcie@0 {
> +				device_type =3D "pci";
> +				reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range =3D <0x01 0xff>;
> +				phys =3D <&pcie0_phy>;

Also similarly here, should this phys property belong to the parent pcie0
node instead of the pcie0_rp child node?

> +
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				ranges;
> +			};
> +		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514-pci-ipq521=
0-v1-0-a09436200b35@oss.qualcomm.com?part=3D2
