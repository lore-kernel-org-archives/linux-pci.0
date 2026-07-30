Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D33429CFA;
	Thu, 30 Jul 2026 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414172; cv=none; b=nyA0ov+uvnsLdoaBdoiyGcdGSGKDhGeGe8/6IPasG0UY6+eRGoxYIPzVKwfeiaj7muc4hmUpMcogxGInLJ0XLrkGoSfi5zaKBfPX9oLSyS28fypY0pGejp5fGq2bx6lTXhz3hiNww+Yiq5zwxISBCQRHg4kHBVHmRo/Z6IWZRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414172; c=relaxed/simple;
	bh=O5PoTBFlkzhjg33RGS15bxnkQwczdACW3nrRqI+KrDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MiRqXDLtVxZvrnPlsmgjZFQ3ofRr+8bn4PcXLe41XodHCkhzZOLRtBfqRGf2HtOqV8ei10+ygdNOun7R/X05TD34sMiY0zV5+c6zfOe+C3o699bFQ6jA2HiwclADItStySuBHmR7xSEcrT7r4jzGYg6ISQwSXJ+asYgIcXVIjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvfPOl+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvfPOl+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D8A1F000E9;
	Thu, 30 Jul 2026 12:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414169;
	bh=Dx1KYsvfN0hek2uEU3lDcCuGLBOWNIEY1KDv82lPvBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VvfPOl+4nHPN+hyxOwsfHLfvA3RJ+5fvcHrMkiiucwGdL71ah/vhy4QhuPM35b4XB
	 H5/QLedjrsuLred7heElysY5aOy5ZUwFOV1JFi6qkX3HxPXcDkU7ios+TBA4Q+1EUG
	 RJ6w38EF9T3WbJrxfWBOwKZUURvhaYMcTaVntcvCjRZZg2eYQK3nundWrv/FajuS51
	 7TfaBQmfRbDNJWYvFrtOvz6VOxqu7BmFGEyhJocZIh4AHw+3yMV+WEolK/hLzpMVgF
	 PZ+4hhTlPXcALJJ56xFilwENxUOwMyKT1IQU6oQjXeRSAaSYfVYcXcStNHqPL2bo55
	 14Ki2z6e1JXMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260730-eliza_evk-v7-1-7ac7b66a3e6d@oss.qualcomm.com>
References: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
 <20260730-eliza_evk-v7-1-7ac7b66a3e6d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:22:48 +0000
Message-Id: <20260730122248.A9D8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing `msi-map` property in PCIe controller nodes.
- [High] Incorrect hardware configuration via copy-paste error: `pcie1` use=
s SM8550 `pcie0` interrupts and stream IDs.
- [Medium] Missing `num-lanes` property in PCIe controller nodes.
--

--- Patch [1]: [PATCH v7 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and con=
troller nodes ---
commit 2d2260f9f24a370e16b32d6b0fe6e207c07d9ae1
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes

Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
(PCIe1). Add PCIe controller and PHY nodes for both instances, and update
the GCC clock references to use the newly added PHY nodes instead of
placeholder zeros.

> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qc=
om/eliza.dtsi
> index 357e8066c1768..6834137bd5e98 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
[ ... ]
> +		pcie0: pcie@1c00000 {
> +			device_type =3D "pci";
> +			compatible =3D "qcom,eliza-pcie", "qcom,pcie-sm8550";
> +			reg =3D <0x0 0x01c00000 0x0 0x3000>,
[ ... ]
> +			ranges =3D <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x3d00000>;
> +

[Severity: High]
Should this node include the msi-map property? Without msi-map mapping PCIe
Requester IDs to the ITS Device IDs, the PCI framework cannot associate the
devices with the GICv3 ITS MSI controller. This could cause endpoints to fa=
il
probing or silently fall back to legacy INTx.

[Severity: Medium]
The commit message mentions PCIe0 is an 8GT/s x1 instance. Does this need a
num-lanes =3D <1>; property here to restrict the link width? Omitting it
forces the driver to rely on unverified hardware reset defaults.

> +			interrupts =3D <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
[ ... ]
> +			operating-points-v2 =3D <&pcie0_opp_table>;
> +
> +			iommu-map =3D <0x0 &apps_smmu 0x1480 0x0 0x1>,
> +				    <0x100 &apps_smmu 0x1481 0x0 0x1>;

[Severity: High]
Is the stream ID (0x1480) swapped with pcie1? It looks like pcie0 is using
the stream IDs typically reserved for pcie1, while pcie1 below uses 0x1400.
Using incorrect stream IDs could cause immediate SMMU context faults when
endpoints attempt DMA.

[ ... ]
> +		pcie1: pcie@1c08000 {
> +			device_type =3D "pci";
> +			compatible =3D "qcom,eliza-pcie", "qcom,pcie-sm8550";
> +			reg =3D <0x0 0x01c08000 0x0 0x3000>,
[ ... ]
> +			ranges =3D <0x01000000 0x0 0x00000000 0x0 0x44200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x44300000 0x0 0x44300000 0x0 0x3d00000>,
> +				 <0x43000000 0x4 0x00000000 0x4 0x00000000 0x3 0x00000000>;
> +

[Severity: High]
Similar to pcie0, should pcie1 include the msi-map property to route its
downstream MSIs to the GIC ITS?

[Severity: Medium]
The commit message mentions PCIe1 is an 8GT/s x2 instance. Should there be a
num-lanes =3D <2>; property here to prevent relying on unverified hardware
reset defaults for the link width?

> +			interrupts =3D <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;

[Severity: High]
Are these interrupts correct for Eliza's pcie1? These look like an exact
copy of the SM8550 pcie0 interrupts (141-148), whereas Eliza's pcie0 uses
distinct interrupts (376, 478...). Wiring pcie1 to incorrect physical IRQ
lines could render endpoint devices dead.

[ ... ]
> +			operating-points-v2 =3D <&pcie1_opp_table>;
> +
> +			iommu-map =3D <0x0 &apps_smmu 0x1400 0x0 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x0 0x1>;

[Severity: High]
Similar to the interrupt assignment, are these stream IDs correct for pcie1?
This uses 0x1400/0x1401 which are typically SM8550 pcie0 IDs, whereas pcie0
above was assigned 0x1480.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-eliza_evk-=
v7-0-7ac7b66a3e6d@oss.qualcomm.com?part=3D1
