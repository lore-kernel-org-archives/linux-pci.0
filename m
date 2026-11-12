Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474350;
	b=qZOndO6sC22rEsU7bp+S2K92aqjSjLMmCGh/scboN51EHSHYFOoykgNK+6oBRPBRjyiy
	 SvI6ysMWQCYL8BSaO/7tkLbms+wGZJkr/AbKDxjysxazc/uL21mUCoHl6xuAGOjcl2mI1
	 3SS7WweqzBfhd+6ifC9223DdWvMLbRRiXEAwWZYYwO2uqYtss/BtlDbIK2nCwYhpxJBJL
	 41d+VzXKStzO8qESYbf06CcrT7nLAD3/dUitWydx1x4jshEdeCrDOFI6IwLYYCIX4ysid
	 6AUxCM0zNk3H1Ynj8abI6cEJXIsiFjD54ISRHI19Dyc5SzUyQA/tD506rY3kYQqAUNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474350;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NvQAfYTTp48KO9E9UCLMZKIj2Vyzo/A0xwv6zBQGUaE=;
	b=D/PrdoN/I9lkIliaWnKzMV/jUoudc5PrtQIKBEM4/32Vf/8ZJWraHWw3GQsVW/CYhuaH
	 4TMW9xmu1CHiUrCpfl/eKvwuifhk/gBSkPnnAlfMQGeVALyHJlP4IYUN3C/YkWsyNpx0V
	 xgdVVf51WKAh5ZvKYUVOF5xqcD0vH7Zf3UrnJjJjxlMOjka5cHmRusewxEpJ6AxgyvafW
	 xJ51Rduqo1O4xL17IM5sXzuoh2qOWwlzBuV+8RFWwIRrVy/Okp6whCX3DVqppBRnnTz5c
	 OIaIbwo5c3zqz+uGxW/0fuRxOLi7xouA+rRhfGaIgBJzxfuUqZjMP/uy86OjS55VDOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VV5D4ZlR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6F606A89A;
	Thu, 12 Nov 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VV5D4ZlR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128E51F00A0B;
	Thu, 12 Nov 2026 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474350;
	bh=NvQAfYTTp48KO9E9UCLMZKIj2Vyzo/A0xwv6zBQGUaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VV5D4ZlRiBJWuPqp0Wb1LwES4abEINHleWVQhG6JY3yMOvDrsI2NcG6klLyxskDQO
	 hht5u+cxrkgto9MlarQ8BW8I7Uu0TvBjt1802i40PMXlnGevbNub4J90msg8Wpgfh0
	 HL5tKrlcj+ho80PNzqrzgnx624fLXiPL4Xp4m6ABrv7im2TnmCtewv0TCpJkrQrdMw
	 ep7QPoeb1Tg2meAnZd90JHuDzDIxyHCNo9t8gQ0fMWwIcGL3+0ODGBDbXMgWFFHY3M
	 7sHYrQvCfdj7MvbsrNxYAhc8wNUB+g0/8R2BNt1TMcGWtnYpI9xpo6FVNXcAYmdRtq
	 xzXeydJFoZPEA==
Message-ID: <sashiko-outbox-210822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: shikra-iqs: add M.2 Wi-Fi and
 Bluetooth overlay
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linghui Wu" <linghui.wu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261112083355.3884737-5-linghui.wu@oss.qualcomm.com>
References: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
 <20261112083355.3884737-5-linghui.wu@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 09:05:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] arm64: dts: qcom: wake-gpios placed on &pcie host bridge
  instead of &pcie_port0
- [Medium] arm64: dts: qcom: duplicate m2_keye_3p3 supply on &pcie
  bypasses M.2 pwrseq
- [Medium] arm64: dts: qcom: shikra: pcie interrupt-map missing 4th
  GICv3 cell
- [Low] arm64: dts: qcom: shikra-iqs: swapped pcie_phy supplies in M.2
  overlay
- [Low] arm64: dts: qcom: shikra-iqs: redundant iommu-map override in
  M.2 overlay
--

commit 1c809b4232eacddb83a64fcaf6b111c590153326
Author: Linghui Wu <linghui.wu@oss.qualcomm.com>

arm64: dts: qcom: shikra-iqs: add M.2 Wi-Fi and Bluetooth overlay

This commit adds a Device Tree overlay for M.2 Key-E Wi-Fi and Bluetooth
modules on the Qualcomm Shikra IQS EVK and disables the onboard WCN3988
Wi-Fi and Bluetooth nodes when the overlay is applied.

Link: https://lore.kernel.org/r/20261102045815.2938940-1-linghui.wu@oss.qua=
lcomm.com

> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso b/ar=
ch/arm64/boot/dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso
> new file mode 100644
> index 0000000000000..ef0f197a53f85
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso
> @@ -0,0 +1,122 @@

[ ... ]

> +	wifi-bt-connector {
> +		compatible =3D "pcie-m2-e-connector";
> +
> +		vpcie3v3-supply =3D <&m2_keye_3p3>;
> +		w-disable1-gpios =3D <&tlmm 61 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios =3D <&tlmm 60 GPIO_ACTIVE_LOW>;

[ ... ]

> +&pcie {
> +	iommu-map =3D <0x0 &apps_smmu 0x0800 0x0 0x1>,
> +		    <0x100 &apps_smmu 0x0801 0x0 0x1>;

[Severity: Low]
Should this 5-cell iommu-map live in shikra.dtsi instead of being
overridden in this overlay?

In shikra.dtsi (added in commit "arm64: dts: qcom: shikra: add PCIe PHY
and controller nodes"), apps_smmu has #iommu-cells =3D <2>, but the base
pcie node defines 4-cell iommu-map entries (<0x0 &apps_smmu 0x800 0x1>,
<0x100 &apps_smmu 0x801 0x1>), which triggers the of_check_bad_map()
warning in of_map_id().  Since this overlay maps the exact same BDFs and
SIDs and only supplies the missing second IOMMU specifier cell (0x0),
fixing iommu-map in shikra.dtsi allows dropping this override here.

> +	pinctrl-0 =3D <&pcie_default_state>;
> +	pinctrl-names =3D "default";
> +	vddpe-3v3-supply =3D <&m2_keye_3p3>;

[Severity: Medium]
Does setting vddpe-3v3-supply =3D <&m2_keye_3p3> on &pcie conflict with
pwrseq-pcie-m2 managing the same rail through wifi-bt-connector's
vpcie3v3-supply?

In qcom_pcie_host_init(), pcie->cfg->ops->init() (qcom_pcie_init_2_7_0())
enables vddpe-3v3-supply before pci_pwrctrl_create_devices() and
pci_pwrctrl_power_on_devices() run:

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_host_init() {
	ret =3D pcie->cfg->ops->init(pcie);
	if (ret)
		return ret;

	ret =3D qcom_pcie_phy_power_on(pcie);
	if (ret)
		goto err_deinit;

	if (!pci->suspended) {
		ret =3D pci_pwrctrl_create_devices(pci->dev);
		if (ret)
			goto err_disable_phy;
	}

	if (!pp->skip_pwrctrl_off) {
		ret =3D pci_pwrctrl_power_on_devices(pci->dev);
		if (ret)
			goto err_pwrctrl_destroy;
	}
}

This turns on m2_keye_3p3 before the M.2 power sequencer runs, glitches
the 3.3 V rail when qcom_pcie_host_init() unwinds through err_deinit on
an initial -EPROBE_DEFER from pci_pwrctrl_power_on_devices(), and holds an
enable vote on &pcie that prevents pwrseq-pcie-m2 from gating the rail.

> +	wake-gpios =3D <&tlmm 119 GPIO_ACTIVE_LOW>;

[Severity: Medium]
Should wake-gpios be placed on &pcie_port0 rather than on the &pcie host
bridge node?

Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml marks
wake-gpios on the host bridge node as deprecated in favor of the PCIe root
port node.  At runtime, pcie-qcom.c does not parse wake-gpios, and
pci_configure_of_wake_gpio() in drivers/pci/of.c only looks up wake-gpios
on the OF node attached to a struct pci_dev (such as &pcie_port0), so
PCIe WAKE# is never configured when the property is on &pcie.

> +
> +	status =3D "okay";
> +};

[Severity: Medium]
When this overlay enables &pcie, does legacy PCI INTx parsing fail due to
the 5-cell interrupt-map entries inherited from shikra.dtsi?

In shikra.dtsi, &intc declares #interrupt-cells =3D <4> and
#address-cells =3D <2>, so of_irq_parse_imap_parent() consumes 6 cells after
&intc in each interrupt-map entry.  However, the pcie node in shikra.dtsi
(added in commit "arm64: dts: qcom: shikra: add PCIe PHY and controller
nodes") only provides 5 cells after &intc:

arch/arm64/boot/dts/qcom/shikra.dtsi:
			interrupt-map =3D <0 0 0 1 &intc 0 0 0 499 IRQ_TYPE_LEVEL_HIGH>,
					<0 0 0 2 &intc 0 0 0 500 IRQ_TYPE_LEVEL_HIGH>,
					<0 0 0 3 &intc 0 0 0 501 IRQ_TYPE_LEVEL_HIGH>,
					<0 0 0 4 &intc 0 0 0 502 IRQ_TYPE_LEVEL_HIGH>;

Because the trailing 4th GICv3 cell (0) is missing from each entry,
of_irq_parse_imap_parent() consumes the first cell of the next entry as
the 4th interrupt cell and misaligns all subsequent entries, causing
INTB, INTC and INTD resolution to fail with -EINVAL.

> +
> +&pcie_phy {
> +	vdda-phy-supply =3D <&pm8150_l12>;
> +	vdda-pll-supply =3D <&pm8150_l9>;
> +
> +	status =3D "okay";
> +};

[Severity: Low]
Are vdda-phy-supply and vdda-pll-supply swapped here?

In shikra-iqs-som.dtsi, pm8150_l9 is the 0.88 V rail (875000..1000000 uV)
and pm8150_l12 is the 1.8 V rail (1650000..1950000 uV).  On QMP PHYs (such
as &usb_qmpphy in shikra-iqs-evk.dts and &pcie_phy in qcs615-ride.dts and
talos-evk-som.dtsi), vdda-phy-supply takes the ~0.88 V rail (&pm8150_l9)
and vdda-pll-supply takes the 1.8 V rail (&pm8150_l12).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112083355.3884=
737-1-linghui.wu@oss.qualcomm.com?part=3D4
