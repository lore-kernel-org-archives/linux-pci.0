Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2356C3195EF;
	Tue, 28 Jul 2026 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223275; cv=none; b=RvC/0Nz/BQ+pOp+5ZbYeLzqkc8Kpod85rIsm7Cif0faFtAIA04wzMoqwg85e8cWbbQbejGu8D6RpzigyGVzFJCdesv/FFx2lvGEffXpY44t8Q+m84xNiBc6pOWWluTElcfi8l5GBI4lKAL6IMnqEOfgv6VUozYbI5D1vz7eBvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223275; c=relaxed/simple;
	bh=E2u/yZHVwohOUYZYBWNklBhTCJwZ6TH2bV2eKBupdos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XMhENoXnBXY/gz3/rCGqmeYIB8RzgRDSucGrYW6egvR8R0I5LG6Aw/KJfP51KUOt6SWJMi8A09kKO4az56PfgnfmiU89dKNhIi24TUh66am+UzeBDAC1bQU4MX2YU0u+DHOT6gWCRPwkm9g9VpTzi8lRym5vwkgwhWS8aM6IYBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBl+N3oC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBl+N3oC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCBE1F000E9;
	Tue, 28 Jul 2026 07:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785223273;
	bh=uO8XeJX7VjjjUB2Zia3BKteUXm5WYluvgfemrMBeoW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBl+N3oCg5uaL8UsEOEcXOoRgTvEZ158oMZxgB1MkquKxl93OwLsnGdUAF2RGz1X9
	 pu1GzuQ5uF3xsSB+BCgf3Zjgykpm8fPKoQzbrWW2EQBjWjXqCG/TDBedl9ptB3MllY
	 Bd+n9XdHriuoAyarnXqajMM6gnKGeVZc7d3GO8wDGCzHEq15Q8eAOWNwO+0FYL3YFY
	 ltSWF+aKBTbfDYijMcStFfoUdTHVpUPtGMckGZZwf0EdOF5cU1l15J+NFOGeOubwZi
	 bY6Jeu0+yufAU/MwMpdv3sfHOByiJQ4vUQyM+H2HzsrvQIUrCNNDp68kfIqvE1Y5fq
	 Y4qRFTJddGKSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260728-eliza_evk-v4-1-decc7fe5246e@oss.qualcomm.com>
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
 <20260728-eliza_evk-v4-1-decc7fe5246e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 07:21:13 +0000
Message-Id: <20260728072113.8FCBE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `msi-map` property in the PCIe host controller nodes, comp=
letely breaking Message Signaled Interrupts (MSI/MSI-X).
--

--- Patch [1]: [PATCH v4 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and con=
troller nodes ---
commit 16f01d1efdef1f9640d6946e1dff4bcb10d4c047
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes

This commit introduces PCIe controller and PHY nodes for the Eliza platform.
It also updates the GCC clock references to point to the newly added PHY
nodes instead of placeholder zeros.

> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qc=
om/eliza.dtsi
> index 357e8066c1768..31835a5828834 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
[ ... ]
> @@ -1784,6 +1784,369 @@ mmss_noc: interconnect@1780000 {
[ ... ]
> +		pcie0: pcie@1c00000 {
> +			device_type =3D "pci";
[ ... ]
> +			iommu-map =3D <0 &apps_smmu 0x1480 0x1>,
> +				    <0x100 &apps_smmu 0x1481 0x1>;
> +
> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 564 IRQ_TYPE_LEVEL_HIGH>,

[Severity: High]
Is a msi-map property missing from this pcie0 node?

Without the msi-map property, the kernel's PCI OF core cannot establish an
MSI domain for the PCIe bus. Will this cause MSI/MSI-X interrupts to fail
for all connected PCIe endpoints, forcing them to fall back to legacy INTx
interrupts if supported?

[ ... ]
> +		pcie1: pcie@1c08000 {
> +			device_type =3D "pci";
[ ... ]
> +			iommu-map =3D <0 &apps_smmu 0x1400 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x1>;
> +
> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,

[Severity: High]
Is a msi-map property also missing from this pcie1 node?

Similar to pcie0, omitting this property might prevent modern devices like
NVMe drives that exclusively rely on MSIs from functioning correctly on
this controller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-eliza_evk-=
v4-0-decc7fe5246e@oss.qualcomm.com?part=3D1
