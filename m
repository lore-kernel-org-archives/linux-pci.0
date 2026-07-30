Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564C36D9EB;
	Thu, 30 Jul 2026 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785388719; cv=none; b=L702jdHEWrOu0qT5yl+STtu6MoPgya8DJPLTOd+wMWqPTlRcJZcxwZl8aOU4kwexdG7b9PNufcse/MrwBZnPnQKLolbDV4dTCZnkozjaolUcKoknT/egpUxiy8zxV2JB6STz0jqbylpr4ELHRVJmGzSXQPgt1LDh89oAZo4N0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785388719; c=relaxed/simple;
	bh=zIpDb2WulQ0HId40+mPdEnwuysSJXOWdloRL1emmnKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DS8Vq/ivCjIcRphgMXkLwGfzLmv+9OdeLr14cZjqrU9oox6r8OM0efl1NlSJ9AM4VZJUaKzLzhMv8R4Q6ZS3V3ltOJkpkpTi+pkrnxf0w/DqazJJWB6urb8nx9cK8qmvOGnf3RkPEZLeT2FeyQbivGaVqknFjbyqQkkzRyk3c9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEhIAoYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEhIAoYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D1E1F000E9;
	Thu, 30 Jul 2026 05:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785388718;
	bh=sEzfwMV0XxftYPjYs3yJOAIrrrM/AHcqocJQcXU9ca4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IEhIAoYI73pmQG66/g/NP1r+Rr/fqfC1rWJg1ecJytNVahNUf63VdNOhNMfRWL04S
	 pg6VZ91WItIrbX7rosTUYroqpf73l2G+t1JYsCRJxiEvnETsNmm5BV3C3ZtLrUoAU1
	 JOv7pXD2MOVqr1ylMboUOcqoyen2cBOOBwXwbf6FWT5TkLmuXUAJmf3+ZlrdBtnAG5
	 2DdgLhbSYcXUQb7U7IFAqL11Ad5npHZ+tSFZBHR9coqze0m670quGOuhxjojimGhm0
	 q7XrvVzzekBJvXUNdFAfyoToPRwvyFRLt5HkDQtxMSZxdRSZjbNv4ICd9wX1vspu5A
	 HZNCT0S5OU93A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260730-eliza_evk-v6-1-40ece2d33114@oss.qualcomm.com>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
 <20260730-eliza_evk-v6-1-40ece2d33114@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 05:18:37 +0000
Message-Id: <20260730051837.C5D1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `msi-map` property in `pcie0` and `pcie1` breaks GIC ITS M=
SI translation.
- [Low] Hardcoded literal `0` used instead of `GIC_SPI` macro in `interrupt=
-map`.
--

--- Patch [1]: [PATCH v6 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and con=
troller nodes ---
commit f31bbbba6b5914ad12f809fe8f6dd440484e6594
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes

Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
(PCIe1). Add PCIe controller and PHY nodes for both instances, and update
the GCC clock references to use the newly added PHY nodes instead of
placeholder zeros.

> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qc=
om/eliza.dtsi
> index 357e8066c1768..f802398bc7b27 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
[ ... ]
> @@ -1784,6 +1784,369 @@ mmss_noc: interconnect@1780000 {
[ ... ]
> +		pcie0: pcie@1c00000 {
[ ... ]
> +			iommu-map =3D <0x0 &apps_smmu 0x1480 0x1>,
> +				    <0x100 &apps_smmu 0x1481 0x1>;
> +
[Severity: High]
Does pcie0 need an msi-map property defined alongside iommu-map to map PCIe
requester IDs to GIC ITS device IDs?

> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 564 IRQ_TYPE_LEVEL_HIGH>,
[Severity: Low]
This isn't a bug, but should the third 0 following the parent unit address
use the GIC_SPI macro instead of a literal 0 for the interrupt type?

> +					<0 0 0 2 &intc 0 0 0 565 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 566 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 567 IRQ_TYPE_LEVEL_HIGH>;
[ ... ]
> +		pcie1: pcie@1c08000 {
[ ... ]
> +			iommu-map =3D <0x0 &apps_smmu 0x1400 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x1>;
> +
[Severity: High]
Does pcie1 also need an msi-map property defined alongside iommu-map to map
PCIe requester IDs to GIC ITS device IDs?

> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
[Severity: Low]
This isn't a bug, but should the third 0 following the parent unit address
use the GIC_SPI macro instead of a literal 0 for the interrupt type?

> +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-eliza_evk-=
v6-0-40ece2d33114@oss.qualcomm.com?part=3D1
