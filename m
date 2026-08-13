Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3646335BBB
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663583; cv=none; b=CAgw6Fuw0gghA4MMcgvGDFKNkMmi0fiWlAOLda2r99bwjiI/o3tPTMNutYzxqgmPSf+t5+mCFBM3USZABIDlYZBKTov82LIY2vJLCPMv+940hIJvk1kQXpMtCpANsfWIixYH4IYe26WGYqsv9rM0b5FkSFSond1e/y8HTKMGTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663583; c=relaxed/simple;
	bh=9F0pwv1eEnHpg7mHQfeOKc24kJgmsuCcxSIPtccS0qo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G6y4rIWss9HvFCe1XVUunrHhM/zF8RjZyuxjc833WCt/KobEoeNAwrveV3jqk53I4pT9TwCXiFoLlUCTqE041kGx9/n7OFPsKxs7R0H8bkAEC7xIRdNc96OApqxcjTiFb/hP1gXsqzTgSZfTv/Q7YGjXbpsC2VpjDv5eQz4ozrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEfHOx1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEfHOx1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBB01F000E9;
	Thu, 13 Aug 2026 23:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786663581;
	bh=ZFM8pY2B/NGoyqWNVK9tBbHEa1MINwrtYry3dXuzBnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JEfHOx1y2dRW84bhg/ixisv7KdPHqzkKfRnaWRkV76It7gxsq/mJVSNd6GJ8kLbxh
	 n/SaUQNcXy/aBxde4xU8xyW9/c/2gN+g7grUn/vsVGWSDPkOG2gpQ0LRiCDu3aelOl
	 Qg7Vx+PuzDRYoCV46nqWYN9N3mBRUn8tyOmBxrVQ/hSTcd6TJfa8nBpP5esevYvtWB
	 msr8r/62NoyDEPydw4qn9zqwv8RpVBFqfxxB/fQtDJv+WwTjclXAiPMVtP1otsftBs
	 Uj/mCx1GfUrQGRMsPMxM27MOCA1Wxkr3ygnQ3sJI1hEmGQ8SpuLRelntlM+lEbhBEm
	 NTA72xjQpqSpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/14] PCI: dwc: Apply ECRC workaround to DesignWare
 5.00a as well
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260324190755.1094879-13-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-13-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:26:17 +0000
Message-Id: <20260813232621.5FBB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The ECRC workaround is not applied to the Tegra234 SoC due to an=
 incomplete hardware version check, and the updated code comments severely =
mismatch the implementation.
--

--- Patch [12]: [PATCH v8 12/14] PCI: dwc: Apply ECRC workaround to DesignW=
are 5.00a as well ---
commit b8f7e871ae3ebf76088785914137c4a00e66a2a1
Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>

PCI: dwc: Apply ECRC workaround to DesignWare 5.00a as well

This commit extends the ECRC (TLP digest) workaround, originally implemented
for DesignWare version 4.90a, to version 5.00a. It updates the ATU outbound
region programming to enable the workaround for the Tegra234 SoC.

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 5741c09dde7f4..d69db0ab3b14d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -487,7 +487,7 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pc=
ie *pci, u32 index, u32 reg
>  static inline u32 dw_pcie_enable_ecrc(u32 val)
>  {
>  	/*
> -	 * DesignWare core version 4.90A has a design issue where the 'TD'
> +	 * DWC versions 0x3530302a and 0x3536322a has a design issue where the =
'TD'

[Severity: Medium]
Does this comment accurately reflect the versions that need the workaround?
The comment lists 0x3530302a (5.00a) and 0x3536322a (5.62a), but removes
the mention of 4.90a.

This creates a discrepancy with the implementation in
dw_pcie_prog_outbound_atu() below, which still checks for 4.90a but does
not check for 5.62a.

[ ... ]

> @@ -563,7 +563,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
>  	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> -	if (dw_pcie_ver_is(pci, 490A))
> +	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
>  		val =3D dw_pcie_enable_ecrc(val);

[Severity: Medium]
Does this version check correctly apply the workaround for the Tegra234 SoC?

The commit message states that Tegra234 uses the 5.00a IP version, but
previous patches set TEGRA234_DWC_IP_VER to DW_PCIE_VER_562A (0x3536322a).

If Tegra234 is actually 5.62a, the explicit check for 500A here means the
workaround is entirely skipped for Tegra234, defeating the purpose of the
patch. Should this check also include dw_pcie_ver_is(pci, 562A) as suggested
by the updated comment above?

>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324190755.1094=
879-1-mmaddireddy@nvidia.com?part=3D12
