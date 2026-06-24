Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE52494D8
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296768; cv=none; b=gPHzuIYqcPU89pYYtDuv0XqaWjqUndmzgQ/GQwieQRQWLljlMj7l5aDsIaeqY111GFHIuzK+63QdtaQp/U3C93Yjghe9l88xQpNTOmU2Gdo7MrTERLOiVHtE+ZL6tKqFz7c6mmxvCwNH2jVHIArLb6xYmEssg21JScESXpGa7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296768; c=relaxed/simple;
	bh=5AwehKEU9aSv59sFPGKUKEAGpRnyqJ0KRzdi2nGHx3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qQdifu9tczZ7DCzra2isHcLoeQP/+wTNoJ3iaebrrME36CBtKEULtB/o/R6NQkc1eu64KU0E5v0DdzczPyTxgQV//tqk78Z019QjLE9EYSJATKG/6bHBntg7IxxtQnOhu7ZqjJWnZuAGr3iuVZ6DzvlRQInkxQDckYsjF8Ngw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1LtyWhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1LtyWhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D9C1F000E9;
	Wed, 24 Jun 2026 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782296767;
	bh=ENXmkJIpaFQZfbLg7psi6LqW4/rDUJzi+xrFkTcsvLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C1LtyWhEKr88pvnXtVo7oOjjM4k/rcgQoRcNiySv6CxJvV5ymP5bCaa8Cmhi+lPJi
	 0EIkVe8vUrkeoBWMmBDYYc7NclbShTg3JCdBwuBoYgkdV2Wcw1x6UCY7VX8kBbyu+W
	 hzljg8Sz158GEk0wDTT+S3xlYHLchCilMyeRORkYnvqflvyp/WKV9n5eIdTQ80sRTF
	 SHC7ZiZFTU/3rSqWhiX+pNV//iQfq7RdSrSJ2qeKyFiziVwmqm0DgUdUzGEzaQJlPw
	 9eG6WXxkZqLVk6pzkQWeUpvKIWdJZ22f92wV8gqHGvKm1DS7+Jnjq/m+ZvrPef41OS
	 j48Vbo+E+qD6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260624-aspm-v2-1-800a4151ba3a@oss.qualcomm.com>
References: <20260624-aspm-v2-1-800a4151ba3a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 10:26:06 +0000
Message-Id: <20260624102607.22D9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Modifying ASPM L1 PM Substates without first disabling ASPM L1 vio=
lates PCIe specifications.
- [Medium] The 'aspm-no-l1' override removes L1SS software support but fail=
s to clear firmware-enabled L1SS hardware state.
--

commit 0343a07bd629cd03e625683fa27781cd434b46f3
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI/ASPM: Mask ASPM states based on Devicetree properties

This commit updates ASPM link initialization to check for Devicetree
properties like 'aspm-no-l0s', 'aspm-no-l1', and 'aspm-no-l1ss'. It masks
the corresponding ASPM states from the link support mask before applying
the default ASPM policy.

Link [1]: https://github.com/devicetree-org/dt-schema/pull/188
Link [2]: https://github.com/devicetree-org/dt-schema/pull/190

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 925373b98dff0..a79426b5bff0f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

> @@ -806,6 +815,24 @@ static void pcie_aspm_override_default_link_state(st=
ruct pcie_link_state *link)
> =20
>  	/* For devicetree platforms, enable L0s and L1 by default */
>  	if (of_have_populated_dt()) {
> +		if (pcie_link_has_aspm_override(link, "aspm-no-l0s"))
> +			link->aspm_support &=3D ~PCIE_LINK_STATE_L0S;
> +
> +		if (pcie_link_has_aspm_override(link, "aspm-no-l1"))
> +			link->aspm_support &=3D ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);

[Severity: Medium]
If the devicetree has 'aspm-no-l1' but not 'aspm-no-l1ss', this clears
PCIE_LINK_STATE_L1SS from the link's aspm_support. Will this cause
pcie_config_aspm_link() to skip updating the L1SS registers because
aspm_capable lacks L1SS?

Should this branch also explicitly clear the hardware state via
pcie_config_aspm_l1ss(link, 0) in the same way the 'aspm-no-l1ss' branch
does, to prevent leaving a firmware-enabled L1SS configuration active in
hardware?

> +
> +		if (pcie_link_has_aspm_override(link, "aspm-no-l1ss")) {
> +			/*
> +			 * Clear L1SS in hardware before updating aspm_support. Once
> +			 * aspm_capable is derived from aspm_support, pcie_config_aspm_link()
> +			 * skips pcie_config_aspm_l1ss() entirely via the aspm_capable guard,
> +			 * leaving firmware-enabled L1SS substates active in hardware.
> +			 */
> +			if (link->aspm_enabled & PCIE_LINK_STATE_L1SS)
> +				pcie_config_aspm_l1ss(link, 0);

[Severity: High]
Does modifying the L1SS registers here violate PCIe specifications by
changing L1 PM Substates while ASPM L1 is still enabled?

Looking at the caller pcie_aspm_cap_init(), the original PCI_EXP_LNKCTL
values are restored right before calling pcie_aspm_override_default_link_st=
ate(),
which can re-enable ASPM L1 if the firmware had it enabled:

pcie_aspm_cap_init() {
    ...
    if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
        FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
        pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
        pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
    }
    ...
    pcie_aspm_override_default_link_state(link);
}

Since PCIe r6.2 sec 5.5.4 requires disabling ASPM L1 first, is there
a risk of undefined hardware behavior or link drops here?

> +			link->aspm_support &=3D ~PCIE_LINK_STATE_L1SS;
> +		}
> +
>  		if (link->aspm_support & PCIE_LINK_STATE_L0S)
>  			link->aspm_default |=3D PCIE_LINK_STATE_L0S;
>  		if (link->aspm_support & PCIE_LINK_STATE_L1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-aspm-v2-1-=
800a4151ba3a@oss.qualcomm.com?part=3D1
