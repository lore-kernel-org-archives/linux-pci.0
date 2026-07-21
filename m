Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3367449999;
	Tue, 21 Jul 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627632; cv=none; b=KHbaotTswuqgqgEnCmLk8UB3QaWHZP3IvjBAHWIcD2OuLYxGvDV2KFnk03feQ03Wh+6N7G1QOu3zgrqZyQdVEQOJDKzTX/psPbW//UmBHaFbgnAnOA/5GaBOOyR7oO6wkbrS3WTqsyrqKqMkzcJegjVUaW7ftRVvbzr+nu7ymBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627632; c=relaxed/simple;
	bh=gd9LpzBhS7XS8RSDLiyquuDsoh18/p24mvBb3VGhQX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oi73ggIXDQKU/GikJqg6oCSgcSoPT2l2Yvv2i0v8TMlmyUsfkJPtL7/+Q4x/T5EiZIC2nRpwWH4ya2LEB8tlPhp/mjyu5rqPxni9e7HF7AEP+9ZjIARkqn4iIfJevga5SU3FFS1lKDSUVasan2dT0OEdVjH2m4fuLAhHGXmyk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNAfgGC/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNAfgGC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D93A1F000E9;
	Tue, 21 Jul 2026 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627630;
	bh=t0L37vEtXlWkQ6+/Voui1GPXR9x6i3ICcddjR6byIzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NNAfgGC/OPOqlFKx9aeGdnHkRYubWW/jNwANElxTHCwWVm04xzPA0mJYiBV5zdNwH
	 sRPzpJ7VsLd+yAr9Z0j0l61txiihhoXYDGy2pvEyfaiM+Dp5Q1Qfi1HwAt6OHTfXAh
	 RdJDnY1f/A57ZoFrVh8CK/341GUvfi2xva+r+n1fRLMtKkVlok4uEZV5gDaOFAhQ3L
	 dVFpQlnPic4z72r9Te9Q0+Q8YWUlCRSEo7Nb2DQstifa8UqDde9jnlgMY8Y1q7Zghr
	 0zYwFjcn5zOU+ckQLdxU6jS+djfotOJZic/gBdBpAF2lA188/lIHZl8dFJ1dMSQpjw
	 OiJ95uc0nXHHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260721-eliza_evk-v3-1-92b10038f13d@oss.qualcomm.com>
References: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
 <20260721-eliza_evk-v3-1-92b10038f13d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:53:50 +0000
Message-Id: <20260721095350.8D93A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Gen3 operating points in PCIe OPP tables incorrectly require 'low_=
svs' instead of 'nom'.
- [High] The pcie0 and pcie1 nodes are missing the msi-map property.
--

--- Patch [1]: [PATCH v3 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and con=
troller nodes ---
commit be92db70e138e71a2f5b523e4b36113ca9171196
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes

Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
(PCIe1). This commit adds PCIe controller and PHY nodes for both instances,
and updates the GCC clock references to use the newly added PHY nodes.

> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qc=
om/eliza.dtsi
> index 357e8066c1768..41a1203117681 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
[ ... ]
> +		pcie0: pcie@1c00000 {
[ ... ]
> +			iommu-map =3D <0 &apps_smmu 0x1480 0x1>,
> +				    <0x100 &apps_smmu 0x1481 0x1>;
> +
> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 564 IRQ_TYPE_LEVEL_HIGH>,

[Severity: High]
Is the msi-map property missing from the pcie0 node?

Without an msi-map property, the PCIe Requester ID cannot be translated to =
the
GIC ITS Device ID. Does this break MSI/MSI-X delivery for connected PCIe
endpoints?

> +					<0 0 0 2 &intc 0 0 0 565 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 566 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 567 IRQ_TYPE_LEVEL_HIGH>;
[ ... ]
> +			pcie0_opp_table: opp-table {
[ ... ]
> +				/* 8 GT/s x1 */
> +				opp-8000000-3 {
> +					opp-hz =3D /bits/ 64 <8000000>;
> +					required-opps =3D <&rpmhpd_opp_low_svs>;

[Severity: High]
Are the voltage requirements correct for the 8 GT/s operating point?

Voting for a lower voltage (low_svs) instead of the nominal voltage (nom) f=
or
Gen3 speeds might result in PCIe link instability or negotiation failures d=
ue
to insufficient PHY power. Should this require rpmhpd_opp_nom instead?

> +					opp-peak-kBps =3D <984500 1>;
> +					opp-level =3D <3>;
> +				};
> +
> +			};
[ ... ]
> +		pcie1: pcie@1c08000 {
[ ... ]
> +			iommu-map =3D <0 &apps_smmu 0x1400 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x1>;
> +
> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,

[Severity: High]
Is the msi-map property missing here in the pcie1 node as well?

> +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;
[ ... ]
> +			pcie1_opp_table: opp-table {
[ ... ]
> +				/* 8 GT/s x1 */
> +				opp-8000000-3 {
> +					opp-hz =3D /bits/ 64 <8000000>;
> +					required-opps =3D <&rpmhpd_opp_low_svs>;

[Severity: High]
Should this Gen3 8 GT/s OPP also vote for the nominal voltage (nom) instead=
 of
low_svs to maintain signal integrity?

> +					opp-peak-kBps =3D <984500 1>;
> +					opp-level =3D <3>;
> +				};
> +
> +				/* 8 GT/s x2 */
> +				opp-16000000-3 {
> +					opp-hz =3D /bits/ 64 <16000000>;
> +					required-opps =3D <&rpmhpd_opp_low_svs>;

[Severity: High]
Does this 8 GT/s x2 OPP need to require rpmhpd_opp_nom similar to the other
Gen3 operating points?

> +					opp-peak-kBps =3D <1969000 1>;
> +					opp-level =3D <3>;
> +				};
> +
> +			};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-eliza_evk-=
v3-0-92b10038f13d@oss.qualcomm.com?part=3D1
