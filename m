Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573733B059F;
	Wed, 29 Jul 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338023; cv=none; b=MFpturattf8kVbmWQEKbwHKsSXn6ADzm9lzVvHujpJeZn3fjhFbZFxFdm8GMVDRHjwxSSTQXVY2SD0OkvCylYZDgAX41hIS4Hf8yhPjOQzv0N3jF6YmXj0zYMf06BAb0WKPMFgEGPS8j76mBu8bj4wjeAoGhbQgT8YRK9IRamaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338023; c=relaxed/simple;
	bh=pGORuI9uWBPE6SrtM8pIJc5RxPHklCuXUVxXEuj2shM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJFrl/SEoB0A3BwFxv65TzJdFgEVfmIKop7ftEnrU/WrtnlrubC+gDvRETRH0pi2yWFAXUkePn16gGGdBSbHy/g9zsTfyKhrPZnVjuLDV5ePb1PwPv1ObpNrvtNgKOL7L5oFaUj8TW6KVkyZz/h1Dd78Lw3mOycrY9S3Ln3G8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAMRDOvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAMRDOvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4A31F000E9;
	Wed, 29 Jul 2026 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785338022;
	bh=f9iBVWcCwzJLN3H4CJ0Xcr/BUCB6B5BBaMwIvUDxDds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AAMRDOvX0utE+qT94+D2J3qCERV5whFBMlb9U3ONwFboXnfT8z7WxGDzfwQRA+ppN
	 GHc+xvrkjDCaErWo7VOIeraEqbUCPcOx78Rw4pMvZ9EvsnEZ8Imt1gVcxp3o+R9E6q
	 XJHj1tMk7hZbUpSZtYxahKDZLZhq/iv7VrfcVUHrr2f6h84GIrvpSjIeMlDtp5s4cR
	 ckeyVojG5FmPrSCUl0VKaDcIoMPi6xR3Z2ib8s1cJzaplZS06uE8i+YdB8E3qfmVmm
	 TmzrAsTeWXo7nXaASCuiPY2dzs+ZmTFxEuPt/6cN1Lucrg3i8SQXe6B3DXuPYrT47J
	 G4vALAuLZNkqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260729-eliza_evk-v5-1-41790a5a24de@oss.qualcomm.com>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
 <20260729-eliza_evk-v5-1-41790a5a24de@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:13:41 +0000
Message-Id: <20260729151341.9C4A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `interrupts`, `interrupt-map`, and `iommu-map` properties are =
swapped between the `pcie0` and `pcie1` device tree nodes.
--

--- Patch [1]: [PATCH v5 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and con=
troller nodes ---
commit da247ac5c4684b405ce8a69950ea44574f919a8d
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes

Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
(PCIe1). This commit adds PCIe controller and PHY nodes for both instances,
and updates the GCC clock references to use the new PHY nodes.

> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qc=
om/eliza.dtsi
> index 357e8066c1768..31835a5828834 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
[ ... ]
> +		pcie0: pcie@1c00000 {
[ ... ]
> +			interrupts =3D <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
[ ... ]
> +			iommu-map =3D <0 &apps_smmu 0x1480 0x1>,
> +				    <0x100 &apps_smmu 0x1481 0x1>;
> +
> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 564 IRQ_TYPE_LEVEL_HIGH>,

[Severity: High]
Are the interrupts, interrupt-map, and iommu-map properties swapped between
pcie0 and pcie1?

Here pcie0 (at hardware base 0x01c00000) is assigned interrupts 376+,
interrupt-map 564+, and IOMMU stream ID 0x1480, which are typically
hardwired to the pcie1 block.

[ ... ]
> +		pcie1: pcie@1c08000 {
[ ... ]
> +			interrupts =3D <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
[ ... ]
> +			iommu-map =3D <0 &apps_smmu 0x1400 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x1>;
> +
> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,

[Severity: High]
Similarly, pcie1 (at hardware base 0x01c08000) is assigned interrupts 141+,
interrupt-map 149+, and IOMMU stream ID 0x1400.

Does this cause SMMU translation faults during DMA and dropped interrupts f=
or
both PCIe controllers by assigning pcie0's hardware mappings to pcie1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-eliza_evk-=
v5-0-41790a5a24de@oss.qualcomm.com?part=3D1
