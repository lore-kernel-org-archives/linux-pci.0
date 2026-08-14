Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AD3451AB;
	Fri, 14 Aug 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722743; cv=none; b=SWqa+3FxSidT1uHB6CDvRnrl8N5KM0TcAQxfBn4KN+p3epWoWaGJRuHmpHdybVjIwD8eluYdwUnCj5gxce9EYrxviaF5Q7qyrMHWBF8AXeGdt+zbcg/kQzZX5BHYe0ud6Xull2nIaVXwV1DD4n//yH6nCJ9Rn4JaTjxyiLsBUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722743; c=relaxed/simple;
	bh=8QQzG1/mwHzRsxVX5tr1cNddinL4osAuOxwEE7dGpo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D8aBHpRZXgmDNLqohfZGMNnZ7J4/Y041GPt9ccIzrFuHGfAgOCsQ6VJ+C0O0hrG8hAnG0D4ZfZnKGZD3BAqt5E79yixQjwR2PQWhZGrwgITRWDoNrQsSdaHf/RXlgzucKuVi21BKIMuz/+dve63bGdJ3ysHggvQx8r/fjXhj6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAv7J/1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAv7J/1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF30F1F000E9;
	Fri, 14 Aug 2026 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722742;
	bh=GewqV5pnJUBHyECBnwXM032L5KSTBrUeANB5d9NGtVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nAv7J/1Xt1mKAdMuCtvlN+rNSucRtyIFuAa7zlpRsHNv92M9U2wGe9ojDKhIIPyoH
	 UUHZ12gxpgWCWQuEF/V0QdxY3AdceYQTSpbqGbUEf6VkbFO666DWrUctdjP18/ev5o
	 Q/5ujixQvjTbpx9u4i22Jb5ww7Ksn0Pd2qC+hgcJPeAp+aRfzgXk75uwfv4gstkvkY
	 vbTjNbyUco0oYaBa/QG4PDjBn8t+VlTPwTpGChzkfm8frgIHeyF1i4GASD19dZ1VYm
	 j2Lj/ebe2A3wu4Chzxq9oyB/SIJ7/NCAJbNc4f0ut8CBa73AkM0W5EPgULsFmIw2ld
	 3eANiT9e5iIJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/5] arm64: tegra: Reorder reg and reg-names to
 match bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260814-tegra264-pcie-v10-4-05d08c592b05@nvidia.com>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
 <20260814-tegra264-pcie-v10-4-05d08c592b05@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:52:21 +0000
Message-Id: <20260814155221.AF30F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect register offset for PCIe Link Capabilities causes garbag=
e ICC bandwidth calculation
--

--- Patch [4]: [PATCH v10 4/5] arm64: tegra: Reorder reg and reg-names to m=
atch bindings ---
commit 1aff20381185113aa8fbe2813f31f1849b4105ad
Author: Thierry Reding <treding@nvidia.com>

arm64: tegra: Reorder reg and reg-names to match bindings

This commit reorders the "reg" and "reg-names" properties for the tegra264
PCIe controller nodes so that the ECAM region is listed last. This ensures
that the first entry matches the unit-address in the device tree nodes.

> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra264.dtsi
> index 013228a817237..ab1e83d856fd9 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3537,11 +3537,11 @@ cmdqv4: cmdqv@b200000 {
> =20
>  		pci@c000000 {
>  			compatible =3D "nvidia,tegra264-pcie";
> -			reg =3D <0xd0 0xb0000000 0x0 0x10000000>,
> -			      <0x00 0x0c000000 0x0 0x00004000>,
> +			reg =3D <0x00 0x0c000000 0x0 0x00004000>,
>  			      <0x00 0x0c004000 0x0 0x00001000>,
> -			      <0x00 0x0c005000 0x0 0x00001000>;
> -			reg-names =3D "ecam", "xal", "xtl", "xtl-pri";
> +			      <0x00 0x0c005000 0x0 0x00001000>,
> +			      <0xd0 0xb0000000 0x0 0x10000000>;
> +			reg-names =3D "xal", "xtl", "xtl-pri", "ecam";

[Severity: High]
Is the offset for XTL_RC_PCIE_CFG_LINK_CAPS in the tegra264 PCIe driver
correct? The PCIe Capability structure starts at 0x48, making the 32-bit
Link Capabilities register offset 0x48 + 0x0c =3D 0x54.

However, the driver defines it as 0x56:

drivers/pci/controller/pcie-tegra264.c:
	#define XTL_RC_PCIE_CFG_LINK_CAPS		0x56

When the link is down and the port supports hotplug, tegra264_pcie_icc_set()
calculates bandwidth using this offset:

drivers/pci/controller/pcie-tegra264.c:tegra264_pcie_icc_set() {
	...
		value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_CAPS);
		speed =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, value);
		width =3D FIELD_GET(PCI_EXP_LNKCAP_MLW, value);
	...
}

Does this readw() at offset 0x56 extract the upper 16 bits of the Link
Capabilities register instead of the lower 16 bits?

If so, this would cause FIELD_GET() to extract garbage data for both speed
and width (bits 16-19 for SLS and 20-25 for MLW), which could result in a
0 MB/s bandwidth request and starve the PCIe controller when a device is
later hotplugged.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra264-p=
cie-v10-0-05d08c592b05@nvidia.com?part=3D4
