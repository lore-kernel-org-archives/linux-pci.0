Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609BA3DCDAD;
	Thu, 30 Jul 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414267; cv=none; b=aIurPI68WM7Y/P9DnsIjtLwKK1/mLFr3ZrChYB0Ug/PeKMnOayKTCV7kdYofgK9J4XcFsSdpBfGueMcVMMKbCneZpAnlJTxf/DuEtB/1Zs0ReyMVgRbGAomQyL/iF92s7kurCz9cSTR56BY3yga4U+3e4r/DIdFDjFNSBJ1ojhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414267; c=relaxed/simple;
	bh=UviIQxvgtKFFSW3oftrOqRuY1rhBOm+3A4h9KHMHt/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jZNCv9Khdj+6BAwpedi1w3sJzI9S/cKeIKhadTS6DF/5f0Q/ZH8BucTPJ4OdwI9bhzjUBa6Psr3bl1iJI6Q1ogaJyLvuX1XjZAp69tYkqE7GGsn9F/6pHZVD9i+kfgPGtUtTvAQqJFKzKuMSBzELSHPcBfNHKX3uwlfuDn0U8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPTkLQ7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPTkLQ7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3441F000E9;
	Thu, 30 Jul 2026 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414266;
	bh=JW/+m7nP9jt8LI6+VJqIAEQu/MJ9gQeroSdIO2wTu30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BPTkLQ7TBSLiVwsl9exRf9s6ew9+Dmot094NwK+oXOfBgk7dshD6ZjHJCLf7vin7H
	 VRxw6sqPVtjxHloCf6x9dbU81BGd0b/PSI5MmZHebAOmISxOm96n5LxzHebaO1mdaZ
	 Zn/wqM6AsP3INCUK7zxRb7lD1TXcXswDSWFmIxTZPtaeTmGvi8AadfTJJfhvjeQHCe
	 eQPhTDidyAKIK6s0T9cOJC+UhSqbnICel+HTx6M860rrlQ5vDQjsv90KlbvUS8SFIc
	 16TYS4gLsdQZKq+mFu7DOGj6Q2vyF3Of4Xi5WJX1fZ+FhAFE7PRVNNvfByVuT7GuKK
	 U5hWAhfdQD1jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260730-eliza_evk-v7-3-7ac7b66a3e6d@oss.qualcomm.com>
References: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
 <20260730-eliza_evk-v7-3-7ac7b66a3e6d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:24:25 +0000
Message-Id: <20260730122425.AF3441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `iommu-map` entries use 5 cells per entry, but the QCOM PCIe d=
river statically expects 4 cells, leading to misaligned array parsing and c=
orrupted BDF-to-SID hardware programming.
--

--- Patch [3]: [PATCH v7 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with T=
C9563 PCIe switch ---
commit c160148a8023cba78403658572ab0eddfe6fb1b7
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

This commit enables PCIe1 on the Eliza EVK board connected to a TC9563
PCIe switch. It configures the management interface over I2C and overrides
the base iommu-map to cover the downstream ports.

> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dt=
s/qcom/eliza-evk.dtsi
> index b35fffb509765..ccd6f01135132 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi

[ ... ]

> @@ -99,6 +119,91 @@ pcieport0_ep: endpoint {
>  	};
>  };
> =20
> +&pcie1 {
> +	iommu-map =3D <0x0 &apps_smmu 0x1400 0x0 0x1>,
> +		    <0x100 &apps_smmu 0x1401 0x0 0x1>,

[Severity: High]
Will this iommu-map configuration cause corrupted BDF-to-SID hardware
programming?

Looking at qcom_pcie_config_sid_1_9_0() in pcie-qcom.c, the driver reads the
iommu-map property directly into a structure that statically expects exactly
4 fields (bdf, phandle, smmu_sid, smmu_sid_len).

Because these new entries provide 5 cells per tuple (to satisfy apps_smmu
expecting 2 cells), the array parsing will become misaligned after the
first tuple. The second tuple's bdf value will erroneously read the length
field of the first tuple (0x1) instead of 0x100.

This misalignment corrupts the subsequent entries programmed into the
PARF_BDF_TO_SID_TABLE, which leads to SMMU faults for all downstream
devices connected to the switch.

> +		    <0x208 &apps_smmu 0x1402 0x0 0x1>,
> +		    <0x210 &apps_smmu 0x1403 0x0 0x1>,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-eliza_evk-=
v7-0-7ac7b66a3e6d@oss.qualcomm.com?part=3D3
