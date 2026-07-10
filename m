Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DFA14AD0D
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690225; cv=none; b=FrLmVIsG4mUQs1DuyqdA58rMh+Ir01yXQO8QRMMxglo9Dn8OA2fqjb8DNHYre2foKQXp+o3OHctiGMds1KOW3pZZvVcpmLADVtePK2iYmLpv4ItoLVbpCf9tgQNsUTcX8JKel1ALYQoHCfaqGQw+4LD1iLWOL0P9ETM73ePqK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690225; c=relaxed/simple;
	bh=Hgo4NljQf/hluvwgOuS0IAKkdAG8tmqDgIkokH8s8LE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ngoaE0PCO3jFYw5BntQb9kFX5yXtk+GCnDO/Mcr1g/l9YozAltA+yUTSos7LKWt1G8emFJCCEWooCSsEHy3Ph8hVl0qtB/rZ2zKQnlJBp2rhxEZGSm3+hH7mnVJwi1qhaIvXv7qXCN8TSWk4IYS1D5k+W3BphHhGbA0gtMXBXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G38pfwB0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G38pfwB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF76A1F000E9;
	Fri, 10 Jul 2026 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783690224;
	bh=VrQ0T1T8CvyCvGbO3ayxsxyFO7Fzvlh68csGfNtJeNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G38pfwB0raTu74ifabd4ZWn5MHq/cH0ZR7LwaUVJQlVHyc9uvjD84p+OembI7vaG4
	 U+gKRZTCG34H2hJXdIxsGmlESPOAKM69+K3Q+Z7IAnozWarA16Jd+DN7kih4BCHjm1
	 quUntn8jHEXRr+sO2GfW4tIWi0G6mSETJlEk3It+lHhLbr9iphIiHKYOqy5FNVMIkw
	 a7mxWdVJFLTzTtGTRaN+JVh4ifXneSkD+REDvoLWFfcT2Q9EnBIbnqlAEa2e/LrVmE
	 2JjMpOkS/3dxlJHhrQOnoHu1EmR8crsLm4l5elyndIqEYGHAx2O7gkAngPICA64SUy
	 i09M5MquiS7VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Clear Attention Button Present in Slot
 Capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710-clear_abp_0710-v1-1-efd63ebdaa09@oss.qualcomm.com>
References: <20260710-clear_abp_0710-v1-1-efd63ebdaa09@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 13:30:23 +0000
Message-Id: <20260710133023.CF76A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to fix PCIe surprise hot-plug by clearing the A=
ttention Button Present (ABP) bit, but fails to apply this fix to platforms=
 using the v2.3.3 and v2.9.0 init sequences, leaving hot-plug broken on the=
se platforms.
--

--- Patch [1]: [PATCH] PCI: qcom: Clear Attention Button Present in Slot Ca=
pabilities ---
commit 65069d64a9bc5c0ab8831d1f4774fc266f4a082e
Author: Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: PCI: qcom: Clear Attention Button Present in Slot Capabilities

Qcom PCIe Root Ports advertise the Attention Button Present (ABP) bit in
the Slot Capabilities register, but the slots have no attention button.
This patch clears the ABP bit so that presence detect changes can be
reported, allowing surprise hot-plug detection to work.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b193c989b2b80..89c2d4cb1fbeb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -372,6 +372,11 @@ static void qcom_pcie_set_slot_nccs(struct dw_pcie *=
pci)
>  	 */
>  	val =3D readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
>  	val |=3D PCI_EXP_SLTCAP_NCCS;
> +	/*
> +	 * Qcom PCIe Root Ports do not support Attention Button, so clear
> +	 * Attention Button Present in Slot Capabilities.
> +	 */
> +	val &=3D ~PCI_EXP_SLTCAP_ABP;
>  	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> =20
>  	dw_pcie_dbi_ro_wr_dis(pci);

[Severity: High]
This is a pre-existing issue, but does this fix need to cover platforms
using the v2.3.3 and v2.9.0 init sequences as well?

While this patch clears the Attention Button Present (ABP) bit in
qcom_pcie_set_slot_cap(), platforms using qcom_pcie_post_init_2_3_3() and
qcom_pcie_post_init_2_9_0() appear to bypass this fix.

Looking at drivers/pci/controller/dwc/pcie-qcom.c, these platforms use a
hardcoded macro that explicitly sets the ABP bit:

#define PCIE_CAP_SLOT_VAL			(PCI_EXP_SLTCAP_ABP | \
...

qcom_pcie_post_init_2_3_3() {
    ...
    writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
    ...
}

Will this leave PCIe surprise hot-plug broken on these platforms, since
the ABP bit remains set in their slot capabilities?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-clear_abp_=
0710-v1-1-efd63ebdaa09@oss.qualcomm.com?part=3D1
